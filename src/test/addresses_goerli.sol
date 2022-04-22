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

contract Addresses {
    mapping(bytes32 => address) public addr;

    constructor() public {
        addr["CHANGELOG"] = 0x672f51B1040898dd3b24c7075112241213faD588;
        addr["MULTICALL"] = 0x80E2921091dCef9d99C4D64d5d06cE9d9d964432;
        addr["FAUCET"] = 0x66462F1abc139e0F271c92971457a506467271f7;
        addr["MCD_DEPLOY"] = 0xa78e807F9E647041Ef098D290945572855AC9f2A;
        addr["FLIP_FAB"] = 0x6CF766EE8c9e443E062e5BfdE43FbC9930ddb8F1;
        addr["CLIP_FAB"] = 0xE889a3779ADF590A31d27d3d3d5D5282aa84E403;
        addr["CALC_FAB"] = 0x98215CFA6990279B48E0acA17c292978B6c9Bc77;
        addr["MCD_GOV"] = 0xd3f972221B096353e3900dF879DC74b340bd248e;
        addr["MCD_IOU"] = 0xaB8CF9B5f2C7C2A716A5172ECd036Bcb1BEe921a;
        addr["MCD_ADM"] = 0x845b12C1B9A44314E5b6F3B678E1F0dD4273B16a;
        addr["VOTE_PROXY_FACTORY"] = 0x100e490AF1B203047dB43Df9Cf0b5db723d841C4;
        addr[
            "VOTE_DELEGATE_PROXY_FACTORY"
        ] = 0xbD73F40f25E434db4855E0159FFDad04c3ca2fF5;
        addr["MCD_VAT"] = 0x5520F17937b6D39161ACAc99Fef28c1A45fC0cB6;
        addr["MCD_JUG"] = 0xed993d3aE9596AcA2Ba86E37703f0B67a135EdaF;
        addr["MCD_CAT"] = 0xD69bDe09F973d09Cf7CBEE7E213859aE6DFe04c7;
        addr["MCD_DOG"] = 0x55FdA540fE8bD08D4cC52C347f9cA1D189270aE2;
        addr["MCD_VOW"] = 0x323994Ce79c98eb936FDb92fba4ce1E0d4771EA4;
        addr["MCD_JOIN_DAI"] = 0x328732CfdC3Cf528A55e04aEe48AC6ED1cDc79FB;
        addr["MCD_FLAP"] = 0x1d83EDD88ee4A101B6136C87298f3e00899afc8A;
        addr["MCD_FLOP"] = 0x8Fed61335A560f5eadB2Abfd75aBd8a2ACb7d760;
        addr["MCD_PAUSE"] = 0xF5931B30578fB2f455607119a385B5Ed53f0c806;
        addr["MCD_PAUSE_PROXY"] = 0xC8473D1aD9FC114E4ffa5c18518f0cF27dEBd0fA;
        addr["MCD_GOV_ACTIONS"] = 0x24C10AeBaAb9501a0F29a305529A4233a4394a1c;
        addr["MCD_DAI"] = 0xc65b06ea5DC2a52105910A6DF7e8Be4211Fdd1C1;
        addr["MCD_SPOT"] = 0xc31f89Ac55eEDF98E0e6C24a68986432692689cc;
        addr["MCD_POT"] = 0xe6Ddd3Ce621548cD7B95f84d418A1B811A650BbD;
        addr["MCD_END"] = 0xF2b73028CBc2b55a76A37B963B3951A986e192E9;
        addr["MCD_ESM"] = 0x7e67a5224457b8D3C8d9900Ca248F89D43a5c9aa;
        addr["PROXY_ACTIONS"] = 0xE0C414A6e19c2b911455378e19A10287C1B1E6e1;
        addr["PROXY_ACTIONS_END"] = 0x4627cb8C653f53CE250D887f69831b2882024a2A;
        addr["PROXY_ACTIONS_DSR"] = 0x089e2b18D1d875152560573fdC11DbbE8D3624AC;
        addr["CDP_MANAGER"] = 0xb23AB5D745Bf4c695Db64580EBA90A4bF2E3d472;
        addr["DSR_MANAGER"] = 0x68062263fF5ED792524B3d89c332A87976388a59;
        addr["GET_CDPS"] = 0x8E271533296FB4956Cc761909CA532D64E00E040;
        addr["ILK_REGISTRY"] = 0xbbdB63721e3424faf66dE412ec3dA8cE94310844;
        addr["OSM_MOM"] = 0x5e354501B38d59b1e5eD789cf4fc3c5c8a8b6d29;
        addr["FLIPPER_MOM"] = 0xcC20F50bC976A8E5b3548ea5c7461BEB4556EF9f;
        addr["CLIPPER_MOM"] = 0xaEFC223a003Db096C995014EDf21cfd3F7C45Ba0;
        addr["MCD_IAM_AUTO_LINE"] = 0xA5402D969e5Bf6f5eaB2e6534d6e33D9DAE1C950;
        addr["MCD_FLASH"] = 0xCD1271E9563A2D1867c99048F57B749F2cCb6714;
        addr["MCD_VEST_DAI"] = 0x3dd09Db3FB14ef5159175Ce32c5D103da3D0D813;
        addr["MCD_VEST_MKR"] = 0x9413a86A83d53AcADb9e05bF258e20CA5f9eB003;
        addr[
            "MCD_VEST_MKR_TREASURY"
        ] = 0x2798BF7f7946C12da3b1721cc946dA12E8BCf5DC;
        addr["PROXY_FACTORY"] = 0x5A53a1901355f01466DbA447a3a725d232942B06;
        addr["PROXY_REGISTRY"] = 0x237bdC8e1Ecea947f627C5868054468bFd5786f8;
        addr["ETH"] = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        addr["VAL_ETH"] = 0x94588e35fF4d2E99ffb8D5095F35d1E37d6dDf12;
        addr["PIP_ETH"] = 0x94588e35fF4d2E99ffb8D5095F35d1E37d6dDf12;
        addr["MCD_JOIN_ETH_A"] = 0x2d7b577DEA332F2A0686163E0a0eBe6E0975d489;
        addr["MCD_CLIP_ETH_A"] = 0xf0f3B9e09edA7f0C90451bD4752982469ad26000;
        addr[
            "MCD_CLIP_CALC_ETH_A"
        ] = 0x584Bd3a104006eEb9400C3C9257A88c37f9374c6;
        addr[
            "PROXY_PAUSE_ACTIONS"
        ] = 0x744857414e7531C60206e5439afF17ab6170F6c5;
        addr["PROXY_DEPLOYER"] = 0xBc4a110430EB3E2618E24e1fab9F4EF60e8F7487;
        // addr[
        //     "MIP21_LIQUIDATION_ORACLE"
        // ] = 0x493A7F7E6f44D3bd476bc1bfBBe191164269C0Cc;
        addr["DUMMY"] = 0xa3C21F23a782a0ACf0593ad6ECE57eFe353b966d;
        addr["PIP_DUMMY"] = 0xB5FD340c39D1bE12831ADf39BBFB25F693fb4566;
        addr["MCD_JOIN_DUMMY_DBK"] = 0xB94e246BC9945AFf7f940A32d4B33180eB8B3F74;
        addr["MCD_CLIP_DUMMY_DBK"] = 0x5013B096524E2F7eEe54cf14463bDCb9F4563061;
        addr[
            "MCD_CLIP_CALC_DUMMY_DBK"
        ] = 0xD61FbA87aAA7C774a56DF4d4B2b41651640Abb1D;
    }
}
