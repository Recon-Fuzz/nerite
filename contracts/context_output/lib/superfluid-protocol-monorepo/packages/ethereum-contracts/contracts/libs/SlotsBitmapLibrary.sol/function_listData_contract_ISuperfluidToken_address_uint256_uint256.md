# Function: listData(contract ISuperfluidToken,address,uint256,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol/contract_SlotsBitmapLibrary.md]

## Metadata

- **Contract**: SlotsBitmapLibrary
- **Signature**: `listData(contract ISuperfluidToken,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2747:1085:158

## Implementation

```solidity
function listData(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint256 dataStateSlotIDStart) public view returns (uint32[] memory slotIds, bytes32[] memory dataList) {
    uint256 subsBitmap = uint256(token.getAgreementStateSlot(address(this), account, bitmapStateSlotId, 1)[0]);
    slotIds = new uint32[](_MAX_NUM_SLOTS);
    dataList = new bytes32[](_MAX_NUM_SLOTS);
    uint nSlots;
    for (uint32 slotId = 0; slotId < _MAX_NUM_SLOTS; ++slotId) {
        if ((uint256(subsBitmap >> slotId) & 1) == 0) continue;
        slotIds[nSlots] = slotId;
        dataList[nSlots] = token.getAgreementStateSlot(address(this), account, dataStateSlotIDStart + slotId, 1)[0];
        ++nSlots;
    }
    assembly {
        mstore(slotIds, nSlots)
        mstore(dataList, nSlots)
    }
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## State Variable Reads

- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
No call tree available
```
