# Function: getPoolAdjustmentFlowInfo(contract ISuperfluidPool)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `getPoolAdjustmentFlowInfo(contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 9361:173:176

## Implementation

```solidity
///  @dev Gets the pool adjustment flow information for the specified pool.
///  @param pool The pool address.
///  @return The pool admin, pool ID, and pool adjustment flow rate.
function getPoolAdjustmentFlowInfo(ISuperfluidPool pool) virtual external view returns (address, bytes32, int96) {
    return _gda.getPoolAdjustmentFlowInfo(pool);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::getPoolAdjustmentFlowInfo(contract ISuperfluidPool)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.getPoolAdjustmentFlowInfo(contract ISuperfluidPool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Gets the pool adjustment flow information for the specified pool.
 @param pool The pool address.
 @return The pool admin, pool ID, and pool adjustment flow rate.
