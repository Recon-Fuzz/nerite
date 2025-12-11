# Function: constructor(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]

## Metadata

- **Contract**: CFAv1Forwarder
- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 812:227:173

## Implementation

```solidity
constructor(ISuperfluid host) ForwarderBase(host) {
    _cfa = IConstantFlowAgreementV1(address(_host.getAgreementClass(keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1"))));
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

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CFAv1Forwarder.constructor(contract ISuperfluid) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CFAv1Forwarder
  └─ [1] 🏗️ CONSTRUCTOR: ForwarderBase.constructor(contract ISuperfluid) (NodeID: 1)
      💬 Args: [host]
      🏗️  Contract: ForwarderBase
```
