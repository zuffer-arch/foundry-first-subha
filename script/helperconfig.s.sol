// SPDX-License-Identifier: SEE LICENSE IN LICENSE
pragma solidity ^0.8.18;

import {Script} from "forge-std/Script.sol";
import {mockv3aggragator} from "../test/mocks/mockv3aggragator.sol";

contract helperconfig is Script {
    networkconfig public active;

    struct networkconfig {
        address priceFeed; //eht/usd price feed address
    }

    constructor() {
        if (block.chainid == 11155111) {
            active = getsepolia();
        } else {
            active = getanvilethconfig();
        }
    }

    function getsepolia() public pure returns (networkconfig memory) {
        networkconfig memory sepoliaconfig = networkconfig({priceFeed: 0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266});

        return sepoliaconfig;
    }

    function getanvilethconfig() public returns (networkconfig memory) {
        if (active.priceFeed != address(0)) {}

        vm.startBroadcast();
        mockv3aggragator mock = new mockv3aggragator(8, 200e8);
        vm.stopBroadcast();

        networkconfig memory network = networkconfig({priceFeed: address(mock)});

        return network;
    }
}

//1. deploy mocks when we are on a anvil chain
//.2 kee track of the contarct addresses over different chain
