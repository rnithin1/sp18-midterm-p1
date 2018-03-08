pragma solidity ^0.4.15;

import './Queue.sol';
import './Token.sol';

/**
 * @title Crowdsale
 * @dev Contract that deploys `Token.sol`
 * Is timelocked, manages buyer queue, updates balances on `Token.sol`
 */

contract Crowdsale {

	address owner;
    Queue public buyers;
	Token public tokens;
    uint public worth;
	uint public totalTokensSold;

	uint public startTime;
    uint public endTime;

    event Purchase(address _purchaser, uint256 _value);
    event Refund(address _refunder, uint256 _value);

    modifier ownerOnly() {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }

    modifier onTime() {
        if (now < startTime || now > endTime) {
            throw;
        }
        _;
    }

    modifier validAmount() {
        if (tokens.totalSupply() < totalTokensSold) {
            throw;
        }
        _;
    }

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        owner = msg.sender;
        tokens = new Token(_totalSupply);
        startTime = now;
        endTime = now + _saleTime;
        totalTokensSold = 0;
    }

    function timeLeft() public returns (uint) {
        return endTime - startTime;
    }

    function mintTokens(uint256 _value) ownerOnly returns (bool success) {
        tokens.mint(_value);
        return true;
    }

    function burnTokens(uint256 _value) ownerOnly returns (bool success) {
        tokens.burn(_value);
        return true;
    }

    function buyToken() onTime validAmount public payable external returns (bool success) {
        if (buyers.getFirst() != msg.sender) {
            return false;
        } else {
            Purchase(msg.sender, msg.value * worth);
            tokens.transferFrom(this, msg.sender, msg.value * worth);
            totalTokensSold += msg.value;
            return true;
        }
    }

    function refundToken() onTime validAmount public payable external returns (bool success) {
        Refund(msg.sender, msg.value * worth);
        tokens.transferFrom(msg.sender, this, msg.value * worth);
        totalTokensSold -= msg.value;
        return true;
    }

    function transferOwner() ownerOnly returns (bool success) {
        if (now < endTime) {
            return false;
        } else {
            tokens.transferFrom(this, owner, this.balance);
        }
    }

    function () {

    }
}
