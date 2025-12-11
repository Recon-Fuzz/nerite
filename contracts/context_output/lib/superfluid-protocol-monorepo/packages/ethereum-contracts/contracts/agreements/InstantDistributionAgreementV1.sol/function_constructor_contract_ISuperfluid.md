# Function: constructor(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 3876:61:122

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
┌─ [0] 🏗️ CONSTRUCTOR: InstantDistributionAgreementV1.constructor(contract ISuperfluid) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: InstantDistributionAgreementV1
  └─ [1] 🏗️ CONSTRUCTOR: AgreementBase.constructor(address) (NodeID: 1)
      💬 Args: [address(host)]
      🏗️  Contract: AgreementBase
```
