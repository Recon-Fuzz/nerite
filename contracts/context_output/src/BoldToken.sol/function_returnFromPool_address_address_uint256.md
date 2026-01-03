# Function: returnFromPool(address,address,uint256)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `returnFromPool(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 5367:249:53

## Implementation

```solidity
function returnFromPool(address _poolAddress, address _receiver, uint256 _amount) override external {
    _requireCallerIsStabilityPool();
    ISuperToken(address(this)).selfTransferFrom(_poolAddress, _poolAddress, _receiver, _amount);
}
```

## Related Implementations

### _requireCallerIsStabilityPool()

- **Kind**: internal
- **Source**: 6622:156:53
- **Link**: `src/BoldToken.sol:BoldToken:_requireCallerIsStabilityPool()`

```solidity
function _requireCallerIsStabilityPool() internal view {
    require(stabilityPoolAddresses[msg.sender], "Bold: Caller is not the StabilityPool");
}
```

## External Calls

- **ISuperToken::selfTransferFrom(address,address,address,uint256)**

## State Variable Reads

- **stabilityPoolAddresses** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.returnFromPool(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BoldToken._requireCallerIsStabilityPool() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
