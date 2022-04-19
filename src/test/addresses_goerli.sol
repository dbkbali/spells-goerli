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

    mapping (bytes32 => address) public addr;

    constructor() public {
        addr["CHANGELOG"]                   = 0x62f00ded84C4Bd69c4172Ef524f7Ee97C7d37624;
        addr["MULTICALL"]                   = 0x6Ce4E6e3C98Fb9ee181e566A00952205a53f8B0a;
        addr["FAUCET"]                      = 0x0Eb1d68274eb1E2F9257DDCb0019200efBBa1708;
        addr["MCD_DEPLOY"]                  = 0xFED709b951B635cF75C23693f6FAb56198E0255F;
        addr["FLIP_FAB"]                    = 0xf979B143376FbecF2Ac7230a3A9968022eEBd756;
        addr["CLIP_FAB"]                    = 0x0C7ba52d70c078FdC72b1c724720Dd3B8b064E22;
        addr["CALC_FAB"]                    = 0x1F0615885aa40c2c65b4532bd19B4e83486766fb;
        addr["MCD_GOV"]                     = 0x1cB58FCf372be74E554f1FF824c2F9cD4a6e4444;
        addr["MCD_IOU"]                     = 0x31130463568c9715155D41904258aA25F6a5F92d;
        addr["MCD_ADM"]                     = 0xb011872cdFB34F9B3665921E63bd7c74DF96DeF0;
        addr["VOTE_PROXY_FACTORY"]          = 0xFdb7cE46446d2F37b4EcD191Bc0b1f8b83007F3B;
        addr["VOTE_DELEGATE_PROXY_FACTORY"] = 0x557045eF0C1E072D8A01A697DB61f1Edce787402;
        addr["MCD_VAT"]                     = 0x9641B1EA336bEb212F2f2F00D2D6ADFC77eEfB39;
        addr["MCD_JUG"]                     = 0x4709C314FDf0eC8D9a0cAE376aC8F5cd44C4b75B;
        addr["MCD_CAT"]                     = 0x36735077B02AD969aa118eE4DD6ef10774C80175;
        addr["MCD_DOG"]                     = 0x95027c2A2882d3d5290b7894CdF03D88E5bd7D4f;
        addr["MCD_VOW"]                     = 0x1a56Be3798Bd717522c6A6de6f2BEb60529E78BC;
        addr["MCD_JOIN_DAI"]                = 0xb587b98b941893D0409EaA4D56024A0584e68bDD;
        addr["MCD_FLAP"]                    = 0x4294F333b512df7484b268Ec1c8848844726A464;
        addr["MCD_FLOP"]                    = 0xD85cC75CdA66B073Dd7b10A81a5C87fA6550c324;
        addr["MCD_PAUSE"]                   = 0x2426144cb096B7E2C38D056E963c5A3c3A960F71;
        addr["MCD_PAUSE_PROXY"]             = 0xFDD03002C3A4C7b56644ACA375005c1f9c6D2AA4;
        addr["MCD_GOV_ACTIONS"]             = 0x9D4D4a8d40F00F6a5a544DbeC5a321B2696232aB;
        addr["MCD_DAI"]                     = 0x99337B1dA9021fd4D8E090c84f9D4D24cb5f6FEc;
        addr["MCD_SPOT"]                    = 0x68d45310edB9dE5C08db84280A7735bA620c5d87;
        addr["MCD_POT"]                     = 0xeF4d38d511a424c18059bcFbda2Ff4053d96f021;
        addr["MCD_END"]                     = 0x477EB764Ee46b5bB639d2A6Ee207Dd0555226fDD;
        addr["MCD_ESM"]                     = 0xADEf9B93a68838f1A819ab546304D8e47667b3A3;
        addr["PROXY_ACTIONS"]               = 0x61f9D082Da875A7Fe852b2A3C01A2e84d50572f3;
        addr["PROXY_ACTIONS_END"]           = 0xC6F8BAB8733d5eBc27D1673D56431F6e8e604310;
        addr["PROXY_ACTIONS_DSR"]           = 0xBA664567e384E711265939DD786644E31425C406;
        addr["CDP_MANAGER"]                 = 0x6E67651C18dfeA141DEC0833d08e7dEd6B80A564;
        addr["DSR_MANAGER"]                 = 0x9281FA835aB24152076567bb7110878068964b02;
        addr["GET_CDPS"]                    = 0x95d330d93977E60f3a63d1A6CBB258D10024A4CD;
        addr["ILK_REGISTRY"]                = 0xf2eA2f76Cb229eDAc4FeDa54a798231C1A795451;
        addr["OSM_MOM"]                     = 0xE6785cc78Fb9D18BA292A4Fc7F8921a04e7518Cd;
        addr["FLIPPER_MOM"]                 = 0x6Afbb2bd58580A6155D83DB56fD3554A989cdA1a;
        addr["CLIPPER_MOM"]                 = 0xb3c97D4c30a3279eEb4746B84a1235705919F0c9;
        addr["MCD_IAM_AUTO_LINE"]           = 0x4630fCcbac7579D08e5796Ed8126F2a5944C674F;
        addr["MCD_FLASH"]                   = 0x852Ce56749c3d9c78aD874e9DD02aE11a47c6203;
        addr["MCD_VEST_DAI"]                = 0x136E7a2Ceb5C81Bbb41aC438718333Af31261Bd7;
        addr["MCD_VEST_MKR"]                = 0xe7Cc050a781c4456b9f53933554914256DA9DC42;
        addr["MCD_VEST_MKR_TREASURY"]       = 0x1Adb2aA4e06b8F3b094087467A30EF62221a1d75;
        addr["PROXY_FACTORY"]               = 0x2Ae6B29bd2b2bA60e8C9943D8979c55eEB979599;
        addr["PROXY_REGISTRY"]              = 0xAa2Fb27a184347dB94D065695AF9561b9FEe484C;
        addr["ETH"]                         = 0xB4FBF271143F4FBf7B91A5ded31805e42b2208d6;
        addr["VAL_ETH"]                     = 0x94588e35fF4d2E99ffb8D5095F35d1E37d6dDf12;
        addr["PIP_ETH"]                     = 0x94588e35fF4d2E99ffb8D5095F35d1E37d6dDf12;
        addr["MCD_JOIN_ETH_A"]              = 0x211c34FEe723A09f5532f5D15Ba9654813aA244e;
        addr["MCD_CLIP_ETH_A"]              = 0xae3643De9CCB477961c374DdB369e67a9876e8c4;
        addr["MCD_CLIP_CALC_ETH_A"]         = 0xb00a6A805187E66684FC8b9893f777b3e76BC446;
        addr["PROXY_PAUSE_ACTIONS"]         = 0x39F1250e7CAbF9BE763d5eD92F1F22F68336375C;
        addr["PROXY_DEPLOYER"]              = 0x48DC71512904A708562c888C13dFB4337e466753;
        addr["MIP21_LIQUIDATION_ORACLE"]    = 0x493A7F7E6f44D3bd476bc1bfBBe191164269C0Cc;
        addr["DUMMY"]                       = 0xa3C21F23a782a0ACf0593ad6ECE57eFe353b966d;
        addr["PIP_DUMMY"]                   = 0xE8DBa19a6bCe486cAd0Cae4ce34eC9Dd01668e03;
        addr["MCD_JOIN_DUMMY_DBK"]            = 0x2980B0f694c4bf65E05DBDf9812173Ac622E4890;
        addr["MCD_CLIP_DUMMY_DBK"]            = 0xee17e68A3795689c01F70b50EF8C98BAFCEE4FD8;
        addr["MCD_CLIP_CALC_DUMMY_DBK"]       = 0x9f361C1Fa8B28f5206eEB06c7085D85a2d87672a;
    }
}
