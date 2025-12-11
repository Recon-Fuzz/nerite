# Function: terminateAgreement(bytes32,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `terminateAgreement(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 8724:474:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.terminateAgreement implementation
function terminateAgreement(bytes32 id, uint dataLength) virtual override external {
    address agreementClass = msg.sender;
    bytes32 slot = keccak256(abi.encode("AgreementData", agreementClass, id));
    if (!FixedSizeData.hasData(slot, dataLength)) {
        revert SF_TOKEN_AGREEMENT_DOES_NOT_EXIST();
    }
    FixedSizeData.eraseData(slot, dataLength);
    emit AgreementTerminated(msg.sender, id);
}
```

## Related Implementations

### hasData(bytes32,uint256)

- **Kind**: internal
- **Source**: 921:282:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:hasData(bytes32,uint256)`

```solidity
function hasData(bytes32 slot, uint dataLength) internal view returns (bool) {
    for (uint j = 0; j < dataLength; ++j) {
        bytes32 d;
        assembly {
            d := sload(add(slot, j))
        }
        if (uint256(d) > 0) return true;
    }
    return false;
}
```

### eraseData(bytes32,uint256)

- **Kind**: internal
- **Source**: 1682:173:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:eraseData(bytes32,uint256)`

```solidity
///  @dev Erase data of size `dataLength` from the slot at `slot`
function eraseData(bytes32 slot, uint dataLength) internal {
    for (uint j = 0; j < dataLength; ++j) {
        assembly {
            sstore(add(slot, j), 0)
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.terminateAgreement(bytes32,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: FixedSizeData.hasData(bytes32,uint256) (NodeID: 1)
  │   💬 Args: [slot, dataLength]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FixedSizeData.eraseData(bytes32,uint256) (NodeID: 2)
      💬 Args: [slot, dataLength]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.terminateAgreement implementation

### Interface Documentation

 @dev Close the agreement
 @param id Agreement ID
