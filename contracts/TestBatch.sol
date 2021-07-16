pragma solidity ^0.6.6;

interface IFxBridge {
    function sendToFx(address _tokenContract, bytes32 _destination, bytes32 _targetIBC, uint256 _amount) external;
}

interface IERC20 {
    function approve(address spender, uint value) external returns (bool);

    function transferFrom(address from, address to, uint value) external returns (bool);
}

contract TestBatch {
    uint unit = 1e18;

    function sendToFx(address token, address bridge, bytes32 destination, bytes32 targetIBC, uint number) public {
        bool transferRes = IERC20(token).transferFrom(msg.sender, address(this), number * unit);
        IERC20(token).approve(bridge, number * unit);
        for (uint i = 0; i < number; i++) {
            IFxBridge(bridge).sendToFx(token, destination, targetIBC, unit);
        }
    }
}
