pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract plpERC20 is SafeERC20 {
    string public name = "Polygon Liquidity Protocol";
    string public symbol = "PLP";
    uint8 public decimals = 18;
    uint public totalSupply = 7000000 * (10 ** uint(decimals));
    PriceFeed public priceFeed;
    PriceOracle public priceOracle;

    constructor() public {
        // mint all tokens and assign them to the contract address
        _mint(address(this), totalSupply);
        // Set the address of the oracle contract as the price feed
        priceFeed = PriceOracle(priceOracle);
    }
}

  // Function to set the address of the oracle contract
  function setPriceOracle(PriceOracle _priceOracle) public onlyOwner {
    priceOracle = _priceOracle;
  }
}
