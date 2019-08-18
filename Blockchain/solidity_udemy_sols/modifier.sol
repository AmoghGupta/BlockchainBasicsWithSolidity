pragma solidity ^0.5.1;

contract Property{
    
    uint public price = 9000;
    string public location = "Hamburg";
    address public owner;
    
    // whoever deploys the contract becomes the owner
    // constructor runs only once at the time of deployment
    constructor() public{
       //calls the constructor
        owner = msg.sender;
    } 
    
    //function modifier
    modifier onlyOwner{
         require(msg.sender == owner);
         _;
    }
    
    function getBalance() view public onlyOwner returns (uint){
        return address(this).balance;
    }
    
    function setPrice(uint _price) onlyOwner public {
         require(_price > price);
         price = _price;
    } 
    
    function setLocation(string memory _location) onlyOwner public {
         location = _location;
    } 
    
    
    
}