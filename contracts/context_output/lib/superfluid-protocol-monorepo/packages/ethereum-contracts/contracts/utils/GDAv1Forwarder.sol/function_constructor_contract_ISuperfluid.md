# Function: constructor(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]

## Metadata

- **Contract**: GDAv1Forwarder
- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 935:271:176

## Implementation

```solidity
constructor(ISuperfluid host) ForwarderBase(host) {
    _gda = IGeneralDistributionAgreementV1(address(_host.getAgreementClass(keccak256("org.superfluid-finance.agreements.GeneralDistributionAgreement.v1"))));
}
```

## Related Implementations

### (contract ISuperfluid)

- **Kind**: internal
- **Source**: 282:59:175
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/ForwarderBase.sol:ForwarderBase:constructor(contract ISuperfluid)`

```solidity
constructor(ISuperfluid host) {
    _host = host;
}
```

## External Calls

- **ISuperfluid::getAgreementClass(bytes32)**

## State Variable Writes

- **_gda** (`contract IGeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: GDAv1Forwarder.constructor(contract ISuperfluid) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: GDAv1Forwarder
  └─ [1] 🏗️ CONSTRUCTOR: ForwarderBase.constructor(contract ISuperfluid) (NodeID: 1)
      💬 Args: [host]
      🏗️  Contract: ForwarderBase
```
