pragma solidity ^0.5.1;

contract AuctionCreator{
    Auction[] public auctions;

    function createAuction() public{
        Auction newAuction = new Auction(msg.sender);
        auctions.push(newAuction);
    }
}



contract Auction{
    
    address public owner;
    uint startBlock;
    uint endBlock;
    string public ipfsHash;
    
    // enum for current state of the auction
    enum State {
        Started,
        Running,
        Ended,
        Cancelled
    }
    
    State public auctionState;
    
    //highest bid number till now
    uint public highestBindingBid;
    // address of the highest bidder
    address public highestBidder;
    // the amount by which the bid will increment
    uint bidIncrement;
    
    // for storing the address and its bids
    mapping(address => uint) public bids;
    
    
   
    
    // whoever deploys the contract becomes the owner
    // constructor runs only once at the time of deployment
    constructor(address creator) public{
       //calls the constructor
       owner = creator;
       auctionState = State.Running;
       startBlock = block.number;
       endBlock = startBlock + 40320; // auction runs for a week
       ipfsHash = "";
       bidIncrement = 10;
    } 
    
    modifier notOwner(){
        require(msg.sender != owner);
        _;
    }

    modifier onlyOwner(){
        require(msg.sender == owner);
        _;
    }
    
    modifier afterStart(){
        require(block.number >= startBlock);
        _;
    }
    
    modifier beforeEnd(){
        require(block.number <= endBlock);
        _;
    }

    function cancelAuction() public onlyOwner{
        auctionState = State.Cancelled;
    }
    
    function min(uint a, uint b) pure internal returns(uint){
        if(a<=b){
            return a;            
        }else{
            return b;
        }
    }
    
    // function runs only if the constraints are satisfied
    
    function placeBid() public notOwner afterStart beforeEnd payable returns(bool){
        require(auctionState == State.Running);
        
        //require(msg.value > 0.001 ether);
        
        // old bid + new value which the sender is bidding
        uint currentBid = bids[msg.sender] + msg.value;
        
        // currentBid should be greater than the highestBindingBid till now
        require(currentBid > highestBindingBid);
        
        //updated bid of the sender
        bids[msg.sender] = currentBid;
        
        if(currentBid <= bids[highestBidder]){
            highestBindingBid = min(currentBid+bidIncrement, bids[highestBidder]);
        }else{
            highestBindingBid = min(currentBid, bids[highestBidder]+bidIncrement);
            highestBidder = msg.sender;
        }
        
        return true;
        
    } 

    function finalizeAuction() public{

        //auction ended
        require(auctionState == State.Cancelled || block.number > endBlock);
        // participant is either owner or bidder
        require(msg.sender == owner || bids[msg.sender]>0);

        address recipient;
        
        address payable finalRecipient;
        
        uint value;

        // if auction cancelled everyone receives money back
        if(auctionState == State.Cancelled ){
            recipient = msg.sender;
            value = bids[msg.sender];
        }
        // if auction ended then owner gets all the money
        // highest bidder gets the difference amount
        // rest reciepient gets their money back
        else{
            //owner
            if(msg.sender == owner){
                recipient = owner;
                value = highestBindingBid;
            }else{
                // highest bidder 
                if(msg.sender == highestBidder){
                    recipient = highestBidder;
                    value = bids[highestBidder]-highestBindingBid;
                }else{// this is neither owner nor highest bidder
                    recipient = msg.sender;
                    value = bids[recipient];
                }
            }
        }

        // typecasted address to payble address
        finalRecipient = address(uint160(recipient)); 
        // transfer to winners account
        finalRecipient.transfer(value);

    }   
}