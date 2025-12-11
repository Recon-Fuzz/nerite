# Function: delegateTokens()

**Contract**: [src/ActivePool.sol/contract_ActivePool.md]

## Metadata

- **Contract**: ActivePool
- **Signature**: `delegateTokens()`
- **Visibility**: external
- **Source Range**: 15757:115:202

## Implementation

```solidity
function delegateTokens() external {
    ERC20Votes(address(collToken)).delegate(delegateRepresentative);
}
```

## External Calls

- **ERC20Votes::delegate(address)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **delegateRepresentative** (`address`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ActivePool.delegateTokens() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
