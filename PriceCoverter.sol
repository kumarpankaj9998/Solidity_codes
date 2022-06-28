//SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";


library PriceConverter{

 function getPrice() internal view returns(uint256) {
                //ABI
                // address 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
                 AggregatorV3Interface priceFeed= AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
                 (,int price,,,)=priceFeed.latestRoundData();
                  
                 return uint256(price * 1e10);//cuz price will 8th decimal and wei is of 18th decimal

        }

        function getConversionRate(uint256 ethAmt) internal view returns (uint256){
 
            uint256 ethprice= getPrice();
            uint256 ethAmtInUsd= (ethprice*ethAmt)/1e18;

            return ethAmtInUsd;

        }
       
    // function getVersion() internal view returns (uint256){
    //       AggregatorV3Interface priceFeed= AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);
    //       returns priceFeed.version();

    // }


}
// pragma solidity ^0.8.8;

// import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

// // Why is this a library and not abstract?
// // Why not an interface?
// library PriceConverter {
//     // We could make this public, but then we'd have to deploy it
//     function getPrice() internal view returns (uint256) {
//         // Rinkeby ETH / USD Address
//         // https://docs.chain.link/docs/ethereum-addresses/
//         AggregatorV3Interface priceFeed = AggregatorV3Interface(
//             0x8A753747A1Fa494EC906cE90E9f37563A8AF630e
//         );
//         (, int256 answer, , , ) = priceFeed.latestRoundData();
//         // ETH/USD rate in 18 digit
//         return uint256(answer * 10000000000);
//     }

//     // 1000000000
//     function getConversionRate(uint256 ethAmount)
//         internal
//         view
//         returns (uint256)
//     {
//         uint256 ethPrice = getPrice();
//         uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1000000000000000000;
//         // the actual ETH/USD conversion rate, after adjusting the extra 0s.
//         return ethAmountInUsd;
//     }
// }

