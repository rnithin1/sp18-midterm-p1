pragma solidity ^0.4.15;

import './interfaces/ERC20Interface.sol';

/**
 * @title Token
 * @dev Contract that implements ERC20 token standard
 * Is deployed by `Crowdsale.sol`, keeps track of balances, etc.
 */

contract Token is ERC20Interface {
    // uint256 _totalSupply;
    address owner;
    mapping(address => uint256) balances;
    mapping(address => mapping (address => uint256)) allowed;

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    event Burned(address indexed _burner, uint256 _value);
    event Minted(uint256 _value);

    modifier ownerOnly() {
        if (msg.sender != owner) {
            throw;
        }
        _;
    }

    function Token(uint256 amount) {
        totalSupply = amount;
        owner = msg.sender;
    }

    // function totalSupply() constant returns (uint256 _totalSupply) {
    //     return _totalSupply;
    // }

    function balanceOf(address _owner) constant returns (uint256 balance) {
        return balances[_owner];
    }

    function transfer(address _to, uint256 _value) returns (bool success) {
        if (balances[msg.sender] < _value) {
            return false;
        } else {
            Transfer(msg.sender, _to, _value);
            balances[msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
    }

    function transferFrom(address _from, address _to, uint256 _value) returns
    (bool success) {
        if (allowed[_from][msg.sender] < _value
            || balances[_from] < _value) {
                return false;
        } else {
            Transfer(_from, _to, _value);
            balances[_from] -= _value;
            allowed[_from][msg.sender] -= _value;
            balances[_to] += _value;
            return true;
        }
    }

    function approve(address _spender, uint256 _value) returns (bool success)
    {
        Approval(msg.sender, _spender, _value);
        allowed[msg.sender][_spender] = _value;
        return true;
    }

    function allowance(address _owner, address _spender) constant returns
    (uint256 remaining) {
        return allowed[_owner][_spender];
    }

    function burn(uint256 _value) returns (bool success) {
        if (balances[msg.sender] < _value) {
            return false;
        } else {
            Burned(msg.sender, _value);
            balances[msg.sender] -= _value;
            totalSupply -= _value;
            return true;
        }
    }

    function mint(uint256 _value) ownerOnly returns (bool success) {
        Minted(_value);
        totalSupply += _value;
        return true;
    }

    function () {

    }
}
