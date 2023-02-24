// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.0;

contract Token {
    // Public variables
    address public owner;
    string internal name;
    string internal symbol;
    uint128 internal price;
    uint256 internal mytotalSupply;
    mapping(address => uint256) internal mybalanceOf;

    // Events
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Sell(address indexed from, uint256 value);

    // Constructor function
    constructor() public {
        owner = msg.sender;
        name = "Custom Token";
        symbol = "CT";
        price = 600;
        mytotalSupply = 0;
    }
  // Public functions
  //Returns the total amount of minted tokens
    function totalSupply() public view returns (uint256) {
        return mytotalSupply;
    }
  // Returns the amount of tokens an address owns
    function balanceOf(address _account) public view returns (uint256) {
        return mybalanceOf[_account];
    }


    function getName() public view returns (string memory) {
        return name;
    }

    function getSymbol() public view returns (string memory) {
        return symbol;
    }

    function getPrice() public view returns (uint128) {
        return price;
    }

    function transfer(address to, uint256 value) public payable returns (bool) {
        require(value > 0, "Invalid value");
        require(mybalanceOf[msg.sender] >= value, "Insufficient balance");

        mybalanceOf[msg.sender] -= value;
        mybalanceOf[to] += value;

        emit Transfer(msg.sender, to, value);
        return true;
    }

    function mint(address to, uint256 value) public payable returns (bool) {
        require(msg.sender == owner, "Only owner can mint tokens");
        require(value > 0, "Invalid value");
        
        mybalanceOf[to] += value;
        mytotalSupply += value;

        emit Mint(to, value);
        return true;
    }

    function sell(uint256 value) public payable returns (bool) {
        require(value > 0, "Invalid value");
        require(mybalanceOf[msg.sender] >= value, "Insufficient balance");
        
        mybalanceOf[msg.sender] -= value;
        mytotalSupply -= value;
        msg.sender.transfer(value * price);
        emit Sell(msg.sender, value);
        return true;
    }

function close() public {
    require(msg.sender == owner, "Only owner can close contract");
    // Transfer contract's balance to owner
    msg.sender.transfer(mybalanceOf[msg.sender]);
    // Destroy contract
    selfdestruct(msg.sender);
}

 fallback () external payable {
}
receive()external payable{

}
}