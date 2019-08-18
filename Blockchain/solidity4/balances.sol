pragma solidity ^0.5.0;
contract Property{
    uint public price=90000;
    address public owner;
    address public caller;
    uint public last_sent_value;
    
   
 
    constructor() public{
        owner = msg.sender;
    }
    
    function getBalance() view public returns (uint){
        return address(this).balance;
    }
    
    function sendEther() payable public {
        last_sent_value = msg.value;
    }
    
    function setPrice(uint _price) public {
        caller = msg.sender;
        price = _price;
    }
    
    function gasCalculation() view public returns(uint){
        //current gas
        uint start = gasleft();
        uint j = 5;
        for(uint i=0; i<10; i++){
            j++;
        }
        // gasused = gasbefore - currentgasleft
        return start-gasleft();
        
    }
}