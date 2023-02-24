// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.8.0 <0.9.0;
import "./customLib.sol";
contract Part2_token
{
    address payable public owner;
    string internal name;
    string internal symbol;
    uint256 internal price;
    uint256 internal totalsupply;
    mapping(address => uint256) internal balances;
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Mint(address indexed to, uint256 value);
    event Sell(address indexed from, uint256 value);
    
    
    constructor() {
        name = "Custom Token";
        symbol = "CT";
        price = 600;
        // Define the contract's owner
        owner =  payable(msg.sender);
        totalsupply = 10000;
        balances[owner] = totalsupply;
        emit Mint(owner, totalsupply);
    }

    // Function to check the balance of an address
    function balanceOf(address _account) public view returns (uint256){
        return balances[_account];
    }

    function totalSupply() public view returns(uint256){
        return totalsupply;
    }

    function getName()public view returns(string memory){
        return name;
    }

    function getSymbol() public view returns (string memory){
        return symbol; 
    }

    function getPrice() public view returns (uint256){
        return price; 
    }

    function transfer(address to, uint256 value) public returns (bool){
        // Check that the caller has sufficient balance
        require(balances[msg.sender] >= value, "Insufficient balance");
        // Check that the recipient is not the zero address
        require(to != address(0), "Invalid recipient");
        // Transfer tokens and update balances
        balances[msg.sender] -=value;
        balances[to] +=value;

        // Emit the transfer event
        emit Transfer(msg.sender, to, value);
        return true; 
    }
    
    function mint(address to, uint256 value) public returns (bool){
        require(msg.sender == owner, "Only the owner can mint tokens");
        totalsupply += value;
        balances[to] += value;
        emit Mint(to, value); 
        return true;
    }

    function sell(uint256 value) public payable returns (bool){
        require(balances[msg.sender] >= value, "Insufficient balance");

        uint256 weiReceived = value * price;
        require (address(this).balance >= weiReceived,"Insufficient contract balance");
        bool flag= customLib.customSend(weiReceived,msg.sender);
        require (flag,"Fail to send");
        balances[msg.sender] -= value;
        // Update the total supply of tokens
        totalsupply -= value;
        // Calculate the amount of wei to be received by the seller

        // Emit the Sell event
        emit Sell(msg.sender, value);
        return true;
    }

    function close() public {
        // Check that the caller is the owner
        require(msg.sender == owner, "Only the owner can close the contract");

        // Transfer the contract's balance to the owner and destory the contract
        bool flag=customLib.customSend(address(this).balance,owner);
        require(flag,"Fail to close");
        selfdestruct(owner);
    }
    fallback() external payable {
        // Do nothing, as the fallback function does not need to perform any action
    }
    receive() external payable {
        // to ignore warnings
    }
}