# Function: getCurrentPIC(contract ISuperToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `getCurrentPIC(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 7257:134:183

## Implementation

```solidity
function getCurrentPIC(ISuperToken token) override external view returns (address pic) {
    return _currentPICs[token].addr;
}
```

## State Variable Reads

- **_currentPICs** (`mapping(contract ISuperToken => struct TOGA.LockablePIC)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TOGA.getCurrentPIC(contract ISuperToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Interface Documentation

 @dev get the address of the current PIC for the given token.
 @param token The token for which to get the PIC
