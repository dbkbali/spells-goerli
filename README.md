# ces-spells-goerli

![Build Status](https://github.com/makerdao/spells-goerli/actions/workflows/.github/workflows/tests.yaml/badge.svg?branch=master)

Staging repo for MakerDAO's Collateral Engineering Services Goerli executive spells.

## Instructions

### Getting Started

```bash
$ git clone git@github.com:clio-finance/ces-spells-goerli.git
$ dapp update
```

### Adding Collaterals to the System

After adding GemJoin Clipper and Clip Calc Adapters. Each of these will need to authorize the MCD_PAUSE_PROXY for the implementation.

Authorization for Adapter:

```
# GEMJOIN
MCD_PAUSE_PROXY=<MCD_PAUSE_PROXY address>
MCD_JOIN_DUMMY_DBK=<MCD_JOIN_DUMMY_DBK address>
seth send $MCD_JOIN_DUMMY_DBK "rely(address)" $MCD_PAUSE_PROXY

# CLIP
MCD_CLIP_DUMMY_DBK=<MCD_CLIP_DUMMY_DBK address>
seth send $MCD_CLIP_DUMMY_DBK "rely(address)" $MCD_PAUSE_PROXY

#CLIP_CALC
MCD_CLIP_CALC_DUMMY_DBK=<MCD_CLIP_CALC_DUMMY_DBK address>
seth send $MCD_CLIP_CALC_DUMMY_DBK "rely(address)" $MCD_PAUSE_PROXY
```

If the weekly executive needs to onboard a new collateral:

1. Update the `onboardNewCollaterals()` function in `DssSpellCollateralOnboarding.sol`.
2. Update the values in `src/tests/collaterals.sol`
3. uncomment the `onboardNewCollaterals();` in the `actions()` function in `DssSpellAction`

### Build

```bash
$ make
```

### Test (DappTools with Optimizations)

Set `ETH_RPC_URL` to a Goerli node.

```bash
$ export ETH_RPC_URL=<Goerli URL>
$ make test
```

### Test (Forge without Optimizations)

#### Prerequisites
1. [Install](https://www.rust-lang.org/tools/install) Rust.
2. [Install](https://github.com/gakonst/foundry#forge) Forge.

#### Operation
Set `ETH_RPC_URL` to a Goerli node.

```
$ export ETH_RPC_URL=<Goerli URL>
$ make test-forge
```

### Deploy

Set `ETH_RPC_URL` to a Goerli node and ensure `ETH_GAS` is set to a high enough number to deploy the contract.

```bash
$ export ETH_RPC_URL=<Goerli URL>
$ export ETH_GAS=8000000
$ export ETH_GAS_PRICE=$(seth --to-wei 3 "gwei")
$ make deploy

```

## Token approval

We do not transfer ERC-20 tokens manually to the MCD adapters – instead we give approval for the adapters to using some of our ERC-20 tokens. The following section will take us through the necessary steps.

In this example, we are going to use 5 WBTC tokens to draw 15000 DAI. You may of course use different amounts, just remember to change it accordingly in the function calls of this guide, while ensuring that you are within the accepted collateralization ratio (`mat`) of a WBTC Vault and the minimum vault debt (`dust`) – respectively, `145%` and `15000` DAI at the time of this writing.

Let’s approve the use of 5 WBTC tokens for the adapter, and then call the `approve` function of the WBTC token contract with the right parameters. Again, we have to do some conversions:

```bash
export DUMMY=0xa3C21F23a782a0ACf0593ad6ECE57eFe353b966d
export DUMMY_DECIMALS=18
export MCD_JOIN_DUMMY_DBK=0xB94e246BC9945AFf7f940A32d4B33180eB8B3F74
seth send $DUMMY 'approve(address, uint256)' $MCD_JOIN_DUMMY_DBK $(seth --from-fix $DUMMY_DECIMALS 500000)
```

If we want to be sure that our approval transaction succeeded, we can check the results with this command:

```bash
seth call $DUMMY 'allowance(address, address)(uint256)' $ETH_FROM $MCD_JOIN_DUMMY_DBK | \
    seth --to-fix $DUMMY_DECIMALS
```

Output:

`5.00000000`

## Finally interacting with the Maker Protocol contracts

In order to better understand the MCD contracts, the following provides a brief explanation of relevant terms.

- `wad`: token unit amount
- `gem`: collateral token adapter
- `ilk`: Vault type
- `urn`: Vault record – keeps track of a Vault
- `ink`: rate \* wad represented in collateral
- `dink`: delta ink – a signed difference value to the current value
- `art`: rate \* wad represented in DAI
- `dart`: delta art – a signed difference value to the current value
- `lad`: Vault owner
- `rat`: collateralization ratio.

After giving permission to the WBTC adapter of MCD to take some of our tokens, it’s time to finally start using the MCD contracts.

We'll be using the [CDP Manager](https://github.com/makerdao/dss-cdp-manager) as the preferred interface to interact with MCD contracts.

We begin by opening an empty Vault, so we can use it to lock collateral into. For this we need to define the type of collateral (WBTC-A) we want to lock in this Vault:

```bash
export ilk=$(seth --to-bytes32 $(seth --from-ascii "DUMMY-DBK"))
```

Now let’s open the Vault:

```bash
seth send $CDP_MANAGER 'open(bytes32, address)' $ilk $ETH_FROM
```

We need the `cdpId` and `urn` address of our open Vault, so we can interact with the system:

```bash
export cdpId=$(seth call $CDP_MANAGER 'last(address)(uint256)' $ETH_FROM)
export urn=$(seth call $CDP_MANAGER 'urns(uint256)(address)' $cdpId)
```

After acquiring `cdpId` and `urn` address, we can move to the next step: locking our tokens into the system.

First we are going to make a transaction to the WBTC adapter to actually take 5 of our tokens with the join contract function.
The contract function looks like the following: `join(address urn, uint256 amt)`.

- The first parameter is the `urn`, our vault address
- The second parameter is the token amount.

For the sake of readability, we set the `amt` parameter representing the amount of collateral:

```bash
export amt=$(seth --from-fix $DUMMY_DECIMALS 500000)
```

Then use the following command to use the join function, thus taking 5 WBTC from our account and sending to `urn` address.

```bash
seth send $MCD_JOIN_DUMMY_DBK 'join(address, uint256)' $urn $amt
```

**ℹ️ NOTICE:** From this point on, the [join-5](https://goerli.etherscan.io/address/0x3cbE712a12e651eEAF430472c0C1BF1a2a18939D#code) adapter already took care of the fact that WBTC has only 8 decimals, so we can proceed with `wad` normally.

Inside the `Vat`, different parameters have different decimal precisions:

- `dai`: 45 decimals `[rad]`
- `rate`: 27 decimals `[ray]`
- `dink`: 18 decimals `[wad]`.
- `dart`: 18 decimals `[wad]`.
- ...

Learn more about naming in MCD [here](https://github.com/makerdao/dss/wiki/Glossary#general).

We can check the results with the contract function: `gem(bytes32 ilk, address urn)(uint256)` with:

```bash
seth call $MCD_VAT 'gem(bytes32, address)(uint256)' $ilk $urn | seth --from-wei
```

The output should look like this:

`5.000000000000000000`

An optional, but recommended step is to invoke `jug.drip(ilk)` to make we are not paying undue stability fees.

```bash
seth send $MCD_JUG 'drip(bytes32)' $ilk
```

 For more details, please see the guide [Intro to the Rate mechanism](../intro-rate-mechanism/intro-rate-mechanism.md).

The next step is adding the collateral into an urn. This is done through the `CDP Manager` contract.

The function is called `frob(uint256, uint256, uint256)`, which receives the following parameters:

- `uint256 cdp`: the `cdpId`
- `int256 dink`: delta ink (collateral) `[wad]`
- `int256 dart`: delta art (Dai). `[wad]`

If the `frob` operation is successful, it will adjust the corresponding data in the protected `vat` module. When adding collateral to an `urn`, `dink` needs to be the (positive) amount we want to add and `dart` needs to be the (positive) amount of DAI we want to draw. 

Let’s add our 5 WBTC to the urn, and draw 15000 DAI ensuring that the position is overcollateralized.
We already set up `cdp` before, so we only need to set up `dink` (WBTC deposit) and `dart` (DAI to be drawn):

**ℹ️ NOTICE:** The `Vat` uses an internal `dai` representation called “normalized art” that is useful to calculate accrued stability fees.
To convert the Dai amount to normalized art, we have to divide it by the current ilk `rate`:

```bash
export WAD_DECIMALS=18
export RAY_DECIMALS=27
export RAD_DECIMALS=45

export dink=$(seth --to-wei 500000 eth)
export rate=$(seth call $MCD_VAT \
    'ilks(bytes32)(uint256 Art, uint256 rate, uint256 spot, uint256 line, uint256 dust)' $ilk | \
    sed -n 2p | seth --to-fix $RAY_DECIMALS)
export dart=$(bc<<<"scale=${WAD_DECIMALS}; art=(400000/$rate*10^${WAD_DECIMALS}+1); scale=0; art/1")
```

With the variables set, we can call `frob`:
```bash
seth send $CDP_MANAGER 'frob(uint256, int256, int256)' $cdpId $dink $dart
```

Now, let’s check out our internal DAI balance to see if we have succeeded. We can use the `vat` function `dai(address urn)(uint256)`:

```bash
seth call $MCD_VAT 'dai(address)(uint256)' $urn | seth --to-fix $RAD_DECIMALS
```

The output should look like this (The result isn't exactly 15000 Dai because of number precision):

`15000.000000000000000000384361909233192325560636045`

Now this DAI is minted, but the balance is still technically owned by the DAI adapter of MCD.

If we actually want to use it, we have to transfer it to our account:

```bash
export rad=$(seth call $MCD_VAT 'dai(address)(uint256)' $urn)
seth send $CDP_MANAGER 'move(uint256, address, uint256)' $cdpId $ETH_FROM $rad
```

**ℹ️ NOTICE:** Here, `rad`, is the total amount of DAI available in the `urn`. We are reading this number to get all the DAI possible.

We now allow the Dai adapter to move Dai from VAT to our address:

```bash
seth send $MCD_VAT 'hope(address)' $MCD_JOIN_DAI
```

And finally we exit the internal `dai` to the ERC-20 DAI:

```bash
seth send $MCD_JOIN_DAI 'exit(address, uint256)' $ETH_FROM $(seth --to-wei 400000 eth)
```

And to check the DAI balance of our account:

```bash
seth call $MCD_DAI 'balanceOf(address)(uint256)' $ETH_FROM | seth --from-wei
```

Expected output:

`15000.000000000000000000`

If everything checks out, congratulations: you have just acquired some multi-collateral DAI on Goerli!

## Paying back DAI debt to release collateral

To pay back your DAI and release the locked collateral, follow the following steps. 

**⚠️ ATTENTION:** Please make sure to **obtain some additional Dai** (from another account or from another vault) because chances are interest will have accumulated in the meantime.

To force stability fee accumulation, anyone can invoke `jug.drip(ilk)`:

```bash
seth send $MCD_JUG 'drip(bytes32)' $ilk
```

First thing is to determine what is our debt, including the accrued stability fee:

```bash
export WAD_DECIMALS=18
export RAY_DECIMALS=27
export RAD_DECIMALS=45

export art=$(seth call $MCD_VAT 'urns(bytes32, address)(uint256 ink, uint256 art)' $ilk $urn | \
    sed -n 2p | seth --from-wei)
export rate=$(seth call $MCD_VAT \
    'ilks(bytes32)(uint256 Art, uint256 rate, uint256 spot, uint256 line, uint256 dust)' $ilk | \
    sed -n 2p | seth --to-fix $RAY_DECIMALS)
export debt=$(bc<<<"${art}*${rate}")
export debtWadRound=$(bc<<<"(${art}*${rate}*10^${WAD_DECIMALS})/1 + 1")
```

- `art`: internal vault debt representation `[wad]`
- `rate`: accumulated stability fee from the system `[ray]`
- `debt`: vault debt in Dai `[rad]`
- `debtWadRound`: vault debt added by 1 wad to avoid rounding issues `[wad]`.

Then we need to approve the transfer of DAI tokens to the adapter. Call the `approve` function of the DAI ERC-20 token contract with the right parameters:

```bash
seth send $MCD_DAI 'approve(address, uint256)' $MCD_JOIN_DAI $debtWadRound
```

If we want to be sure that our approval transaction succeeded, we can check the results with this command:

```bash
seth call $MCD_DAI 'allowance(address, address)(uint256)' $ETH_FROM $MCD_JOIN_DAI | seth --from-wei
```

Output:

`15000.041850037339693452`

Now to actually join the Dai to the adapter:

```bash
seth send $MCD_JOIN_DAI 'join(address, uint256)' $urn $debtWadRound
```

To make sure it all worked:

```bash
seth call $MCD_VAT 'dai(address)(uint256)' $urn | seth --to-fix $RAD_DECIMALS
```

Output:

`15000.041850037339693452000000000000000000000000000`

Now, onto actually getting our collateral back. `dart` and `dink`, as the `d` in their abbreviation stands for delta, are inputs for changing a value, and thus they can be negative. When we want to lower the amount of DAI drawn from the `urn`, we lower the art parameter of the `urn`.

We only need to set up the `dink` and `dart` variables.

```bash
dink=$(seth --to-int256 -$(seth --to-wei 100000 eth))
dart=$(seth --to-int256 -$(seth --to-wei $art eth))
```

Again, we need to use the `frob` operation to change these parameters `frob(uint256 cdpId, address from, int dink, int dart)`:

```bash
seth send $CDP_MANAGER 'frob(uint256, int256, int256)' $cdpId $dink $dart
```

This doesn’t mean we have already got back your tokens yet. Our account’s WBTC balance is not yet back to the original amount:

```bash
seth call $DUMMY 'balanceOf(address)(uint256)' $ETH_FROM | seth --to-fix $DUMMY_DECIMALS
```

Output:

`0.00000000`

The WBTC is still assigned to the Vault, so we need to move them to our address:

```bash
export wad=$(seth --to-wei 100000 eth)
seth send $CDP_MANAGER 'flux(uint256, address, uint256)' $cdpId $ETH_FROM $wad
```

**ℹ️ NOTICE:** We are about to interact with the [join-5](https://goerli.etherscan.io/address/0x3cbE712a12e651eEAF430472c0C1BF1a2a18939D#code) adapter once again, so we need to bring `$WBTC_DECIMALS` back into the equation.

From there exit the WBTC adapter to get back our tokens:

```bash
export WBTC_DECIMALS=8

export amt=$(seth --from-fix $DUMMY_DECIMALS 100000)
seth send $MCD_JOIN_DUMMY_DBK 'exit(address, uint256)' $ETH_FROM $amt
```

If we check the balance again:

```bash
seth call $DUMMY 'balanceOf(address)(uint256)' $ETH_FROM | seth --to-fix $DUMMY_DECIMALS
```

Output:

`5.00000000`

Yay, you got back your tokens! If you have come this far, congratulations, you have finished paying back the debt of your Vault in Multi-Collateral Dai and getting back the collateral.

Spend those freshly regained test WBTC tokens wisely!