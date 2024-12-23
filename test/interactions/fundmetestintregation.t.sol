// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";

import {Deployfundme} from "../../script/Deployfundme.s.sol";
import {FundmeFund, WithdrawFundme} from "../../script/interactions.s.sol";

contract Fundmetestintregation is Test {
    FundMe fundMe;
    address User = makeAddr("user");
    uint256 constant Send_value = 0.1 ether;
    uint256 constant Strating_value = 10 ether;
    uint256 constant gas = 1;

    function setUp() external {
        Deployfundme deploy = new Deployfundme();
        fundMe = deploy.run();
        vm.deal(User, Strating_value);
    }

    function testuserfund() public {
        FundmeFund fundfund = new FundmeFund();
        fundfund.fundfundme(address(fundMe));

        WithdrawFundme withdraw = new WithdrawFundme();
        withdraw.withdrawundme(address(fundMe));

        assert(address(fundMe).balance == 0);
    }
}
