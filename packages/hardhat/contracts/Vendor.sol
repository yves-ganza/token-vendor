pragma solidity 0.8.4;
// SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/access/Ownable.sol";
import "./YourToken.sol";

contract Vendor is Ownable {

  event BuyTokens(address buyer, uint256 amountOfETH, uint256 amountOfTokens);

  event SellTokens(address seller, uint amountofEth, uint amountOfTokens);

  YourToken public yourToken;
  uint public constant tokensPerEth = 100;

  constructor(address tokenAddress) {
    yourToken = YourToken(tokenAddress);
  }

  
  function buyTokens() public payable {
    uint amountOfTokens = msg.value * tokensPerEth;
    yourToken.transfer(msg.sender, amountOfTokens);
    emit BuyTokens(msg.sender, msg.value, amountOfTokens);
  }

  function withdraw() public onlyOwner {
    uint amount = address(this).balance;
    (bool success, ) = payable(msg.sender).call{value: amount}("");
    require(success, "Withdraw failed!");
  }

  function sellTokens(uint amount) public{
    bool success = yourToken.transferFrom(msg.sender, address(this), amount);
    require(success, "Transaction failed, check for token approval!");

    uint amountToPay = amount/tokensPerEth;

    (success, ) = payable(msg.sender).call{value: amountToPay}("");
    require(success, "Sell failed!");
    emit SellTokens(msg.sender, amountToPay, amount);
  }
}
