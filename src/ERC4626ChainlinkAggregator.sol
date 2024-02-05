// SPDX-License-Identifier: GPL-2.0-or-later
pragma solidity ^0.8.0;

import {IERC4626} from "@openzeppelin/contracts/interfaces/IERC4626.sol";

contract ERC4626ChainlinkAggregator {
    IERC4626 immutable public token;

    constructor(IERC4626 token_) {
        token = token_;
    }

    function latestRoundData() external view returns (uint80, int256, uint256, uint256, uint80) {
        return (0, int256(token.convertToAssets(10**8)), 0, 0, 0);
    }

    function decimals() external pure returns (uint256) {
        return 8;
    }
}
