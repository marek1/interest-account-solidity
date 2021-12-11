// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract InterestAccount {
    uint duration = 0;
    mapping (address => uint) balances;
    mapping (address => uint) depositDay;

    function deposit(address depositAddress, uint amount) public {
        require(balances[depositAddress] == 0, "Only 1 deposit per address");
        require(amount > 0, "Deposit an amount > 0 eth");
        balances[depositAddress] += amount;
        depositDay[depositAddress] = block.timestamp; // - 91 days;
    }

    function withdraw(address depositAddress, uint amount) public {
        require(amount <= balances[depositAddress], "Withdraw amount exceeds Deposit");
        require(canWithdraw(depositAddress), "Withdraw only possible after 90 days");
        balances[depositAddress] -= amount;
    }

    function getBalance(address depositAddress) public view returns(uint) {
        return balances[depositAddress];
    }

    function canWithdraw(address depositAddress) public view returns(bool) {
        return block.timestamp >= depositDay[depositAddress] + (duration * 1 days);
    }
}
