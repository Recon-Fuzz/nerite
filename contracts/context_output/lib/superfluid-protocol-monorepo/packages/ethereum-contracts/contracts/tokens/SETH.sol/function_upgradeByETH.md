# Function: upgradeByETH()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol/contract_SETHProxy.md]

## Metadata

- **Contract**: SETHProxy
- **Signature**: `upgradeByETH()`
- **Visibility**: external
- **Source Range**: 947:190:166

## Implementation

```solidity
function upgradeByETH() override external payable {
    ISuperToken(address(this)).selfMint(msg.sender, msg.value, new bytes(0));
    emit TokenUpgraded(msg.sender, msg.value);
}
```

## External Calls

- **ISuperToken::selfMint(address,uint256,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SETHProxy.upgradeByETH() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
