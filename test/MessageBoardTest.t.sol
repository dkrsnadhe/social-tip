// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Test, console2} from "forge-std/Test.sol";
import {MessageBoard} from "../src/MessageBoard.sol";

contract MessageBoardTest is Test {
    MessageBoard public messageBoard;

    function setUp() public {
        messageBoard = new MessageBoard();
    }

    function testPostMessage() public {
        string memory _message = "Testing";
        messageBoard.postMessage(_message);
        assertEq(messageBoard.message(0), _message);
    }

    function testGetMessage() public {
        string memory _message1 = "Testing1";
        messageBoard.postMessage(_message1);
        string memory _message2 = "Testing2";
        messageBoard.postMessage(_message2);

        assertEq(messageBoard.getMessage(0), _message1);
        assertEq(messageBoard.getMessage(1), _message2);
    }
}
