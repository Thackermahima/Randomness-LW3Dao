// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Game{
constructor() payable {}

function pickACard() private view returns(uint256){
 // Here abi.encodePacked takes two arguments blockhash and block.timestamp;
 // And returns a byte array which furthur gets passed to the keccak in returns bytes32.
 // which is further convered to a uint.
 // keccak takes in a byte array and convert it to the bytes32.
  uint256 pickedCard  = uint256( 
    keccak256(
        abi.encodePacked(blockhash(block.number), block.timestamp)
    )
  );
  return pickedCard;
}

function guess(uint256 _guess) public{
    uint256 _pickedCard = pickACard();
    if(_guess == _pickedCard){
        (bool sent, ) = msg.sender.call{value: 0.1 ether}("");
        require(sent,"Failed to sent ethers");
    }
}

//Returns the balance of ether in a contract.

function getBalance() public view returns(uint256){
 return address(this).balance;
}
}