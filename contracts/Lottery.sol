pragma solidity >=0.4.20;

contract Lottery{
    
    //variable to store manager address
    address public manager;
    
    //storing the address of participants
    
    address[] public participants;
    
    
    constructor () public {
        manager = msg.sender;
    }
    
    //function to enter the lottery, we are going to make each user pay a small amount to enter the lottery
    
    function enterLottery() public payable {
        require(msg.value > 0.01 ether);
        participants.push(msg.sender);
    }
    
    
    function pickWinner() public {
        //only the manager is able to call this function
        require(msg.sender==manager);
        
        //select a random participant
        uint index = random() % participants.length;        
        
        //transfer the contract balance to the participants
        participants[index].transfer(address(this).balance);
        
        
        //empty the array inorder to start a new lottery
        
        participants= new address[](0);
        
    }
    
    
    function random() private view returns(uint256){
        return uint256(keccak256(abi.encodePacked(block.difficulty, block.timestamp, participants)));
    }

}

