// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
    @title ProfileSatus
    @author dkrsnadhe
*/

contract ProfileStatus {
    /*
     * @title Status
     * @notice Struct to represent a status message and its existence.
     * @dev This struct defines a status message along with a boolean flag to indicate its existence.
     * It consists of a status message represented as a string and a flag indicating whether the status exists or not.
     */
    struct Status {
        string statusMessage;
        bool exists;
    }

    /*
     * @title userStatus
     * @notice Mapping to associate user addresses with their status information.
     * @dev This mapping stores the status information associated with user addresses,
     * allowing retrieval and manipulation of status messages for each user's address.
     */
    mapping(address => Status) public userStatus;

    /*
     * @title StatusCreated
     * @notice Event emitted upon creation of a new status message.
     * @dev This event is triggered when a new status message is created,
     * capturing the user's wallet address and the newly created status message.
     * @param wallet The address of the user's wallet.
     * @param status The newly created status message.
     */
    event StatusCreated(address indexed wallet, string status);

    /*
     * @title StatusUpdated
     * @notice Event emitted upon updating an existing status message.
     * @dev This event is triggered when an existing status message is updated,
     * capturing the user's wallet address and the new updated status message.
     * @param wallet The address of the user's wallet.
     * @param newStatus The updated status message.
     */
    event StatusUpdated(address indexed wallet, string newStatus);

    /*
     * @title createStatus
     * @notice Function to create a new status message for the caller.
     * @dev This function allows the caller to create a new status message.
     * It checks if a status message already exists for the caller.
     * If a status message already exists, it reverts with the message "Status already exists!".
     * Otherwise, it creates a new status message for the caller and emits a StatusCreated event.
     * @param _status The new status message to be created.
     */
    function createStatus(string memory _status) external {
        require(!userStatus[msg.sender].exists, "Status already exists!");

        userStatus[msg.sender] = Status({statusMessage: _status, exists: true});

        emit StatusCreated(msg.sender, _status);
    }

    /*
     * @title updateStatus
     * @notice Function to update an existing status message for the caller.
     * @dev This function allows the caller to update their existing status message.
     * It checks if a status message exists for the caller.
     * If no status message exists, it reverts with the message "Status not exists!".
     * Otherwise, it updates the existing status message for the caller and emits a StatusUpdated event.
     * @param _status The new status message to update the existing status.
     */
    function updateStatus(string memory _status) external {
        require(userStatus[msg.sender].exists, "Status not exists!");

        userStatus[msg.sender].statusMessage = _status;

        emit StatusUpdated(msg.sender, _status);
    }

    /*
     * @title getStatus
     * @notice Function to retrieve the status message associated with a given wallet address.
     * @dev This function allows anyone to retrieve the status message associated with a specific wallet address.
     * It checks if a status message exists for the given wallet address.
     * If no status message exists, it reverts with the message "Status not exists!".
     * Otherwise, it returns the status message associated with the provided wallet address.
     * @param _wallet The wallet address for which the status message is requested.
     * @return string The status message associated with the provided wallet address.
     */
    function getStatus(address _wallet) external view returns (string memory) {
        require(userStatus[_wallet].exists, "Status not exists!");
        return userStatus[_wallet].statusMessage;
    }
}
