// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Project {
    // --- State Variables ---
    address public owner;
    string public projectName;
    uint256 public balance;

    // --- Events ---
    event FundsDeposited(address indexed from, uint256 amount);
    event FundsWithdrawn(address indexed to, uint256 amount);

    // --- Constructor ---
    constructor(string memory _projectName) {
        owner = msg.sender;
        projectName = _projectName;
        balance = 0;
    }

    // --- Core Function 1: Deposit funds ---
    function deposit() public payable {
        require(msg.value > 0, "Deposit amount must be greater than zero");
        balance += msg.value;
        emit FundsDeposited(msg.sender, msg.value);
    }

    // --- Core Function 2: Withdraw funds (only owner) ---
    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "Only owner can withdraw");
        require(_amount <= balance, "Insufficient balance");
        balance -= _amount;
        payable(owner).transfer(_amount);
        emit FundsWithdrawn(owner, _amount);
    }

    // --- Core Function 3: Get contract balance ---
    function getBalance() public view returns (uint256) {
        return balance;
    }
}
