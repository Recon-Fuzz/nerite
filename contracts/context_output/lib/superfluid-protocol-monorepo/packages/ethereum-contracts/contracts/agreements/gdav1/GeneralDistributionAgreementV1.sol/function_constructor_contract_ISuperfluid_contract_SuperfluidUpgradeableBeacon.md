# Function: constructor(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `constructor(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)`
- **Visibility**: public
- **Source Range**: 4774:171:123

## Implementation

```solidity
constructor(ISuperfluid host, SuperfluidUpgradeableBeacon superfluidPoolBeacon_) AgreementBase(address(host)) {
    superfluidPoolBeacon = superfluidPoolBeacon_;
}
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

- **superfluidPoolBeacon** (`contract SuperfluidUpgradeableBeacon`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol/contract_SuperfluidUpgradeableBeacon.md]
- **_host** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: GeneralDistributionAgreementV1.constructor(contract ISuperfluid,contract SuperfluidUpgradeableBeacon) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: GeneralDistributionAgreementV1
  └─ [1] 🏗️ CONSTRUCTOR: AgreementBase.constructor(address) (NodeID: 1)
      💬 Args: [address(host)]
      🏗️  Contract: AgreementBase
```
