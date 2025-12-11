# Function: findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol/contract_SlotsBitmapLibrary.md]

## Metadata

- **Contract**: SlotsBitmapLibrary
- **Signature**: `findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)`
- **Visibility**: public
- **Source Range**: 797:1224:158

## Implementation

```solidity
function findEmptySlotAndFill(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint256 dataStateSlotIDStart, bytes32 data) public returns (uint32 slotId) {
    uint256 subsBitmap = uint256(token.getAgreementStateSlot(address(this), account, bitmapStateSlotId, 1)[0]);
    for (slotId = 0; slotId < _MAX_NUM_SLOTS; ++slotId) {
        if ((uint256(subsBitmap >> slotId) & 1) == 0) {
            bytes32[] memory slotData = new bytes32[](1);
            slotData[0] = data;
            token.updateAgreementStateSlot(account, dataStateSlotIDStart + slotId, slotData);
            slotData[0] = bytes32(subsBitmap | (1 << uint256(slotId)));
            token.updateAgreementStateSlot(account, bitmapStateSlotId, slotData);
            break;
        }
    }
    require(slotId < _MAX_NUM_SLOTS, "SlotBitmap out of bound");
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**

## State Variable Reads

- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
No call tree available
```
