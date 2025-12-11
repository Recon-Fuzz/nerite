# Function: initialize(string,string,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/PureSuperToken.sol/contract_PureSuperToken.md]

## Metadata

- **Contract**: PureSuperToken
- **Signature**: `initialize(string,string,uint256)`
- **Visibility**: external
- **Source Range**: 641:516:165

## Implementation

```solidity
function initialize(string calldata name, string calldata symbol, uint256 initialSupply) override external {
    ISuperToken(address(this)).initialize(IERC20(0x0000000000000000000000000000000000000000), 18, name, symbol);
    ISuperToken(address(this)).selfMint(msg.sender, initialSupply, new bytes(0));
}
```

## External Calls

- **ISuperToken::initialize(contract IERC20,uint8,string,string)**
- **ISuperToken::selfMint(address,uint256,bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: PureSuperToken.initialize(string,string,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
