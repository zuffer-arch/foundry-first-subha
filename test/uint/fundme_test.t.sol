// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../../src/FundMe.sol";

import {Deployfundme} from "../../script/Deployfundme.s.sol";

contract fundme_test is Test {
    FundMe fundMe;
    address User = makeAddr("user");
    uint256 constant Send_value = 0.1 ether;
    uint256 constant Strating_value = 10 ether;
    uint256 constant gas = 1;

    function setUp() external {
        Deployfundme deployme = new Deployfundme();
        fundMe = deployme.run();
        vm.deal(User, Strating_value);
    }

    function testmimimumusd() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testownerismsg() public {
        console.log(msg.sender);
        address owner = fundMe.getOwner();

        return assertEq(msg.sender, owner);
    }

    // function testpricefeed ()  public {

    // uint256 version =  fundMe.getVersion();
    // console.log(version);
    // assertEq(version,4);

    // }

    function testfundwithoutenougheth() public {
        vm.expectRevert();

        fundMe.fund();
    }

    function testfunddata() public {
        vm.prank(User);
        fundMe.fund{value: Send_value}();
        uint256 amountfunded = fundMe.getAddressToAmountFunded(User);
        assertEq(amountfunded, Send_value);
    }

    function testaddfundertoarray() public {
        vm.prank(User);
        fundMe.fund{value: Send_value}();

        address funder = fundMe.getFunder(0);

        assertEq(funder, User);
    }

    modifier funded() {
        vm.prank(User);
        fundMe.fund{value: Send_value}();

        _;
    }

    function onlyownerwithdraw() public funded {
        vm.prank(User);

        vm.expectRevert();
        fundMe.withdraw();
    }

    // function testwitdraw() public funded {
    //     uint256 ownermoneyview = fundMe.getOwner().balance;
    //     uint256 startingfundmebalance = address(fundMe).balance;

    //     vm.prank(fundMe.getOwner());
    //     fundMe.withdraw();

    //     uint256 endingowner = fundMe.getOwner().balance;
    //     uint256 endingfundingbalance = address(fundMe).balance;

    //     assertEq(endingfundingbalance, 0);
    //     assertEq(startingfundmebalance + ownermoneyview, endingfundingbalance);
    // }

    function testwithdrawwithfunders() public funded {
        uint160 numberofunders = 10;
        uint160 stratingfunderIndex = 1;

        for (uint160 i = stratingfunderIndex; i < numberofunders; i++) {
            hoax(address(i), Send_value);
            fundMe.fund{value: Send_value}();
        }

        uint256 startownerbalance = fundMe.getOwner().balance;
        uint256 startingfundmebalance = address(fundMe).balance;

        uint256 gastart = gasleft();

        vm.txGasPrice(gas);
        vm.startPrank(fundMe.getOwner());
        fundMe.withdraw();

        uint256 gasend = gasleft();

        vm.stopPrank();

        uint256 gasuseed = (gastart - gasend) * tx.gasprice;
        console.log(gasuseed);

        //assert
        assert(address(fundMe).balance == 0);
        assert(startingfundmebalance + startownerbalance == fundMe.getOwner().balance);
    }
}
