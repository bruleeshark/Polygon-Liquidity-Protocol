pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";

contract plpBondDistributor is Ownable {
    using SafeMath for uint;

   address public multisig;
address public treasury;
address public plpAddress;
address public lpAddress;
uint public totalPLP;
uint public totalLP;
mapping(address => uint) public bondedPLP;
mapping(address => uint) public bondedLP;

struct Bond {
    uint lastClaimTime;
    uint claimedDays;
}

mapping(address => Bond) public bonds;

// Number of seconds in a day
uint public constant DAYS = 86400;

constructor(address _multisig, address _treasury, address _plpAddress, address _lpAddress) public {
    multisig = _multisig;
    treasury = _treasury;
    plpAddress = _plpAddress;
    lpAddress = _lpAddress;
}

function swapPLPForLP(uint _amount) public {
    require(ERC20(plpAddress).balanceOf(msg.sender) >= _amount, "Insufficient PLP balance");
    require(bondedPLP[msg.sender] >= _amount, "Insufficient bonded PLP balance");
    uint lpAmount = _amount.mul(9).div(10);
    totalPLP = totalPLP.add(_amount);
    totalLP = totalLP.add(lpAmount);
    bondedPLP[msg.sender] = bondedPLP[msg.sender].sub(_amount);
    bondedLP[msg.sender] = bondedLP[msg.sender].add(lpAmount);
    ERC20(plpAddress).transferFrom(msg.sender, address(this), _amount);
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
