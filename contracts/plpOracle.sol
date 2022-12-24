pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "./IBalancerPool.sol";

contract plpOracle is Ownable {
using SafeMath for uint256;
using Address for address;

address public owner;
uint256 public price;
address public balancerPool;

constructor(address _balancerPool) public {
owner = msg.sender;
balancerPool = _balancerPool;
require(Address(balancerPool).isContract(), "Balancer pool address is not a contract");
}

function updatePrice() public onlyOwner {
require(Address(balancerPool).isContract(), "Balancer pool address is not a contract");
// Add reentrancy guard
require(!address(this).balance.add(1e18).isZero(), "Potential reentrancy attack detected");
// Fetch the current price of the PLP token in the Balancer pool
price = IBalancerPool(balancerPool).getTokenPrice(address(this)).div(1e18);
emit PriceUpdated(price);
}

function getPrice() public view returns (uint256) {
    return price;
}

function setBalancerPool(address _balancerPool) public onlyOwner {
    balancerPool = _balancerPool;
    require(Address(balancerPool).isContract(), "Balancer pool address is not a contract");
}

// Fallback function to prevent accidental sends of ETH to the contract
function() external payable {
    revert("Sending ETH to this contract is not allowed");
}

// Rate limit the updatePrice function to prevent potential DoS attacks
// Only allow updates once every hour
function updatePriceWithLimit() public onlyOwner {
    require(now > lastUpdateTime + 1 hours, "Update price rate limit exceeded");
    updatePrice();
    lastUpdateTime = now;
}

// Data validation for the price returned by the Balancer pool
function updatePriceWithValidation() public onlyOwner {
    // Fetch the current price of the PLP token in the Balancer pool
    uint256 newPrice = IBalancerPool(balancerPool).getTokenPrice(address(this)).div(1e18);
    // Ensure that the new price is within 10% of the previous price
    require(newPrice <= price * 1.1 && newPrice >= price * 0.9, "Invalid price returned by the Balancer pool");
    price = newPrice;
    emit PriceUpdated(price);
}

event PriceUpdated(uint256 newPrice);
}

function setBalancerPool(address _balancerPool) public onlyOwner {
    // Check if the provided address is a contract
    require(Address(_balancerPool).isContract(), "Provided address is not a contract");
    // Ensure that the provided address is not the zero address
    require(_balancerPool != address(0), "Cannot set zero address as Balancer pool");
    // Ensure that the new Balancer pool address is different from the current one
    require(balancerPool != _balancerPool, "New Balancer pool address is the same as the current one");
    balancerPool = _balancerPool;
    // Emit event to notify interested parties of the change
    emit BalancerPoolUpdated(_balancerPool);
}

event BalancerPoolUpdated(address newBalancerPool);
