# Function: getEntireSystemDebt()

**Contract**: [src/Dependencies/LiquityBase.sol/contract_LiquityBase.md]

## Metadata

- **Contract**: LiquityBase
- **Signature**: `getEntireSystemDebt()`
- **Visibility**: public
- **Source Range**: 1522:237:63

## Implementation

```solidity
function getEntireSystemDebt() public view returns (uint256 entireSystemDebt) {
    uint256 activeDebt = activePool.getBoldDebt();
    uint256 closedDebt = defaultPool.getBoldDebt();
    return activeDebt + closedDebt;
}
```

## External Calls

- **IActivePool::getBoldDebt()**
- **IDefaultPool::getBoldDebt()**

## State Variable Reads

- **activePool** (`contract IActivePool`) [src/Interfaces/IActivePool.sol/interface_IActivePool.md]
- **defaultPool** (`contract IDefaultPool`) [src/Interfaces/IDefaultPool.sol/interface_IDefaultPool.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: LiquityBase.getEntireSystemDebt() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
