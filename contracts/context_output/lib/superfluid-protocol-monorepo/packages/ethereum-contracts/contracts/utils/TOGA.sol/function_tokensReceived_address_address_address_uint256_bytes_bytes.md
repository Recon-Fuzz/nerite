# Function: tokensReceived(address,address,address,uint256,bytes,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `tokensReceived(address,address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 13305:732:183

## Implementation

```solidity
function tokensReceived(address, address from, address, uint256 amount, bytes calldata userData, bytes calldata) override external {
    ISuperToken token = ISuperToken(msg.sender);
    if (from != _currentPICs[token].addr) {
        int96 exitRate = (userData.length == 0) ? getDefaultExitRateFor(token, amount) : abi.decode(userData, (int96));
        _becomePIC(token, from, amount, exitRate);
    } else {
        emit BondIncreased(token, amount);
    }
}
```

## Related Implementations

### getDefaultExitRateFor(contract ISuperToken,uint256)

- **Kind**: internal
- **Source**: 7912:222:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:getDefaultExitRateFor(contract ISuperToken,uint256)`

```solidity
function getDefaultExitRateFor(ISuperToken, uint256 bondAmount) override public view returns (int96 exitRate) {
    return capToInt96((bondAmount / (minBondDuration * 4)).toInt256());
}
```

### capToInt96(int256)

- **Kind**: internal
- **Source**: 7763:143:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:capToInt96(int256)`

```solidity
function capToInt96(int256 value) internal pure returns (int96) {
    return (value < type(int96).max) ? int96(value) : type(int96).max;
}
```

### toInt256(uint256)

- **Kind**: internal
- **Source**: 34781:297:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt256(uint256)`

```solidity
///  @dev Converts an unsigned uint256 into a signed int256.
///  Requirements:
///  - input must be less than or equal to maxInt256.
///  _Available since v3.0._
function toInt256(uint256 value) internal pure returns (int256) {
    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
    return int256(value);
}
```

### _becomePIC(contract ISuperToken,address,uint256,int96)

- **Kind**: internal
- **Source**: 10999:2249:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:_becomePIC(contract ISuperToken,address,uint256,int96)`

```solidity
function _becomePIC(ISuperToken token, address newPIC, uint256 amount, int96 exitRate) internal {
    require(!_currentPICs[token].lock, "TOGA: reentrancy not allowed");
    require(exitRate >= 0, "TOGA: negative exitRate not allowed");
    require((uint256(int256(exitRate)) * minBondDuration) <= amount, "TOGA: exitRate too high");
    uint256 currentPICBond = _getCurrentPICBond(token) - amount;
    require(amount > currentPICBond, "TOGA: bid too low");
    address currentPICAddr = _currentPICs[token].addr;
    _currentPICs[token].lock = true;
    (, int96 curFlowRate, , ) = _cfa.getFlow(token, address(this), currentPICAddr);
    if (curFlowRate > 0) {
        _host.callAgreement(_cfa, abi.encodeCall(_cfa.deleteFlow, (token, address(this), currentPICAddr, new bytes(0))), "0x");
    }
    if (currentPICAddr != address(0)) {
        token.transfer(currentPICAddr, currentPICBond);
    }
    _currentPICs[token].addr = newPIC;
    if (exitRate > 0) {
        _host.callAgreement(_cfa, abi.encodeCall(_cfa.createFlow, (token, newPIC, exitRate, new bytes(0))), "0x");
    }
    _currentPICs[token].lock = false;
    emit NewPIC(token, newPIC, amount, exitRate);
}
```

### _getCurrentPICBond(contract ISuperToken)

- **Kind**: internal
- **Source**: 10438:356:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:_getCurrentPICBond(contract ISuperToken)`

```solidity
function _getCurrentPICBond(ISuperToken token) internal view returns (uint256 bond) {
    (int256 availBal, uint256 deposit, , ) = token.realtimeBalanceOfNow(address(this));
    return ((availBal + int256(deposit)) > 0) ? uint256(availBal + int256(deposit)) : 0;
}
```

## External Calls

- **IConstantFlowAgreementV1::getFlow(contract ISuperfluidToken,address,address)**
- **ISuperfluid::callAgreement(contract ISuperAgreement,bytes,bytes)**
- **ISuperToken::transfer(address,uint256)**
- **ISuperToken::realtimeBalanceOfNow(address)**

## State Variable Reads

- **_currentPICs** (`mapping(contract ISuperToken => struct TOGA.LockablePIC)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **minBondDuration** (`uint256`)
- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## State Variable Writes

- **_currentPICs** (`mapping(contract ISuperToken => struct TOGA.LockablePIC)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TOGA.tokensReceived(address,address,address,uint256,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: TOGA.getDefaultExitRateFor(contract ISuperToken,uint256) (NodeID: 1)
  │   💬 Args: [token, amount]
  │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: TOGA.capToInt96(int256) (NodeID: 2)
  │     💬 Args: [(bondAmount / (minBondDuration * 4)).toInt256()]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 3)
  │       💬 Args: [(bondAmount / (minBondDuration * 4))]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TOGA._becomePIC(contract ISuperToken,address,uint256,int96) (NodeID: 4)
      💬 Args: [token, from, amount, exitRate]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TOGA._getCurrentPICBond(contract ISuperToken) (NodeID: 5)
        💬 Args: [token]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Called by an {IERC777} token contract whenever tokens are being
 moved or created into a registered account (`to`). The type of operation
 is conveyed by `from` being the zero address or not.
 This call occurs _after_ the token contract's state is updated, so
 {IERC777-balanceOf}, etc., can be used to query the post-operation state.
 This function may revert to prevent the operation from being executed.
