//SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {CaducusToken} from "../src/CaducusToken.sol";

contract DeployCaducusToken is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 * 10 ** 18;

    function run() external returns (CaducusToken) {
        vm.startBroadcast();
        CaducusToken caducusToken = new CaducusToken(INITIAL_SUPPLY);
        vm.stopBroadcast();
        return caducusToken;
    }
}
