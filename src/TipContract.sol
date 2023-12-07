// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

/*
    @title TipContract
    @author dkrsnadhe
*/

contract TipContract {
    address public owner;

    /*
     * @title TipReceived
     * @notice Event emitted upon receiving a tip.
     * @dev This event is triggered when a tip is received,
     * capturing the address of the tipper and the amount of the tip.
     * @param tipper The address of the account that sent the tip.
     * @param amount The amount of tokens or Ether received as a tip.
     */
    event TipReceived(address indexed tipper, uint256 amount);

    /*
     * @title TipWithdrawn
     * @notice Event emitted upon withdrawing a tip.
     * @dev This event is triggered when a tip is withdrawn,
     * capturing the address of the owner withdrawing the tip and the amount withdrawn.
     * @param owner The address of the account withdrawing the tip.
     * @param amount The amount of tokens or Ether withdrawn as a tip.
     */
    event TipWithdrawn(address indexed owner, uint256 amount);

    /*
     * @title Constructor
     * @notice Contract constructor setting the initial owner.
     * @dev This constructor is executed only once, during the deployment of the contract.
     * It sets the contract's initial owner to the address of the deployer.
     * The constructor is automatically called upon contract deployment.
     */
    constructor() {
        owner = msg.sender;
    }

    receive() external payable {}

    fallback() external payable {}

    /*
     * @title NotOwner
     * @notice Error declaration related to ownership validation.
     * @dev This error is used to manage situations or conditions associated with ownership,
     * such as an action performed by an unauthorized entity.
     */
    error NotOwner();

    /*
     * @title InsufficientAmount
     * @notice Error declaration related to insufficient amount validation.
     * @dev This error is used to manage situations or conditions where the provided amount is insufficient
     * for a particular action or operation within the contract.
     */
    error InsufficientAmount();

    /*
     * @title onlyOwner
     * @notice Modifier to restrict access to the contract's owner.
     * @dev This modifier checks whether the caller is the owner of the contract.
     * If the caller is not the owner, it reverts the transaction, throwing the NotOwner error.
     * It is used to restrict access to functions or operations that should only be
     * performed by the owner of the contract.
     */
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert NotOwner();
        }
        _;
    }

    /*
     * @title tip
     * @notice Function to send a tip to the contract.
     * @dev This function allows users to send a tip to the contract by sending Ether.
     * It checks whether the sent value is greater than zero. If the sent value is zero
     * or negative, it reverts the transaction, throwing the InsufficientAmount error.
     * Emits a TipReceived event upon successful reception of the tip.
     */
    function tip() external payable {
        if (msg.value <= 0) {
            revert InsufficientAmount();
        }
        emit TipReceived(msg.sender, msg.value);
    }

    /*
     * @title withdrawTip
     * @notice Function to withdraw accumulated tips from the contract.
     * @dev This function allows the contract owner to withdraw accumulated tips in Ether.
     * It retrieves the contract's current balance and checks if the balance is greater than zero.
     * If the balance is zero or negative, it reverts the transaction, throwing the InsufficientAmount error.
     * Then it attempts to transfer the entire contract balance to the owner's address.
     * If the transfer fails, it reverts the transaction with the message "transaction failed!".
     * Emits a TipWithdrawn event upon successful withdrawal of the tips.
     * This function can only be executed by the owner of the contract.
     */
    function withdrawTip() external onlyOwner {
        uint256 contractBalance = address(this).balance;
        if (contractBalance <= 0) {
            revert InsufficientAmount();
        }

        (bool success, ) = owner.call{value: contractBalance}("");
        require(success, "transaction failed!");

        emit TipWithdrawn(msg.sender, contractBalance);
    }

    /*
     * @title tipContractBalance
     * @notice Function to view the balance of the contract's Ether holdings.
     * @dev This function allows users to view the current balance of Ether held by the contract.
     * @return uint256 The current balance of Ether held by the contract.
     */
    function tipContractBalance() external view returns (uint256) {
        return address(this).balance;
    }
}
