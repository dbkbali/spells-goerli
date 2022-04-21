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

Deployed Spell on 04/19/2022: Tx: 0x3b792884891c36d1dbb9c23ad23e14ee88c241a008eb1ea99e419963cb9727e6
Contract Created: 0x3343868aE1820C7fB719D9B96C99762447A69C7A

Goerli Spell Cast: https://goerli.etherscan.io/address/0x3343868aE1820C7fB719D9B96C99762447A69C7A