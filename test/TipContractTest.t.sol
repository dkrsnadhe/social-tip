// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {TipContract} from "../src/TipContract.sol";

contract TipContractTest is Test {
    TipContract public tipContract;

    function setUp() public {
        tipContract = new TipContract();
    }

    receive() external payable {}

    function testOwner() public {
        assertEq(tipContract.owner(), address(this));
    }

    function testTip() public {
        tipContract.tip{value: 1}();
        assertEq(address(tipContract).balance, 1);
    }

    function testWithdrawTip() public {
        tipContract.tip{value: 1}();
        tipContract.withdrawTip();
        assertEq(address(tipContract).balance, 0);
    }

    function testTipContractBalance() public {
        tipContract.tip{value: 5}();
        assertEq(tipContract.tipContractBalance(), 5);
    }

    function testOnlyOwner() public {
        tipContract.tip{value: 5}();
        vm.expectRevert();
        vm.startPrank(msg.sender);
        tipContract.withdrawTip();
    }

    function testErrorInsufficientAmount() public {
        vm.expectRevert(TipContract.InsufficientAmount.selector);
        tipContract.withdrawTip();
        vm.expectRevert(TipContract.InsufficientAmount.selector);
        tipContract.tip();
    }
}
