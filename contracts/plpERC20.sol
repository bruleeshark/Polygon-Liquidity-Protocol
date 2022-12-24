pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "./plpOracle.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";

contract plpERC20 is SafeERC20 {
    using SafeMath for uint;
    string public name = "Polygon Liquidity Protocol";
    string public symbol = "PLP";
    uint8 public decimals = 18;
    uint public totalSupply = 7000000 * (10 ** uint(decimals));
    plpOracle public priceOracle;

    constructor() public {
        // mint all tokens and assign them to the contract address
        _mint(address(this), totalSupply);
    }

    function setPriceOracle(plpOracle _priceOracle) public onlyOwner {
        require(Address.isContract(_priceOracle), "Provided address is not a contract");
        priceOracle = _priceOracle;
        emit OracleUpdated(priceOracle);
    }

    function getPrice() public view returns (uint) {
        return priceOracle.getPrice();
    }

    event OracleUpdated(plpOracle _priceOracle);
}
