# Function: getEntireSystemColl()

**Contract**: [src/TroveManager.sol/contract_TroveManager.md]

## Metadata

- **Contract**: TroveManager
- **Signature**: `getEntireSystemColl()`
- **Visibility**: public
- **Source Range**: 1265:251:63
- **Inherited From**: LiquityBase

## Implementation

```solidity
function getEntireSystemColl() public view returns (uint256 entireSystemColl) {
    uint256 activeColl = activePool.getCollBalance();
    uint256 liquidatedColl = defaultPool.getCollBalance();
    return activeColl + liquidatedColl;
}
```

## External Calls

- **IActivePool::getCollBalance()**
- **IDefaultPool::getCollBalance()**

## State Variable Reads

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquityBase.getEntireSystemColl() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
