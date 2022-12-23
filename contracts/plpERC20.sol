pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract plpERC20 is SafeERC20 {
    string public name = "Polygon Liquidity Protocol";
    string public symbol = "PLP";
    uint8 public decimals = 18;
    uint public totalSupply = 7000000 * (10 ** uint(decimals));

    constructor() public {
        // mint all tokens and assign them to the contract address
        _mint(address(this), totalSupply);
    }
}
