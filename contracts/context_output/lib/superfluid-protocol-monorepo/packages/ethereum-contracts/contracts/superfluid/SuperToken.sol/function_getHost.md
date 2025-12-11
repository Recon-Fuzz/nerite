# Function: getHost()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 1711:144:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.getHost implementation
function getHost() override(ISuperfluidToken) external view returns (address host) {
    return address(_host);
}
```

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.getHost() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.getHost implementation

### Interface Documentation

 @dev Get superfluid host contract address
