// SPDX-License-Identifier: AGPL-3.0-or-later
//
// Copyright (C) 2021-2022 Dai Foundation
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU Affero General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU Affero General Public License for more details.
//
// You should have received a copy of the GNU Affero General Public License
// along with this program.  If not, see <https://www.gnu.org/licenses/>.

pragma solidity 0.6.12;
pragma experimental ABIEncoderV2;

import "dss-exec-lib/DssExecLib.sol";
import "dss-interfaces/dss/ChainlogAbstract.sol";


contract DssSpellCollateralOnboardingAction {

    // --- Rates ---
    uint256 constant ZERO_PCT_RATE = 1000000000000000000000000000;

    // Many of the settings that change weekly rely on the rate accumulator
    // described at https://docs.makerdao.com/smart-contract-modules/rates-module
    // To check this yourself, use the following rate calculation (example 8%):
    //
    // $ bc -l <<< 'scale=27; e( l(1.08)/(60 * 60 * 24 * 365) )'
    //
    // A table of rates can be found at
    //    https://ipfs.io/ipfs/QmTRiQ3GqjCiRhh1ojzKzgScmSsiwQPLyjhgYSxZASQekj
    //

    // --- Math ---
    uint256 constant BILLION = 10 ** 8;
    uint256 constant MILLION = 10 ** 6;
    uint256 constant RAY     = 10 ** 27;

    // --- DEPLOYED COLLATERAL ADDRESSES ---

    address constant DUMMY                 = 0xa3C21F23a782a0ACf0593ad6ECE57eFe353b966d;
    address constant PIP_DUMMY             = 0xE8DBa19a6bCe486cAd0Cae4ce34eC9Dd01668e03;
    address constant MCD_JOIN_DUMMY_DBK      = 0x2980B0f694c4bf65E05DBDf9812173Ac622E4890;
    address constant MCD_CLIP_DUMMY_DBK      = 0x930584650149D7579E21Aff84dd710d3028Ce002;
    address constant MCD_CLIP_CALC_DUMMY_DBK = 0x9f361C1Fa8B28f5206eEB06c7085D85a2d87672a;

    function onboardNewCollaterals() internal {
        // ----------------------------- Collateral onboarding -----------------------------
        //  Add ______________ as a new Vault Type
        //  Poll Link:

        DssExecLib.addNewCollateral(
            CollateralOpts({
                ilk:                   'DUMMY-DBK',
                gem:                   DUMMY,
                join:                  MCD_JOIN_DUMMY_DBK,
                clip:                  MCD_CLIP_DUMMY_DBK,
                calc:                  MCD_CLIP_CALC_DUMMY_DBK,
                pip:                   PIP_DUMMY,
                isLiquidatable:        false,
                isOSM:                 false,
                whitelistOSM:          true,
                ilkDebtCeiling:        1000 * BILLION,
                minVaultAmount:        1000,
                maxLiquidationAmount:  3 * MILLION,
                liquidationPenalty:    1300, // 13% penalty fee
                ilkStabilityFee:       ZERO_PCT_RATE, 
                startingPriceFactor:   13000, // Auction price begins at 130% of oracle price
                breakerTolerance:      5000, // Allows for a 50% hourly price drop before disabling liquidations
                auctionDuration:       140 minutes,
                permittedDrop:         4000,  // 40% price drop before reset
                liquidationRatio:      16000, // 160% collateralization ratio
                kprFlatReward:         300, // 300 Dai
                kprPctReward:          10  // 0.1% of the purchased amount
            })
        );

        DssExecLib.setStairstepExponentialDecrease(
            MCD_CLIP_CALC_DUMMY_DBK,
            90 seconds,
            9900
        );

        DssExecLib.setIlkAutoLineParameters(
            'DUMMY-DBK',
            100 * MILLION,
            50 * MILLION, 
            1 hours
        );

        // ChainLog Updates
        // Add the new flip and join to the Chainlog
        address CHAINLOG = DssExecLib.LOG;
        ChainlogAbstract(CHAINLOG).setAddress("DUMMY", DUMMY);
        ChainlogAbstract(CHAINLOG).setAddress("PIP_DUMMY", PIP_DUMMY);
        ChainlogAbstract(CHAINLOG).setAddress("MCD_JOIN_DUMMY_DBK", MCD_JOIN_DUMMY_DBK);
        ChainlogAbstract(CHAINLOG).setAddress("MCD_CLIP_DUMMY_DBK", MCD_CLIP_DUMMY_DBK);
        ChainlogAbstract(CHAINLOG).setAddress("MCD_CLIP_CALC_DUMMY_DBK", MCD_CLIP_CALC_DUMMY_DBK);
    }
}
