// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import "../lib/forge-std/src/Test.sol";
import "../lib/forge-std/src/console.sol";



import {IERC4626, ChainlinkOracle} from "morpho-blue-oracles/ChainlinkOracle.sol";

import {AggregatorV3Interface, ChainlinkDataFeedLib} from "morpho-blue-oracles/libraries/ChainlinkDataFeedLib.sol";
import {VaultLib} from "morpho-blue-oracles/libraries/VaultLib.sol";

import "../src/ERC4626ChainlinkAggregator.sol";

contract ERC4626ChainlinkAggregatorTest is Test {


    AggregatorV3Interface constant feedZero = AggregatorV3Interface(address(0));

    AggregatorV3Interface constant ethUsdFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);

    IERC4626 constant vaultZero = IERC4626(address(0));

    IERC4626 constant sdai = IERC4626(0x83F20F44975D03b1b09e64809B757c47f942BEeA);

    IERC4626 constant wusdm = IERC4626(0x57F5E098CaD7A3D1Eed53991D4d66C45C9AF7812);

    function setUp() public {
        vm.createSelectFork(vm.envString("ETH_RPC_URL"));
    }

    
    function testWusdmAdapter() public {
        ERC4626ChainlinkAggregator oracle = new ERC4626ChainlinkAggregator(wusdm);
        (, int256 price, , , ) = oracle.latestRoundData();

        console.logInt(price);
        assertEq(uint256(price), wusdm.convertToAssets(10**18));
    }

    
    function testWusdmOracle() public {
        ERC4626ChainlinkAggregator wusdmOracle = new ERC4626ChainlinkAggregator(wusdm);

        ChainlinkOracle oracle = new ChainlinkOracle(vaultZero, ethUsdFeed, feedZero, wusdmOracle, feedZero, 1, 18, 18);
        int256 quoteAnswer = int256(wusdm.convertToAssets(10**18));
        console.logInt(quoteAnswer);

        (, int256 baseAnswer,,,) = ethUsdFeed.latestRoundData();
        console.logInt(baseAnswer);
        console.logUint( oracle.price());

        
           
        assertEq(
            oracle.price(),
            (uint256(baseAnswer) * 10 ** (36 + 18 + 18 - 8 - 18)) // Not exactly sure why
                / uint256(quoteAnswer)
        );
    }



}
