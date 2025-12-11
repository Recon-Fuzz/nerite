# Function: createPool(contract ISuperfluidToken,address,struct PoolConfig)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `createPool(contract ISuperfluidToken,address,struct PoolConfig)`
- **Visibility**: external
- **Source Range**: 1617:244:176

## Implementation

```solidity
///  @dev Creates a new Superfluid Pool.
///  @param token The Super Token address.
///  @param admin The pool admin address.
///  @param config The pool configuration (see PoolConfig in IGeneralDistributionAgreementV1.sol)
///  @return success A boolean value indicating whether the pool was created successfully.
///  @return pool The address of the deployed Superfluid Pool
function createPool(ISuperfluidToken token, address admin, PoolConfig memory config) external returns (bool success, ISuperfluidPool pool) {
    pool = _gda.createPool(token, admin, config);
    success = true;
}
```

## External Calls

- **IGeneralDistributionAgreementV1::createPool(contract ISuperfluidToken,address,struct PoolConfig)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.createPool(contract ISuperfluidToken,address,struct PoolConfig) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Creates a new Superfluid Pool.
 @param token The Super Token address.
 @param admin The pool admin address.
 @param config The pool configuration (see PoolConfig in IGeneralDistributionAgreementV1.sol)
 @return success A boolean value indicating whether the pool was created successfully.
 @return pool The address of the deployed Superfluid Pool
