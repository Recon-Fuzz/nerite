# Function: downgradeToETH(uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol/contract_SETHProxy.md]

## Metadata

- **Contract**: SETHProxy
- **Signature**: `downgradeToETH(uint256)`
- **Visibility**: external
- **Source Range**: 1335:225:166

## Implementation

```solidity
function downgradeToETH(uint wad) override external {
    ISuperToken(address(this)).selfBurn(msg.sender, wad, new bytes(0));
    payable(msg.sender).transfer(wad);
    emit TokenDowngraded(msg.sender, wad);
}
```

## External Calls

- **ISuperToken::selfBurn(address,uint256,bytes)**

## Native Transfers

- **unknown** (computed)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SETHProxy.downgradeToETH(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
