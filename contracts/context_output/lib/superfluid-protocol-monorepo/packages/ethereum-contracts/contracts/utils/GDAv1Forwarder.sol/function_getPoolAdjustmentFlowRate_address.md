# Function: getPoolAdjustmentFlowRate(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `getPoolAdjustmentFlowRate(address)`
- **Visibility**: external
- **Source Range**: 7238:147:176

## Implementation

```solidity
///  @dev Gets the pool adjustment flow rate for the specified pool.
///  @param pool The pool address.
///  @return The pool adjustment flow rate.
function getPoolAdjustmentFlowRate(address pool) virtual external view returns (int96) {
    return _gda.getPoolAdjustmentFlowRate(pool);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::getPoolAdjustmentFlowRate(address)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.getPoolAdjustmentFlowRate(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Gets the pool adjustment flow rate for the specified pool.
 @param pool The pool address.
 @return The pool adjustment flow rate.
