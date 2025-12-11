# Function: receive()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol/contract_SETHProxy.md]

## Metadata

- **Contract**: SETHProxy
- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 765:176:166

## Implementation

```solidity
/// fallback function which mints Super Tokens for received ETH
receive() override external payable {
    ISuperToken(address(this)).selfMint(msg.sender, msg.value, new bytes(0));
    emit TokenUpgraded(msg.sender, msg.value);
}
```

## External Calls

- **ISuperToken::selfMint(address,uint256,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SETHProxy.receive() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

fallback function which mints Super Tokens for received ETH
