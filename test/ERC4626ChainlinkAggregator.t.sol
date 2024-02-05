// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";


import {IERC20} from "@openzeppelin/contracts/interfaces/IERC20.sol";
import {IERC4626} from "@openzeppelin/contracts/interfaces/IERC4626.sol";

import "../src/ERC4626ChainlinkAggregator.sol";


contract ERC4626ChainlinkAggregatorTest is Test {

    IERC20 constant dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    IERC4626 constant sdai = IERC4626(0x83F20F44975D03b1b09e64809B757c47f942BEeA);

    IERC4626 constant wusdm = IERC4626(0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812);

    ERC4626ChainlinkAggregator public oracle;

    function setUp() public {
        vm.createSelectFork(vm.envString("ETH_RPC_URL"));
    }

    
    function testWusdmOracle() public {
        
        oracle = new ERC4626ChainlinkAggregator(wusdm);
        (, int256 price, , , ) = oracle.latestRoundData();

        console.logInt(price);
        assertEq(uint256(price), wusdm.convertToAssets(10**8));
    }



}
