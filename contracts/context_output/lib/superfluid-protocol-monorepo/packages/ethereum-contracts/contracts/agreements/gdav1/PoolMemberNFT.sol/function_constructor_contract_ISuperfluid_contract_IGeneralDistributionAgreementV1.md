# Function: constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]

## Metadata

- **Contract**: PoolMemberNFT
- **Signature**: `constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: public
- **Source Range**: 1222:97:125

## Implementation

```solidity
constructor(ISuperfluid host, IGeneralDistributionAgreementV1 gdaV1) PoolNFTBase(host,gdaV1) {}
```

## Related Implementations

### (contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Kind**: internal
- **Source**: 3017:148:126
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolNFTBase.sol:PoolNFTBase:constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`

```solidity
constructor(ISuperfluid host, IGeneralDistributionAgreementV1 gdaV1) {
    HOST = host;
    GENERAL_DISTRIBUTION_AGREEMENT_V1 = gdaV1;
}
```

## State Variable Writes

- **HOST** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **GENERAL_DISTRIBUTION_AGREEMENT_V1** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: PoolMemberNFT.constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: PoolMemberNFT
  └─ [1] 🏗️ CONSTRUCTOR: PoolNFTBase.constructor(contract ISuperfluid,contract IGeneralDistributionAgreementV1) (NodeID: 1)
      💬 Args: [host, gdaV1]
      🏗️  Contract: PoolNFTBase
```
