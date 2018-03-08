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
	uint public totalTokensSold;

	uint public startTime;
    uint public endTime;

    modifier ownerOnly() {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }

    function Crowdsale(uint _totalSupply, uint _saleTime) public {
        owner = msg.sender;
        tokens = new Token(_totalSupply);
        startTime = now;
        endTime = now + _saleTime;
    }

    function mintTokens(uint256 _value) ownerOnly returns (bool success) {
        tokens.mint(_value);
        return true;
    }

    function burnTokens(uint256 _value) ownerOnly returns (bool success) {
        tokens.burn(_value);
        return true;
    }

}
