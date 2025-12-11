# Function: constructor(contract GeneralDistributionAgreementV1)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `constructor(contract GeneralDistributionAgreementV1)`
- **Visibility**: public
- **Source Range**: 3939:74:127

## Implementation

```solidity
constructor(GeneralDistributionAgreementV1 gda) {
    GDA = gda;
}
```

## State Variable Writes

- **GDA** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperfluidPool.constructor(contract GeneralDistributionAgreementV1) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperfluidPool
```
