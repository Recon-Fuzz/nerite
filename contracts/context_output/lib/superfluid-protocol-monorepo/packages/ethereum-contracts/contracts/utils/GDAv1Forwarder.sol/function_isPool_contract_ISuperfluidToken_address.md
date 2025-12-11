# Function: isPool(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `isPool(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6047:145:176

## Implementation

```solidity
///  @dev Checks if the specified account is a pool.
///  @param token The Super Token address.
///  @param account The account address to check.
///  @return A boolean value indicating whether the account is a pool.
function isPool(ISuperfluidToken token, address account) virtual external view returns (bool) {
    return _gda.isPool(token, account);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::isPool(contract ISuperfluidToken,address)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.isPool(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Checks if the specified account is a pool.
 @param token The Super Token address.
 @param account The account address to check.
 @return A boolean value indicating whether the account is a pool.
