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
// Enable ABIEncoderV2 when onboarding collateral
pragma experimental ABIEncoderV2;
import "dss-exec-lib/DssExec.sol";
import "dss-exec-lib/DssAction.sol";
import "dss-interfaces/dss/ChainlogAbstract.sol";

import { DssSpellCollateralOnboardingAction } from "./Goerli-DssSpellCollateralOnboarding.sol";

interface HopeLike {
    function hope(address) external;
}

contract DssSpellAction is DssAction /*, DssSpellCollateralOnboardingAction */ {
    // Provides a descriptive tag for bot consumption
    string public constant override description = "Goerli Spell";

    address internal constant RWA008AT1_A_RWA_URN        = 0xcc5b51BaCc1855ed99771D703Fd8Ac4555300b3f;
    address internal constant RWA008AT1_A_OUTPUT_CONDUIT = 0x08DAA71311F2EB974C35424BCc2af239378c7E61;
    address internal constant RWA008AT1_A_OPERATOR       = 0x50b8C31E88eE19c480Cc60c780c77051D3aFE775;

    // Turn office hours off
    function officeHours() public override returns (bool) {
        return false;
    }

    function actions() public override {
        address CHAINLOG = DssExecLib.LOG;

        HopeLike(RWA008AT1_A_RWA_URN).hope(RWA008AT1_A_OPERATOR);
        HopeLike(RWA008AT1_A_OUTPUT_CONDUIT).hope(RWA008AT1_A_OPERATOR);

        // onboardNewCollaterals();
        DssExecLib.setChangelogVersion("0.2.2");
    }
}

contract DssSpell is DssExec {
    constructor() DssExec(block.timestamp + 30 days, address(new DssSpellAction())) public {}
}
