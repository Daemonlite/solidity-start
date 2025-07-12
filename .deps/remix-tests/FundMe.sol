// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.4.22 <0.9.0;

// this contract allows you to take payments
import "@chainlink/contracts/src/v0.6/interfaces/AggregatorV3Interface.sol";
import "@chainlink/contracts/src/v0.6/vendor/SafeMathChainlink.sol";

contract FundMe {
    using SafeMathChainlink for uint256;

    mapping(address => uint256) public addressToAmountFunded;
    address[] public funders;
    address public  owner;
    constructor()  {
        owner = msg.sender;

    }

    function fund() public payable {
        //5 usd threshold
        // setting the usd to gwei
        uint256 minimumUSD = 50 * 10 ** 18;

        // if (msg.value < minimumUSD) {
        //     revert?
        // }
        require(getConversionRate(msg.value) >= minimumUSD,"You need to spend more eth");

       // the msg.sender and msg.value are keywords in all contracts
       // msg.sender is the sender of the function call or transaction
       // msg.value is how much they sent 
       addressToAmountFunded[msg.sender] += msg.value; 
       funders.push(msg.sender);
    }

    // what the ETH -> USD conversion rate
    function getVersion() public view returns (uint256) {
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        return priceFeed.version();
    } 

    function getPrice() public view returns (uint256) {
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x694AA1769357215DE4FAC081bf1f309aDC325306);
        (
            ,//uint80 roundId
            int256 answer
            ,//uint256 startedAt
            ,//uint256 updatedAt
            ,//uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        // convert to gwei
        return uint256(answer * 1000000000);
        
    }
    // 1000000000
    function getConversionRate (uint256 ethAmount) public view returns (uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountUsd = (ethPrice * ethAmount) / 1000000000000000000;
        return ethAmountUsd;
        // 29736313251
    }

    modifier onlyOwner {
        require(msg.sender == owner,"Only the owner can withdraw");
        _;
    }

    function withdraw() payable onlyOwner public {
        msg.sender.transfer(address(this).balance);

        for (uint funderIndex=0; funderIndex < funders.length; funderIndex++){
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        funders = new address[](0);
    }


}