pragma solidity 0.5.1;

contract Property{
    uint public price;
    string public location  ='London';
    
    function setPrice(uint _price) public{
            price = _price;
    }
    
     function getPrice() public view returns(uint){
        return price;
    }
}
