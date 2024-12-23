// SPDX-License-Identifier: MIT

pragma solidity 0.8.19;

import {Script} from "forge-std/Script.sol";
import {FundMe} from "../src/FundMe.sol";
import {helperconfig} from "./helperconfig.s.sol";

contract Deployfundme is Script {
    function run() external returns (FundMe) {
        helperconfig config = new helperconfig();
        address pricefeed = config.active();

        vm.startBroadcast();
        FundMe fundme = new FundMe(pricefeed);

        vm.stopBroadcast();

        return fundme;
    }
}
