# Function: getNetFlow(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `getNetFlow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6422:146:176

## Implementation

```solidity
///  @dev Gets the GDA net flow rate for the specified account.
///  @param token The Super Token address.
///  @param account The account address.
///  @return The gda net flow rate for the account.
function getNetFlow(ISuperfluidToken token, address account) external view returns (int96) {
    return _gda.getNetFlow(token, account);
}
```

## External Calls

- **IGeneralDistributionAgreementV1::getNetFlow(contract ISuperfluidToken,address)**

## State Variable Reads

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GDAv1Forwarder.getNetFlow(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

 @dev Gets the GDA net flow rate for the specified account.
 @param token The Super Token address.
 @param account The account address.
 @return The gda net flow rate for the account.
