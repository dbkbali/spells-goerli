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

pragma solidity ^0.6.12;

contract Deployers {

    address[] public addr;

    constructor() public {
        addr = [
            0x3ec4699bEc79F8FF862C220Ef0a718689A1d09f4,
            0x23E91332984eEd55C88131C58295C8Dce379E2aB,
            0xb27B6fa77D7FBf3C1BD34B0f7DA59b39D3DB0f7e,
            0xda0fab060e6cc7b1C0AA105d29Bd50D71f036711,
            0xDA0FaB0700A4389F6E6679aBAb1692B4601ce9bf,
            0xdA0C0de01d90A5933692Edf03c7cE946C7c50445,
            0xdB33dFD3D61308C33C63209845DaD3e6bfb2c674,
            0xDA01018eA05D98aBb66cb21a85d6019a311570eE,
            0xDA0111100cb6080b43926253AB88bE719C60Be13
        ];
    }

    function count() external view returns (uint256) {
        return addr.length;
    }
}
