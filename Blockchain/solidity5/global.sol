pragma solidity ^0.5.0;
contract GlobalVariables{
    // this helps us in getting block information
    uint public this_moment = now;
    uint public _now = block.timestamp;
    uint public block_number = block.number;
    uint public difficulty = block.difficulty;
    uint public gasLimit = block.gaslimit;

    function get_txn_gas_price() public view returns(uint){
        returns tx.gasprice;
    }

}