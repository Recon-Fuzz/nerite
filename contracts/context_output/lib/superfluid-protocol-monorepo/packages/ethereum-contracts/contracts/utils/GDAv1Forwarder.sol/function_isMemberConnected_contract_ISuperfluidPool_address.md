# Function: isMemberConnected(contract ISuperfluidPool,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `isMemberConnected(contract ISuperfluidPool,address)`
- **Visibility**: external
- **Source Range**: 8999:154:176

## Implementation

```solidity
///  @dev Checks if the specified member is connected to the pool.
///  @param pool The Superfluid Pool address.
///  @param member The member address.
///  @return A boolean value indicating whether the member is connected to the pool.
function isMemberConnected(ISuperfluidPool pool, address member) external view returns (bool) {
    return _gda.isMemberConnected(pool, member);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::isMemberConnected(contract ISuperfluidPool,address)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.isMemberConnected(contract ISuperfluidPool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Checks if the specified member is connected to the pool.
 @param pool The Superfluid Pool address.
 @param member The member address.
 @return A boolean value indicating whether the member is connected to the pool.
