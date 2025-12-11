# Function: upgradeByETHTo(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol/contract_SETHProxy.md]

## Metadata

- **Contract**: SETHProxy
- **Signature**: `upgradeByETHTo(address)`
- **Visibility**: external
- **Source Range**: 1143:186:166

## Implementation

```solidity
function upgradeByETHTo(address to) override external payable {
    ISuperToken(address(this)).selfMint(to, msg.value, new bytes(0));
    emit TokenUpgraded(to, msg.value);
}
```

## External Calls

- **ISuperToken::selfMint(address,uint256,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SETHProxy.upgradeByETHTo(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
