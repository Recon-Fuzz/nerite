# Function: getCollateral(address)

**Contract**: [src/CollSurplusPool.sol/contract_CollSurplusPool.md]

## Metadata

- **Contract**: CollSurplusPool
- **Signature**: `getCollateral(address)`
- **Visibility**: external
- **Source Range**: 1662:124:206

## Implementation

```solidity
function getCollateral(address _account) override external view returns (uint256) {
    return balances[_account];
}
```

## State Variable Reads

- **balances** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollSurplusPool.getCollateral(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
