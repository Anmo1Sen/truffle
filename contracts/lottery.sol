// SPDX-License-Identifier: MIT 

pragma solidity >=0.5.0 < 0.9.0;

contract lottery
{
address public manager;
address payable [] public players;

constructor() {
manager = msg.sender;

}

function alreadyEnterd()view private returns (bool)
{
    for(uint i =0;i<players.length; i++){
        if (players[i] ==msg.sender)
        return true;
    } 
    return false;
}

function enter() payable public
{
require(msg.sender!= manager, "manager cant enter");
require( alreadyEnterd() == false, "already entered");
require(msg.value>=1 ether, "min req not filled");
players.push(payable(msg.sender));
}
function random() view private returns(uint){
return uint(sha256(abi.encodePacked(block.difficulty,block.number,players)));
}
function pickWinner()public{
require (msg.sender == manager, "gggg");
uint index= random()% players.length;
address contractAddress = address(this);
 players[index].transfer(contractAddress.balance);
players = new address payable[](0);
}
function getPlayers() view public returns(address payable[] memory){
return players;
}


}