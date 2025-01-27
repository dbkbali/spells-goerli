#!/usr/bin/env bash
set -e

[[ "$(seth chain --rpc-url="$ETH_RPC_URL")" == "goerli" ]] || { echo "Please set a Goerli ETH_RPC_URL"; exit 1; }

[ -z "$ETH_FROM" ] && {
    echo "Please set a ETH_FROM env var"
    exit 1
}

### ChainLog
CHANGELOG=0x672f51B1040898dd3b24c7075112241213faD588
MCD_ADM=$(seth call "$CHANGELOG" 'getAddress(bytes32)(address)' "$(seth --to-bytes32 "$(seth --from-ascii "MCD_ADM")")")
MCD_GOV=$(seth call "$CHANGELOG" 'getAddress(bytes32)(address)' "$(seth --to-bytes32 "$(seth --from-ascii "MCD_GOV")")")
MCD_IOU=$(seth call "$CHANGELOG" 'getAddress(bytes32)(address)' "$(seth --to-bytes32 "$(seth --from-ascii "MCD_IOU")")")

### Data
DESIRED_HAT_APPROVALS=$(seth --to-wei 100000 ETH)
hat=$(seth call "$MCD_ADM" 'hat()(address)')
approvals=$(seth call "$MCD_ADM" 'approvals(address)(uint256)' "$hat")
deposits=$(seth call "$MCD_ADM" 'deposits(address)(uint256)' "$ETH_FROM")

if [[ -z "$1" ]]; then
    echo "Please specify the Goerli Spell Address"
else
    target=$DESIRED_HAT_APPROVALS
    if [[ "$(echo "$approvals + 1 >= $target" | bc)" == 1 ]]; then
        target=$(echo "$approvals + 1" | bc)
    fi

    if [[ "$(echo "$deposits < $target" | bc)" == 1 ]]; then
        lockAmt=$(echo "$target - $deposits" | bc)
        [[ "$(echo "$(seth call "$MCD_GOV" 'balanceOf(address)(uint256)' "$ETH_FROM") >= $lockAmt" | bc)" == 1 ]] || { echo "$ETH_FROM: Insufficient MKR Balance"; exit 1; }

        seth send "$MCD_GOV" 'approve(address,uint256)' "$MCD_ADM" "$lockAmt"
        seth send "$MCD_ADM" 'lock(uint256)' "$lockAmt"

        deposits=$(seth call "$MCD_ADM" 'deposits(address)(uint256)' "$ETH_FROM")
    fi

    seth send "$MCD_ADM" 'vote(address[] memory)' ["$1"]
    seth send "$MCD_ADM" 'lift(address)' "$1"

    seth send "$1" 'schedule()'

    sleep 120

    seth send "$1" 'cast()'

    if [[ "$(echo "$deposits > $DESIRED_HAT_APPROVALS" | bc)" == 1 ]]; then
        freeAmt=$(echo "$deposits - $DESIRED_HAT_APPROVALS" | bc)
        [[ "$(echo "$(seth call "$MCD_IOU" 'balanceOf(address)(uint256)' "$ETH_FROM") >= $freeAmt" | bc)" == 1 ]] || { echo "$ETH_FROM: Insufficient IOU Balance"; exit 1; }
        seth send "$MCD_IOU" 'approve(address,uint256)' "$MCD_ADM" "$freeAmt"
        seth send "$MCD_ADM" 'free(uint256)' "$freeAmt"
    fi

    echo "Goerli Spell Cast: https://goerli.etherscan.io/address/$1"
fi
