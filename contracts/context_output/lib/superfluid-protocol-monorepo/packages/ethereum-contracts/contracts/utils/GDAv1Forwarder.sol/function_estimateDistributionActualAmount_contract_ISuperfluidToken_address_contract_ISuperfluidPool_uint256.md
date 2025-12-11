# Function: estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)`
- **Visibility**: external
- **Source Range**: 8429:303:176

## Implementation

```solidity
///  @dev Estimates the actual amount for distribution to the specified pool.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The pool address.
///  @param requestedAmount The requested amount.
///  @return actualAmount The actual amount for distribution.
function estimateDistributionActualAmount(ISuperfluidToken token, address from, ISuperfluidPool to, uint256 requestedAmount) external view returns (uint256 actualAmount) {
    return _gda.estimateDistributionActualAmount(token, from, to, requestedAmount);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Estimates the actual amount for distribution to the specified pool.
 @param token The Super Token address.
 @param from The sender address.
 @param to The pool address.
 @param requestedAmount The requested amount.
 @return actualAmount The actual amount for distribution.
