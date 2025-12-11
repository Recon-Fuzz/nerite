# Function: updatePoolBeaconLogic(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `updatePoolBeaconLogic(address)`
- **Visibility**: external
- **Source Range**: 12788:543:163

## Implementation

```solidity
/// @inheritdoc ISuperfluid
function updatePoolBeaconLogic(address newLogic) override external onlyGovernance() {
    GeneralDistributionAgreementV1 gda = GeneralDistributionAgreementV1(address(this.getAgreementClass(keccak256("org.superfluid-finance.agreements.GeneralDistributionAgreement.v1"))));
    SuperfluidUpgradeableBeacon beacon = SuperfluidUpgradeableBeacon(address(gda.superfluidPoolBeacon()));
    beacon.upgradeTo(newLogic);
    emit PoolBeaconLogicUpdated(address(beacon), newLogic);
}
```

## Related Implementations

### onlyGovernance()

- **Kind**: modifier
- **Source**: 44183:116:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:onlyGovernance()`

```solidity
modifier onlyGovernance() {
    if (msg.sender != address(_gov)) revert HOST_ONLY_GOVERNANCE();
    _;
}
```

## External Calls

- **Superfluid::getAgreementClass(bytes32)**
- **GeneralDistributionAgreementV1::superfluidPoolBeacon()**
- **SuperfluidUpgradeableBeacon::upgradeTo(address)**

## State Variable Reads

- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.updatePoolBeaconLogic(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluid

### Interface Documentation

 @notice Change the implementation address the pool beacon points to
 @dev Updating the logic the beacon points to will update the logic of all the Pool BeaconProxy instances
