# Function: registerAgreementClass(contract ISuperAgreement)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `registerAgreementClass(contract ISuperAgreement)`
- **Visibility**: external
- **Source Range**: 6325:1039:163

## Implementation

```solidity
function registerAgreementClass(ISuperAgreement agreementClassLogic) override external onlyGovernance() {
    bytes32 agreementType = agreementClassLogic.agreementType();
    if (_agreementClassIndices[agreementType] != 0) {
        revert HOST_AGREEMENT_ALREADY_REGISTERED();
    }
    if (_agreementClasses.length >= MAX_NUM_AGREEMENTS) revert HOST_MAX_256_AGREEMENTS();
    ISuperAgreement agreementClass;
    if (!NON_UPGRADABLE_DEPLOYMENT) {
        UUPSProxy proxy = new UUPSProxy();
        proxy.initializeProxy(address(agreementClassLogic));
        agreementClass = ISuperAgreement(address(proxy));
    } else {
        agreementClass = ISuperAgreement(address(agreementClassLogic));
    }
    _agreementClasses.push((agreementClass));
    _agreementClassIndices[agreementType] = _agreementClasses.length;
    emit AgreementClassRegistered(agreementType, address(agreementClassLogic));
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
- **UUPSProxy::initializeProxy(address)**
- **ISuperAgreement::push(contract ISuperAgreement)**

## State Variable Reads

- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)
- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]
- **MAX_NUM_AGREEMENTS** (`uint32`)
- **NON_UPGRADABLE_DEPLOYMENT** (`bool`)
- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## State Variable Writes

- **_agreementClasses** (`contract ISuperAgreement[]`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]
- **_agreementClassIndices** (`mapping(bytes32 => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.registerAgreementClass(contract ISuperAgreement) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: Superfluid.onlyGovernance() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Register a new agreement class to the system
 @param agreementClassLogic Initial agreement class code
 @custom:modifiers
 - onlyGovernance
