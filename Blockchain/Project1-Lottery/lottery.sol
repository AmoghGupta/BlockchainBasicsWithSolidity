pragma solidity ^0.5.1;

contract lottery{
    address[] public players; // dynamic array with playser addresses
    address public manager;

    constructor() public{
        // global varibale msg contains the address of the entity of the account that 
        //calls the constructor
        manager = msg.sender;


    } 

    // whenever someone sends ether to the contract
    // adding the address of the sender account that sent ether to smartcontract
    // fallback payable function will be automatically called when someone send ether
    function() payable external{
        //adding validations
        // require statement evaluates to true of false
        // if false then txn reverted
        require(msg.value > 0.01 ether);
        players.push(msg.sender);
        
    }

    function getBalance() public  view returns(uint){
        require(msg.sender == manager );
        // gets the current contract balance
        return address(this).balance;
    }

    function random() public view returns(uint256){
        return uint256(keccak256
        (abi.encodePacked(block.difficulty, block.timestamp ,players.length))
        );
    }


    function selectWinner() public{
        // only manager can select the winner
        require(msg.sender == manager);
        uint256 randomNumber = random();
        address payable winner;
        // calculate random index here
        uint256 winnerCalc = randomNumber % (players.length);
        
        // typecasted address to payble address
        winner = address(uint160(players[winnerCalc])); 
        // transfer to winners account
        winner.transfer(address(this).balance);

        // reset the players dynamic array for next lottery game
        players = new address[](0);
    }
}