# Function: isCtxValid(bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isCtxValid(bytes)`
- **Visibility**: external
- **Source Range**: 29219:138:163

## Implementation

```solidity
function isCtxValid(bytes calldata ctx) override external view returns (bool) {
    return _isCtxValid(ctx);
}
```

## Related Implementations

### _isCtxValid(bytes)

- **Kind**: internal
- **Source**: 39285:137:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_isCtxValid(bytes)`

```solidity
function _isCtxValid(bytes memory ctx) private view returns (bool) {
    return (ctx.length != 0) && (keccak256(ctx) == _ctxStamp);
}
```

## State Variable Reads

- **_ctxStamp** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isCtxValid(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: Superfluid._isCtxValid(bytes) (NodeID: 1)
      💬 Args: [ctx]
      👁️  Def: private
```
