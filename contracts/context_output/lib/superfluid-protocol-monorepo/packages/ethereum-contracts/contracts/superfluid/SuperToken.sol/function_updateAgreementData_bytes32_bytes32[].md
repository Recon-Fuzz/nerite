# Function: updateAgreementData(bytes32,bytes32[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `updateAgreementData(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 8295:359:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.updateAgreementData implementation
function updateAgreementData(bytes32 id, bytes32[] calldata data) virtual override external {
    address agreementClass = msg.sender;
    bytes32 slot = keccak256(abi.encode("AgreementData", agreementClass, id));
    FixedSizeData.storeData(slot, data);
    emit AgreementUpdated(msg.sender, id, data);
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
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.updateAgreementData(bytes32,bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: FixedSizeData.storeData(bytes32,bytes32[]) (NodeID: 1)
      💬 Args: [slot, data]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.updateAgreementData implementation

### Interface Documentation

 @dev Create a new agreement
 @param id Agreement ID
 @param data Agreement data
