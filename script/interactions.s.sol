//interact with the solifity files

//fund
//withdraw

// SPDX-License-Identifier:MIT

pragma solidity 0.8.19;

import {Script, console} from "forge-std/Script.sol";

import {DevOpsTools} from "foundry-devops/src/DevOpsTools.sol";

import {FundMe} from "../src/FundMe.sol";

contract FundmeFund is Script {
    uint256 constant Send_value = 0.01 ether;

    function fundfundme(address mostrecentlydep) public {
        vm.startBroadcast();
        FundMe(payable(mostrecentlydep)).fund{value: Send_value}();
        vm.stopBroadcast();
        console.log("Fundme Funded with amount", Send_value);
    }

    function run() external {
        address mostrecentlydep = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        fundfundme(mostrecentlydep);
        vm.stopBroadcast();
    }
}

contract WithdrawFundme is Script {
    function withdrawundme(address mostrecentlydep) public {
        vm.startBroadcast();
        FundMe(payable(mostrecentlydep)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostrecentlydep = DevOpsTools.get_most_recent_deployment("FundMe", block.chainid);
        vm.startBroadcast();
        withdrawundme(mostrecentlydep);
        vm.stopBroadcast();
    }
}
