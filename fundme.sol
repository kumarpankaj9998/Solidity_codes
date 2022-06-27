//SPDX-License-Identifier: MIT

pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe{
    using PriceConverter for uint256;


    uint256 public minimumUsd=50*1e18;
    
    address[] public funders;

    address public owner;
    
    constructor(){
        owner=msg.sender;
                 }

    mapping(address=>uint256)public addressToAmontFunded;

    function fund() public payable{

         require(msg.value.getConversionRate()>minimumUsd,"Didn't have enough funds");
         funders.push(msg.sender);
         addressToAmontFunded[msg.sender]=msg.value;
          }


    function withdraw() public onlyOwner {
        require(msg.sender == owner,"Sender is not owner!");
            for(uint256 index=0; index < funders.length; index++)
            {
                address funder=funders[index];
                addressToAmontFunded[funder]=0;


            }

            //RESETTING THE ARRAY
            funders= new address[](0);
            //actually withraw the funds

            //tranfer
        // payable(msg.sender).tranfer(address(this).balance);
        //     //send
        // bool successTransfer= payable(msg.sender).send(address(this).balance);
        // require(successTransfer,"Send failed");
        //     //call
        (bool callSuccess, )=payable(msg.sender).call{value:address(this).balance}("");//("") we will define funtion inside this
        //CallSuccess->true/false  dataReturned->returned from the call funtion which is called inside 
        require(callSuccess,"Call failed");
    }

    modifier onlyOwner {
        require(msg.sender==owner ,"Sender is not the owner of the contract");
        _;
    }

       
   
}
