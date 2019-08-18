// so basically we cannot expose the smart contract directly becuase of security issues
// so we create a contract that deploys our contract in this way we prevent out main contract code

pragma solidity ^0.5.1;

contract A{
    address public ownerA;
    
    constructor(address _eoa) public{
        ownerA = _eoa;
    }
    
}

contract Creator{
    address public ownerCreator;
    A[] public deployedA;
    
    constructor() public{
        ownerCreator = msg.sender;
    }
    
    function deployA() public{
        A new_A_address = new A(msg.sender);
        deployedA.push(new_A_address);
    }
}