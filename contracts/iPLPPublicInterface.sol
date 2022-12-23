pragma solidity ^0.6.0;

import "https://github.com/OpenZeppelin/openzeppelin-solidity/contracts/token/ERC20/SafeERC20.sol";

contract PLPInfoInterface {
    function multisig() external view returns (address);
    function treasury() external view returns (address);
    function totalPLP() external view returns (uint);
    function totalLP() external view returns (uint);
    function bondedPLP(address _owner) external view returns (uint);
    function bondedLP(address _owner) external view returns (uint);
    function lastClaimTime(address _owner) external view returns (uint);
    function claimedDays(address _owner) external view returns (uint);
    function balanceOf(address _owner) external view returns (uint);
}

interface PLPBondDistributor is PLPInfoInterface {
    function swapPLPForLP(uint _amount) external;
    function claimLP(uint _amount) external;
}

interface PLPToken is SafeERC20, PLPInfoInterface {
    function mint(address _to, uint _amount) external;
}
