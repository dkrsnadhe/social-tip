// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
    @title MessageBoard
    @author dkrsnadhe
*/

contract MessageBoard {
    string[] public message;

    /*
     * @title NewMessage
     * @notice Event emitted upon the creation of a new message.
     * @dev This event is triggered when a new message is created,
     * capturing the address of the sender and the content of the message.
     * @param sender The address of the user who created the message.
     * @param message The content of the newly created message.
     */
    event NewMessage(address indexed sender, string message);

    /*
     * @title postMessage
     * @notice Function to post a new message.
     * @dev This function allows users to post a new message.
     * It adds the provided message content to the message array
     * and emits a NewMessage event with the sender's address and the message content.
     * @param _message The content of the message to be posted.
     */
    function postMessage(string memory _message) external {
        message.push(_message);
        emit NewMessage(msg.sender, _message);
    }

    /*
     * @title getMessage
     * @notice Function to retrieve a message by its index.
     * @dev This function allows users to retrieve a message by its index in the message array.
     * It checks if the provided index is within the bounds of the message array.
     * If the index is out of bounds, it reverts with the message "Message not exist!".
     * Otherwise, it returns the message content at the specified index.
     * @param _index The index of the message to be retrieved.
     * @return string The content of the message at the specified index.
     */
    function getMessage(uint256 _index) external view returns (string memory) {
        require(_index < message.length, "Message not exist!");
        return message[_index];
    }
}
