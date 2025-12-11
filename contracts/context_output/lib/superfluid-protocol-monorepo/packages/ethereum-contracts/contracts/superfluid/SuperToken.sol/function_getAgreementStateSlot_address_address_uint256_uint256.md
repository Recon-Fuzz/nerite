# Function: getAgreementStateSlot(address,address,uint256,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getAgreementStateSlot(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9717:391:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.getAgreementState implementation
function getAgreementStateSlot(address agreementClass, address account, uint256 slotId, uint dataLength) virtual override external view returns (bytes32[] memory slotData) {
    bytes32 slot = keccak256(abi.encode("AgreementState", agreementClass, account, slotId));
    slotData = FixedSizeData.loadData(slot, dataLength);
}
```

## Related Implementations

### loadData(bytes32,uint256)

- **Kind**: internal
- **Source**: 1292:300:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:loadData(bytes32,uint256)`

```solidity
///  @dev Load data of size `dataLength` from the slot at `slot`
function loadData(bytes32 slot, uint dataLength) internal view returns (bytes32[] memory data) {
    data = new bytes32[](dataLength);
    for (uint j = 0; j < dataLength; ++j) {
        bytes32 d;
        assembly {
            d := sload(add(slot, j))
        }
        data[j] = d;
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.getAgreementStateSlot(address,address,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: FixedSizeData.loadData(bytes32,uint256) (NodeID: 1)
      💬 Args: [slot, dataLength]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.getAgreementState implementation

### Interface Documentation

 @dev Get data of the slot of the state of an agreement
 @param agreementClass Contract address of the agreement
 @param account Account to query
 @param slotId slot id of the state
 @param dataLength length of the state data
