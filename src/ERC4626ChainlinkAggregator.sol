// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IERC4626, ChainlinkOracle} from "morpho-blue-oracles/ChainlinkOracle.sol";

import {AggregatorV3Interface, ChainlinkDataFeedLib} from "morpho-blue-oracles/libraries/ChainlinkDataFeedLib.sol";

contract ERC4626ChainlinkAggregator is AggregatorV3Interface {
    IERC4626 immutable public token;

    constructor(IERC4626 token_) {
        token = token_;
    }

    function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80) {
        return (0, int256(token.convertToAssets(10**18)), 0, 0, 0);
    }

    function decimals() external pure returns (uint8) {
        return 18;
    }

    
    function description() external view returns (string memory) {
        return "ERC4626ChainlinkAggregator";
    }

    function version() external view returns (uint256) {
        return 1;
    }

    function getRoundData(uint80 _roundId)
        external
        view
        returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) {
        require(_roundId == 0, "Round ID should be 0");
        return (0, int256(token.convertToAssets(10**18)), 0, 0, 0);
    }
}
