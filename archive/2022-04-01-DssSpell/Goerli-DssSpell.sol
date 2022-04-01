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
//pragma experimental ABIEncoderV2;
import "dss-exec-lib/DssExec.sol";
import "dss-exec-lib/DssAction.sol";

import { DssSpellCollateralOnboardingAction } from "./Goerli-DssSpellCollateralOnboarding.sol";


contract DssSpellAction is DssAction, DssSpellCollateralOnboardingAction {
    // Provides a descriptive tag for bot consumption
    string public constant override description = "Goerli Spell";

    // Turn office hours off
    function officeHours() public override returns (bool) {
        return false;
    }

    address constant public OAZO_ADDR     = 0xb0724B07883DF9e9276a77CD73acd00FE5F86F55;
    address constant public OAZO_OLD_ADDR = 0x0F1AE882272032D494926D5D983E4FBE253CB544;

    function actions() public override {
        DssExecLib.removeReaderFromWhitelist(DssExecLib.getChangelogAddress("PIP_ETH"), OAZO_OLD_ADDR);
        DssExecLib.removeReaderFromWhitelist(DssExecLib.getChangelogAddress("PIP_WBTC"), OAZO_OLD_ADDR);
        DssExecLib.removeReaderFromWhitelist(DssExecLib.getChangelogAddress("PIP_WSTETH"), OAZO_OLD_ADDR);

        DssExecLib.addReaderToWhitelist(DssExecLib.getChangelogAddress("PIP_ETH"), OAZO_ADDR);
        DssExecLib.addReaderToWhitelist(DssExecLib.getChangelogAddress("PIP_WBTC"), OAZO_ADDR);
        DssExecLib.addReaderToWhitelist(DssExecLib.getChangelogAddress("PIP_WSTETH"), OAZO_ADDR);
    }
}

contract DssSpell is DssExec {
    constructor() DssExec(block.timestamp + 30 days, address(new DssSpellAction())) public {}
}
