// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract InterestAccount {
    uint interest = 5;
    uint minDuration = 90;
    uint daysInMilliseconds = 86400000;
    uint daysInOneYear = 365;
    mapping (address => uint) balances;
    mapping (address => uint) depositDay;

    function deposit(address depositAddress, uint amount) public {
        require(balances[depositAddress] == 0, "Only 1 deposit per address");
        require(amount > 0, "Deposit an amount > 0 eth");
        balances[depositAddress] += amount;
        depositDay[depositAddress] = block.timestamp;
    }

    function withdraw(address depositAddress) public {
        require(getDaysAccrued(depositAddress) > minDuration, "Withdraw only possible after minimum days");
        balances[depositAddress] -= getBalance(depositAddress) + getInterestAccrued(depositAddress);
    }

    function getBalance(address depositAddress) public view returns(uint) {
        return balances[depositAddress];
    }

    function getDaysAccrued(address depositAddress) private view returns(uint) {
        return (block.timestamp - depositDay[depositAddress]) / daysInMilliseconds;
    }

    function getInterestAccrued(address depositAddress) private view returns(uint) {
        return (getDaysAccrued(depositAddress) / daysInOneYear) * interest;
    }
}
