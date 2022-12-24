pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract plpOracle {
    using SafeMath for uint256;
    using Address for address;

    address public owner;
    uint256 public price;
    address public balancerPool;

    constructor(address _balancerPool) public {
        owner = msg.sender;
        balancerPool = _balancerPool;
    }

    function updatePrice() onlyOwner {
        // Fetch the current price of the PLP token in the Balancer pool
        price = IBalancerPool(balancerPool).getTokenPrice(address(this)).div(1e18);
    }

    function getPrice() public view returns (uint256) {
        return price;
    }
}
