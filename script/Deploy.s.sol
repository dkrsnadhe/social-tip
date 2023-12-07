// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console2} from "forge-std/Script.sol";
import {MessageBoard} from "../src/MessageBoard.sol";
import {ProfileStatus} from "../src/ProfileStatus.sol";
import {TipContract} from "../src/TipContract.sol";

contract MessageBoardScript is Script {
    MessageBoard public messageBoard;
    ProfileStatus public profileStatus;
    TipContract public tipContract;

    function setUp() public {}

    function run() public {
        vm.startBroadcast();
        messageBoard = new MessageBoard();
        profileStatus = new ProfileStatus();
        tipContract = new TipContract();
        vm.stopBroadcast();
    }
}
