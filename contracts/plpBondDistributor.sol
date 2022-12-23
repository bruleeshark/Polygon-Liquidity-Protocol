pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";

contract PLPBondDistributor {
    using SafeMath for uint;

    address public multisig;
    address public treasury;
    uint public totalPLP;
    uint public totalLP;
    mapping(address => uint) public bondedPLP;
    mapping(address => uint) public bondedLP;

    constructor(address _multisig, address _treasury) public {
        multisig = _multisig;
        treasury = _treasury;
    }

    function swapPLPForLP(uint _amount) public {
        require(ERC20(plpAddress).balanceOf(msg.sender) >= _amount, "Insufficient PLP balance");
        uint lpAmount = _amount.mul(9).div(10);
        totalPLP = totalPLP.add(_amount);
        totalLP = totalLP.add(lpAmount);
        bondedPLP[msg.sender] = bondedPLP[msg.sender].add(_amount);
        bondedLP[msg.sender] = bondedLP[msg.sender].add(lpAmount);
        ERC20(lpAddress).transfer(msg.sender, lpAmount);
    }

    function claimLP(uint _amount) public {
        require(bondedLP[msg.sender] >= _amount, "Insufficient bonded LP balance");
        uint daysSinceBonding = now.sub(bondedLP[msg.sender].lastClaimTime).div(1 days);
        require(daysSinceBonding >= bondedLP[msg.sender].claimedDays + _amount, "LP tokens are not yet fully unlocked");
        bondedLP[msg.sender] = bondedLP[msg.sender].sub(_amount);
        bondedLP[msg.sender].lastClaimTime = now;
        bondedLP[msg.sender].claimedDays = bondedLP[msg.sender].claimedDays.add(_amount);
        ERC20(lpAddress).transfer(msg.sender, _amount);
    }
}
