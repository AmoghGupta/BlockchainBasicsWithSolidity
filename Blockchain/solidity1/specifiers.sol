pragma solidity 0.5.1;

contract Message{
    uint public lines;
    
    function setLines(uint _lines) public{
            lines = _lines;
    }
    
     function getLines() public view returns(uint){
        return lines;
    }
}
