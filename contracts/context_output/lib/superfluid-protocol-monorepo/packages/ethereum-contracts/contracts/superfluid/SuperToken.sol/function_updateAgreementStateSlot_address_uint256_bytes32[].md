# Function: updateAgreementStateSlot(address,uint256,bytes32[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `updateAgreementStateSlot(address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 9270:378:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.updateAgreementState implementation
function updateAgreementStateSlot(address account, uint256 slotId, bytes32[] calldata slotData) virtual override external {
    bytes32 slot = keccak256(abi.encode("AgreementState", msg.sender, account, slotId));
    FixedSizeData.storeData(slot, slotData);
    emit AgreementStateUpdated(msg.sender, account, slotId);
}
```

## Related Implementations

### storeData(bytes32,bytes32[])

- **Kind**: internal
- **Source**: 702:213:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:storeData(bytes32,bytes32[])`

```solidity
///  @dev Store data to the slot at `slot`
function storeData(bytes32 slot, bytes32[] memory data) internal {
    for (uint j = 0; j < data.length; ++j) {
        bytes32 d = data[j];
        assembly {
            sstore(add(slot, j), d)
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.updateAgreementStateSlot(address,uint256,bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: FixedSizeData.storeData(bytes32,bytes32[]) (NodeID: 1)
      💬 Args: [slot, slotData]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.updateAgreementState implementation

### Interface Documentation

 @dev Update agreement state slot
 @param account Account to be updated
 @custom:note 
 - To clear the storage out, provide zero-ed array of intended length
