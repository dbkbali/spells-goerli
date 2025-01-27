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

contract Config {

    struct SpellValues {
        address deployed_spell;
        uint256 deployed_spell_created;
        address previous_spell;
        bool    office_hours_enabled;
        uint256 expiration_threshold;
    }

    struct SystemValues {
        uint256 line_offset;
        uint256 pot_dsr;
        uint256 pause_delay;
        uint256 vow_wait;
        uint256 vow_dump;
        uint256 vow_sump;
        uint256 vow_bump;
        uint256 vow_hump_min;
        uint256 vow_hump_max;
        uint256 flap_beg;
        uint256 flap_ttl;
        uint256 flap_tau;
        uint256 flap_lid;
        uint256 cat_box;
        uint256 dog_Hole;
        uint256 esm_min;
        address pause_authority;
        address osm_mom_authority;
        address flipper_mom_authority;
        address clipper_mom_authority;
        uint256 ilk_count;
        mapping (bytes32 => CollateralValues) collaterals;
    }

    struct CollateralValues {
        bool aL_enabled;
        uint256 aL_line;
        uint256 aL_gap;
        uint256 aL_ttl;
        uint256 line;
        uint256 dust;
        uint256 pct;
        uint256 mat;
        bytes32 liqType;
        bool    liqOn;
        uint256 chop;
        uint256 cat_dunk;
        uint256 flip_beg;
        uint48  flip_ttl;
        uint48  flip_tau;
        uint256 flipper_mom;
        uint256 dog_hole;
        uint256 clip_buf;
        uint256 clip_tail;
        uint256 clip_cusp;
        uint256 clip_chip;
        uint256 clip_tip;
        uint256 clipper_mom;
        uint256 cm_tolerance;
        uint256 calc_tau;
        uint256 calc_step;
        uint256 calc_cut;
        bool    lerp;
    }

    uint256 constant HUNDRED    = 10 ** 2;
    uint256 constant THOUSAND   = 10 ** 3;
    uint256 constant MILLION    = 10 ** 6;
    uint256 constant BILLION    = 10 ** 9;

    uint256 constant monthly_expiration = 4 days;
    uint256 constant weekly_expiration  = 30 days;

    SpellValues  spellValues;
    SystemValues afterSpell;

    function setValues(address chief) public {
        //
        // Values for spell-specific parameters
        //
        spellValues = SpellValues({
            deployed_spell:                 address(0),        // populate with deployed spell if deployed
            deployed_spell_created:         0,        // use get-created-timestamp.sh if deployed
            previous_spell:                 address(0),        // supply if there is a need to test prior to its cast() function being called on-chain.
            office_hours_enabled:           false,             // true if officehours is expected to be enabled in the spell
            expiration_threshold:           weekly_expiration  // (weekly_expiration,monthly_expiration) if weekly or monthly spell
        });

        //
        // Values for all system configuration changes
        //
        afterSpell = SystemValues({
            line_offset:           500 * MILLION,           // Offset between the global line against the sum of local lines
            pot_dsr:               1,                       // In basis points
            pause_delay:           60 seconds,              // In seconds
            vow_wait:              156 hours,               // In seconds
            vow_dump:              250,                     // In whole Dai units
            vow_sump:              50 * THOUSAND,           // In whole Dai units
            vow_bump:              30 * THOUSAND,           // In whole Dai units
            vow_hump_min:          0,           // In whole Dai units
            vow_hump_max:          1000 * MILLION,           // In whole Dai units
            flap_beg:              400,                     // in basis points
            flap_ttl:              30 minutes,              // in seconds
            flap_tau:              72 hours,                // in seconds
            flap_lid:              150 * THOUSAND,          // in whole Dai units
            cat_box:               20 * MILLION,            // In whole Dai units
            dog_Hole:              100 * MILLION,           // In whole Dai units
            esm_min:               100 * THOUSAND,          // In whole MKR units
            pause_authority:       chief,                   // Pause authority
            osm_mom_authority:     chief,                   // OsmMom authority
            flipper_mom_authority: chief,                   // FlipperMom authority
            clipper_mom_authority: chief,                   // ClipperMom authority
            ilk_count:             2                      // Num expected in system
        });

        //
        // Values for all collateral
        // Update when adding or modifying Collateral Values
        //

        //
        // Test for all collateral based changes here
        //
        afterSpell.collaterals["ETH-A"] = CollateralValues({
            aL_enabled:   true,            // DssAutoLine is enabled?
            aL_line:      15 * BILLION,    // In whole Dai units
            aL_gap:       100 * MILLION,   // In whole Dai units
            aL_ttl:       8 hours,         // In seconds
            line:         0,               // In whole Dai units  // Not checked here as there is auto line
            dust:         10 * THOUSAND,   // In whole Dai units
            pct:          200,             // In basis points
            mat:          15000,           // In basis points
            liqType:      "clip",          // "" or "flip" or "clip"
            liqOn:        true,            // If liquidations are enabled
            chop:         1300,            // In basis points
            cat_dunk:     0,               // In whole Dai units
            flip_beg:     0,               // In basis points
            flip_ttl:     0,               // In seconds
            flip_tau:     0,               // In seconds
            flipper_mom:  0,               // 1 if circuit breaker enabled
            dog_hole:     30 * MILLION,
            clip_buf:     13000,
            clip_tail:    140 minutes,
            clip_cusp:    4000,
            clip_chip:    10,
            clip_tip:     300,
            clipper_mom:  1,
            cm_tolerance: 5000,
            calc_tau:     0,
            calc_step:    90,
            calc_cut:     9900,
            lerp:         false
        });

        afterSpell.collaterals["DUMMY-DBK"] = CollateralValues({
            aL_enabled:   true,          // DssAutoLine is enabled?
            aL_line:      100 * MILLION, // In whole Dai units
            aL_gap:       50 * MILLION,  // In whole Dai units
            aL_ttl:       1 hours,       // In seconds
            line:         0,             // In whole Dai units  // Not checked here as there is auto line
            dust:         1 * THOUSAND,  // In whole Dai units
            pct:          0,             // In basis points
            mat:          11000,         // In basis points
            liqType:      "clip",        // "" or "flip" or "clip"
            liqOn:        false,         // If liquidations are enabled
            chop:         1300,          // In basis points
            cat_dunk:     0,             // In whole Dai units
            flip_beg:     0,             // In basis points
            flip_ttl:     0,             // In seconds
            flip_tau:     0,             // In seconds
            flipper_mom:  0,             // 1 if circuit breaker enabled
            dog_hole:     3 * MILLION,
            clip_buf:     13000,
            clip_tail:    140 minutes,
            clip_cusp:    4000,
            clip_chip:    10,
            clip_tip:     300,
            clipper_mom:  0,
            cm_tolerance: 5000,
            calc_tau:     0,
            calc_step:    90,
            calc_cut:     9900,
            lerp:         false
        });

        // afterSpell.collaterals["RWA008AT2-A"] = CollateralValues({
        //     aL_enabled:   false,        // DssAutoLine is enabled?
        //     aL_line:      0,            // In whole Dai units
        //     aL_gap:       0,            // In whole Dai units
        //     aL_ttl:       1 hours,      // In seconds
        //     line:         80 * MILLION, // In whole Dai units  // Not checked here as there is auto line
        //     dust:         0,            // In whole Dai units
        //     pct:          300,          // In basis points
        //     mat:          10 * THOUSAND,            // In basis points
        //     liqType:      "",           // "" or "flip" or "clip"
        //     liqOn:        false,        // If liquidations are enabled
        //     chop:         1300,         // In basis points
        //     cat_dunk:     0,            // In whole Dai units
        //     flip_beg:     0,            // In basis points
        //     flip_ttl:     0,            // In seconds
        //     flip_tau:     0,            // In seconds
        //     flipper_mom:  0,            // 1 if circuit breaker enabled
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["ETH-B"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      500 * MILLION,
        //     aL_gap:       20 * MILLION,
        //     aL_ttl:       6 hours,
        //     line:         0,
        //     dust:         40 * THOUSAND,
        //     pct:          400,
        //     mat:          13000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     30 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    60,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["ETH-C"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      2 * BILLION,
        //     aL_gap:       100 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         5 * THOUSAND,
        //     pct:          50,
        //     mat:          17000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     35 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["BAT-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          400,
        //     mat:          1120000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     1 * MILLION + 500 * THOUSAND,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["USDC-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          100,
        //     mat:          10100,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["USDC-B"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          5000,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["WBTC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      2_000 * MILLION,
        //     aL_gap:       80 * MILLION,
        //     aL_ttl:       6 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          375,
        //     mat:          14500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     40 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["WBTC-B"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      500 * MILLION,
        //     aL_gap:       30 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         30 * THOUSAND,
        //     pct:          500,
        //     mat:          13000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     25 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    90 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    60,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["WBTC-C"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      1000 * MILLION,
        //     aL_gap:       100 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         75 * HUNDRED,
        //     pct:          75,
        //     mat:          17500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     25 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    90 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["TUSD-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          0,
        //     mat:          10100,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["KNC-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          500,
        //     mat:          500000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     500 * THOUSAND,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["ZRX-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          400,
        //     mat:          550000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     1 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["MANA-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      10 * MILLION,
        //     aL_gap:       1 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          600,
        //     mat:          17500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     1 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["USDT-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          800,
        //     mat:          30000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     15_000,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["PAXUSD-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          100,
        //     mat:          10100,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["COMP-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          100,
        //     mat:          200000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     2 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["LRC-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          400,
        //     mat:          2430000,  // 24,300%
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     500 * THOUSAND,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["LINK-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      100 * MILLION,
        //     aL_gap:       7 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          250,
        //     mat:          16500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     6 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["BAL-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          100,
        //     mat:          230000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["YFI-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      50 * MILLION,
        //     aL_gap:       7 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          100,
        //     mat:          16500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["GUSD-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          100,
        //     mat:          10100,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNI-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      25 * MILLION,
        //     aL_gap:       5 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          300,
        //     mat:          16500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RENBTC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      10 * MILLION,
        //     aL_gap:       1 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          250,
        //     mat:          16500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["AAVE-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          100,
        //     mat:          210000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["UNIV2DAIETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      50 * MILLION,
        //     aL_gap:       5 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         60 * THOUSAND,
        //     pct:          100,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     11500,
        //     clip_tail:    215 minutes,
        //     clip_cusp:    6000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 7000,
        //     calc_tau:     0,
        //     calc_step:    125,
        //     calc_cut:     9950,
        //     lerp:         false
        // });
        // afterSpell.collaterals["PSM-USDC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      10 * BILLION,
        //     aL_gap:       950 * MILLION,
        //     aL_ttl:       24 hours,
        //     line:         0,
        //     dust:         0,
        //     pct:          0,
        //     mat:          10000,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2WBTCETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      50 * MILLION,
        //     aL_gap:       5 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         25 * THOUSAND,
        //     pct:          200,
        //     mat:          14500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    200 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    130,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2USDCETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      50 * MILLION,
        //     aL_gap:       5 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         60 * THOUSAND,
        //     pct:          150,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     11500,
        //     clip_tail:    215 minutes,
        //     clip_cusp:    6000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 7000,
        //     calc_tau:     0,
        //     calc_step:    125,
        //     calc_cut:     9950,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2DAIUSDC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      250 * MILLION,
        //     aL_gap:       10 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          0,
        //     mat:          10200,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2ETHUSDT-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          200,
        //     mat:          14000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     11500,
        //     clip_tail:    215 minutes,
        //     clip_cusp:    6000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 7000,
        //     calc_tau:     0,
        //     calc_step:    125,
        //     calc_cut:     9950,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2LINKETH-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          300,
        //     mat:          160000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    200 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    130,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["UNIV2UNIETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      5 * MILLION,
        //     aL_gap:       3 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         25 * THOUSAND,
        //     pct:          400,
        //     mat:          16000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    200 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    130,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2WBTCDAI-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      20 * MILLION,
        //     aL_gap:       3 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         60 * THOUSAND,
        //     pct:          0,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     11500,
        //     clip_tail:    215 minutes,
        //     clip_cusp:    6000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 7000,
        //     calc_tau:     0,
        //     calc_step:    125,
        //     calc_cut:     9950,
        //     lerp:         false
        // });
        // afterSpell.collaterals["UNIV2AAVEETH-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          300,
        //     mat:          40000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    200 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    130,
        //     calc_cut:     9900,
        //     lerp:         true
        // });
        // afterSpell.collaterals["UNIV2DAIUSDT-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          200,
        //     mat:          12500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA001-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         15 * MILLION,
        //     dust:         0,
        //     pct:          300,
        //     mat:          10000,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA002-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0,
        //     aL_gap:       0,
        //     aL_ttl:       0,
        //     line:         20 * MILLION,
        //     dust:         0,
        //     pct:          350,
        //     mat:          10500,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA003-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0 * MILLION,
        //     aL_gap:       0 * MILLION,
        //     aL_ttl:       0,
        //     line:         2 * MILLION,
        //     dust:         0,
        //     pct:          600,
        //     mat:          10500,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA004-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0 * MILLION,
        //     aL_gap:       0 * MILLION,
        //     aL_ttl:       0,
        //     line:         7 * MILLION,
        //     dust:         0,
        //     pct:          700,
        //     mat:          11000,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA005-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0 * MILLION,
        //     aL_gap:       0 * MILLION,
        //     aL_ttl:       0,
        //     line:         15 * MILLION,
        //     dust:         0,
        //     pct:          450,
        //     mat:          10500,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["RWA006-A"] = CollateralValues({
        //     aL_enabled:   false,
        //     aL_line:      0 * MILLION,
        //     aL_gap:       0 * MILLION,
        //     aL_ttl:       0,
        //     line:         0 * MILLION,
        //     dust:         0,
        //     pct:          200,
        //     mat:          10000,
        //     liqType:      "",
        //     liqOn:        false,
        //     chop:         0,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     0,
        //     clip_tail:    0,
        //     clip_cusp:    0,
        //     clip_chip:    0,
        //     clip_tip:     0,
        //     clipper_mom:  0,
        //     cm_tolerance: 0,
        //     calc_tau:     0,
        //     calc_step:    0,
        //     calc_cut:     0,
        //     lerp:         false
        // });
        // afterSpell.collaterals["MATIC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      35 * MILLION,
        //     aL_gap:       10 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          300,
        //     mat:          17500,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     3 * MILLION,
        //     clip_buf:     13000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["PSM-PAX-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      500 * MILLION,
        //     aL_gap:       50 * MILLION,
        //     aL_ttl:       24 hours,
        //     line:         0,
        //     dust:         0,
        //     pct:          0,
        //     mat:          10000,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["GUNIV3DAIUSDC1-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      100 * MILLION,
        //     aL_gap:       10 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          10,
        //     mat:          10200,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["WSTETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      300 * MILLION,
        //     aL_gap:       30 * MILLION,
        //     aL_ttl:       6 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          250,
        //     mat:          16000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     15 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
// //        afterSpell.collaterals["DIRECT-AAVEV2-DAI"] = CollateralValues({
// //            aL_enabled:   true,
// //            aL_line:      300 * MILLION,
// //            aL_gap:       65 * MILLION,
// //            aL_ttl:       12 hours,
// //            line:         0,
// //            dust:         0,
// //            pct:          0,
// //            mat:          10000,
// //            liqType:      "clip",
// //            liqOn:        false,
// //            chop:         1300,
// //            cat_dunk:     0,
// //            flip_beg:     0,
// //            flip_ttl:     0,
// //            flip_tau:     0,
// //            flipper_mom:  0,
// //            dog_hole:     0,
// //            clip_buf:     10500,
// //            clip_tail:    220 minutes,
// //            clip_cusp:    9000,
// //            clip_chip:    10,
// //            clip_tip:     300,
// //            clipper_mom:  0,
// //            cm_tolerance: 9500,
// //            calc_tau:     0,
// //            calc_step:    120,
// //            calc_cut:     9990
// //        });
        // afterSpell.collaterals["PSM-GUSD-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      60 * MILLION,
        //     aL_gap:       10 * MILLION,
        //     aL_ttl:       24 hours,
        //     line:         0,
        //     dust:         0,
        //     pct:          0,
        //     mat:          10000,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     0,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["GUNIV3DAIUSDC2-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      750 * MILLION,
        //     aL_gap:       50 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         15 * THOUSAND,
        //     pct:          25,
        //     mat:          10200,
        //     liqType:      "clip",
        //     liqOn:        false,
        //     chop:         1300,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     5 * MILLION,
        //     clip_buf:     10500,
        //     clip_tail:    220 minutes,
        //     clip_cusp:    9000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  0,
        //     cm_tolerance: 9500,
        //     calc_tau:     0,
        //     calc_step:    120,
        //     calc_cut:     9990,
        //     lerp:         false
        // });
        // afterSpell.collaterals["INST-ETH-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      900 * MILLION,
        //     aL_gap:       50 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          150,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         2000,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     50 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
        // afterSpell.collaterals["INST-WBTC-A"] = CollateralValues({
        //     aL_enabled:   true,
        //     aL_line:      600 * MILLION,
        //     aL_gap:       50 * MILLION,
        //     aL_ttl:       8 hours,
        //     line:         0,
        //     dust:         10 * THOUSAND,
        //     pct:          150,
        //     mat:          12000,
        //     liqType:      "clip",
        //     liqOn:        true,
        //     chop:         2000,
        //     cat_dunk:     0,
        //     flip_beg:     0,
        //     flip_ttl:     0,
        //     flip_tau:     0,
        //     flipper_mom:  0,
        //     dog_hole:     30 * MILLION,
        //     clip_buf:     12000,
        //     clip_tail:    140 minutes,
        //     clip_cusp:    4000,
        //     clip_chip:    10,
        //     clip_tip:     300,
        //     clipper_mom:  1,
        //     cm_tolerance: 5000,
        //     calc_tau:     0,
        //     calc_step:    90,
        //     calc_cut:     9900,
        //     lerp:         false
        // });
    }
}
