// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (access/Ownable.sol)
pragma solidity ^0.8.0;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/access/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/utils/math/SafeMath.sol";

contract Allowance is Ownable
{
    using SafeMath for uint;

    event AllowanceDetails(address indexed _fromWho, address indexed _toWho, uint _oldAmount, uint _newAmount);

    mapping(address=>uint) public allowance;

    function setAllowance(address _who, uint _amount) public onlyOwner
    {
        emit AllowanceDetails(msg.sender, _who, allowance[_who], _amount);
        allowance[_who] = _amount;
    }

    modifier OwnerORAllowed(uint _amount)
    {
        require(owner() == msg.sender || allowance[msg.sender] >= _amount, "You are not allowed");
        _;
    }

    function reduceAllowance(address _who, uint _amount) internal
    {
        emit AllowanceDetails(msg.sender, _who, allowance[_who], allowance[_who].sub(_amount));
        allowance[_who] = allowance[_who].sub(_amount);
    }
}
