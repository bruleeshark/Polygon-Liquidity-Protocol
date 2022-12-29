pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/math/SafeMath.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/Address.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/ownership/Ownable.sol";
import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/utils/RateLimiter.sol";

contract plpBondDistributor is Ownable {
    using SafeMath for uint;

    address public multisig;
    address public treasury;
    address public plpAddress;
    address public lpAddress;
    uint public totalPLP;
    uint public totalLP;
    uint public constant MAX_SWAPS_PER_DAY = 10;
    mapping(address => uint) public bondedPLP;
    mapping(address => uint) public bondedLP;
    RateLimiter public rateLimiter;

    struct Bond {
        uint lastClaimTime;
        uint claimedDays;
    }

    mapping(address => Bond) public bonds;

    // Number of seconds in a day
    uint public constant DAYS = 86400;

function updateAddresses(address _multisig, address _treasury) onlyOwner {
    require(_multisig != address(0), "Multisig address cannot be the zero address");
    require(_treasury != address(0), "Treasury address cannot be the zero address");
    multisig = _multisig;
    treasury = _treasury;
    emit AddressesUpdated(_multisig, _treasury);
}

event AddressesUpdated(address _multisig, address _treasury);
event Swap(address indexed sender, uint amount, uint lpAmount);
event LPClaimed(address indexed _sender, uint _amount);

constructor(address _multisig, address _treasury, address _plpAddress, address _lpAddress) public {
    require(_multisig != address(0), "Multisig address cannot be the zero address");
    require(_treasury != address(0), "Treasury address cannot be the zero address");
    multisig = _multisig;
    treasury = _treasury;
    plpAddress = _plpAddress;
    lpAddress = _lpAddress;
    rateLimiter = new RateLimiter(MAX_SWAPS_PER_DAY, DAYS);
}

    function swapPLPForLP(uint _amount) public {
        require(_amount != 0, "Amount cannot be zero");
        require(rateLimiter.canExecute(msg.sender), "Maximum number of swaps per day exceeded");
        // Check that the user has sufficient balance and allowance for the PLP tokens
        require(ERC20(plpAddress).balanceOf(msg.sender) >= _amount, "Insufficient PLP balance");
        require(ERC20(plpAddress).allowance(msg.sender, address(this)) >= _amount, "Insufficient PLP allowance");
        require(bondedPLP[msg.sender] >= _amount, "Insufficient bonded PLP balance");
        uint lpAmount = _amount.mul(9).div(10);
        totalPLP = totalPLP.add(_amount);
        totalLP = totalLP.add(lpAmount);
        bondedPLP[msg.sender] = bondedPLP[msg.sender].sub(_amount);
        bondedLP[msg.sender] = bondedLP[msg.sender].add(lpAmount);
        ERC20(plpAddress).transferFrom(msg.sender, address(this), _amount);
        ERC20(lpAddress).transfer(msg.sender, lpAmount);
        rateLimiter.execute(msg.sender);
        emit Swap(msg.sender, _amount, lpAmount);
}

    function claimLP(uint _amount) public {
        require(_amount != 0, "Amount cannot be zero");
        require(rateLimiter.canExecute(msg.sender), "Maximum number of swaps per day exceeded");
        require(bondedLP[msg.sender] >= _amount, "Insufficient bonded LP balance");
        require(ERC20(lpAddress).balanceOf(msg.sender) >= _amount, "Insufficient LP balance");
        Bond storage bond = bonds[msg.sender];
        uint daysSinceBonding = now.sub(bond.lastClaimTime).div(DAYS);
        require(daysSinceBonding >= bond.claimedDays + _amount, "LP tokens are not yet fully unlocked");
        bondedLP[msg.sender] = bondedLP[msg.sender].sub(_amount);
        bond.claimedDays = bond.claimedDays.add(_amount);
        ERC20(lpAddress).transfer(msg.sender, _amount);
        rateLimiter.execute(msg.sender);
    emit LPClaimed(msg.sender, _amount);
    }
}

function getBondedBalances(address _address) public view returns (uint, uint) {
    return (bondedPLP[_address], bondedLP[_address]);
}

function updateMultisig(address _newMultisig) public onlyOwner {
    // Check that the new multisig address is not the zero address
    require(_newMultisig != address(0), "New multisig address cannot be the zero address");

    // Save the old multisig address and update the multisig address
    address oldMultisig = multisig;
    multisig = _newMultisig;

    // Emit the MultisigUpdated event
    emit MultisigUpdated(oldMultisig, multisig);
}
