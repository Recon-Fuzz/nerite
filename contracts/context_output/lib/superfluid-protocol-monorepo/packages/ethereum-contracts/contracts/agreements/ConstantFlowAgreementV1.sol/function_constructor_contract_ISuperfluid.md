# Function: constructor(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 3376:75:121

## Implementation

```solidity
constructor(ISuperfluid host) AgreementBase(address(host)) {}
```

## Related Implementations

### (address)

- **Kind**: internal
- **Source**: 490:59:119
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementBase.sol:AgreementBase:constructor(address)`

```solidity
constructor(address host) {
    _host = host;
}
```

## State Variable Writes

- **_host** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: ConstantFlowAgreementV1.constructor(contract ISuperfluid) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: ConstantFlowAgreementV1
  └─ [1] 🏗️ CONSTRUCTOR: AgreementBase.constructor(address) (NodeID: 1)
      💬 Args: [address(host)]
      🏗️  Contract: AgreementBase
```
