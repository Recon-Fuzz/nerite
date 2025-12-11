# Function: updateAgreementClass(contract ISuperAgreement)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `updateAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 7370:620:163

## Implementation

```solidity
function updateAgreementClass(ISuperAgreement agreementClassLogic) override external onlyGovernance() {
    if (NON_UPGRADABLE_DEPLOYMENT) revert HOST_NON_UPGRADEABLE();
    bytes32 agreementType = agreementClassLogic.agreementType();
    uint idx = _agreementClassIndices[agreementType];
    if (idx == 0) {
        revert HOST_AGREEMENT_IS_NOT_REGISTERED();
    }
    UUPSProxiable proxiable = UUPSProxiable(address(_agreementClasses[idx - 1]));
    proxiable.updateCode(address(agreementClassLogic));
    emit AgreementClassUpdated(agreementType, address(agreementClassLogic));
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

- **ISuperAgreement::agreementType()**
- **UUPSProxiable::updateCode(address)**

## State Variable Reads

- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.updateAgreementClass(contract ISuperAgreement) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Update code of an agreement class
 @param agreementClassLogic New code for the agreement class
 @custom:modifiers
  - onlyGovernance
