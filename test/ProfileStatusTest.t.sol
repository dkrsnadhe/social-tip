// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {ProfileStatus} from "../src/ProfileStatus.sol";

contract ProfileStatusTest is Test {
    ProfileStatus public profileStatus;

    function setUp() public {
        profileStatus = new ProfileStatus();
    }

    function testCreateStatus() public {
        string memory _status = "Solidity Developer";
        vm.startPrank(msg.sender);
        profileStatus.createStatus(_status);
        (string memory status, bool exists) = profileStatus.userStatus(
            msg.sender
        );
        assertEq(exists, true);
        assertEq(status, _status);
        vm.stopPrank();
    }

    function testUpdateStatus() public {
        string memory _status = "Solidity Developer";
        vm.startPrank(msg.sender);
        profileStatus.createStatus(_status);
        string memory _newStatus = "Javascript Developer";
        profileStatus.updateStatus(_newStatus);
        (string memory status, bool exists) = profileStatus.userStatus(
            msg.sender
        );
        assertEq(status, _newStatus);
        assertEq(exists, true);
        vm.stopPrank();
    }

    function testGetStatus() public {
        string memory _status = "Solidity Developer";
        vm.startPrank(msg.sender);
        profileStatus.createStatus(_status);
        string memory statusMessage = profileStatus.getStatus(msg.sender);
        assertEq(statusMessage, _status);
        vm.stopPrank();
    }
}
