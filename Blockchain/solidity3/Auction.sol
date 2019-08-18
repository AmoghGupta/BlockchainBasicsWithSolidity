pragma solidity 0.5.1;

contract Auction{
    struct Car{
       string description;
       uint value;
       uint built_year;
   }
   enum State {Running, Stopped, Inactive}
   
   Car public private_car;
   mapping(address=>Car) public cars;
   mapping(address=>uint) public bids;
   State public status = State.Running;

   constructor(string memory _desciption, uint _value, uint _builtYear) public {
       private_car.description = _desciption;
       private_car.value = _value;
       private_car.built_year = _builtYear;
       
       cars[msg.sender] = private_car;
   }
   
   function modifyCar(string memory _desciption, uint _value, uint _builtYear) public returns(bool){
       if(status == State.Running){
           Car memory newCar; 
           newCar.description = _desciption;
           newCar.value = _value;
           newCar.built_year = _builtYear;
       
            private_car = newCar;
            return true;
       } else{
             return false;
       }
       
       
       
   }
   
   function bid() payable public{
       bids[msg.sender] = msg.value;
   }
}
