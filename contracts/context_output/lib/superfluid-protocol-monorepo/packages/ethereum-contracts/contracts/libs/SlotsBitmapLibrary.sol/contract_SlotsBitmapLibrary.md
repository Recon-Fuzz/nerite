# Contract: SlotsBitmapLibrary

## Metadata

- **Name**: SlotsBitmapLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol
- **Documentation**:  @title Slots Bitmap library
   @author Superfluid
   @dev A library implements slots bitmap on Superfluid Token storage
   NOTE:
   - A slots bitmap allows you to iterate through a list of data efficiently.
   - A data slot can be enabled or disabled with the help of bitmap.
   - MAX_NUM_SLOTS is 256 in this implementation (using one uint256)
   - Superfluid token storage usage:
     - getAgreementStateSlot(bitmapStateSlotId) stores the bitmap of enabled data slots
     - getAgreementStateSlot(dataStateSlotIDStart + stotId) stores the data of the slot

## State Variables

### _MAX_NUM_SLOTS

```solidity
uint32 internal constant _MAX_NUM_SLOTS = 256
```

## Public/External Functions

### findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)

- **Signature**: `findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)`
- **Visibility**: public
- **Source Range**: 797:1224:158
- **Details**: [function_findEmptySlotAndFill_contract_ISuperfluidToken_address_uint256_uint256_bytes32.md](./function_findEmptySlotAndFill_contract_ISuperfluidToken_address_uint256_uint256_bytes32.md)

**Signature:**
```solidity
function findEmptySlotAndFill(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint256 dataStateSlotIDStart, bytes32 data) public returns (uint32 slotId);
```

### clearSlot(contract ISuperfluidToken,address,uint256,uint32)

- **Signature**: `clearSlot(contract ISuperfluidToken,address,uint256,uint32)`
- **Visibility**: public
- **Source Range**: 2027:714:158
- **Details**: [function_clearSlot_contract_ISuperfluidToken_address_uint256_uint32.md](./function_clearSlot_contract_ISuperfluidToken_address_uint256_uint32.md)

**Signature:**
```solidity
function clearSlot(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint32 slotId) public;
```

### listData(contract ISuperfluidToken,address,uint256,uint256)

- **Signature**: `listData(contract ISuperfluidToken,address,uint256,uint256)`
- **Visibility**: public
- **Source Range**: 2747:1085:158
- **Details**: [function_listData_contract_ISuperfluidToken_address_uint256_uint256.md](./function_listData_contract_ISuperfluidToken_address_uint256_uint256.md)

**Signature:**
```solidity
function listData(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint256 dataStateSlotIDStart) public view returns (uint32[] memory slotIds, bytes32[] memory dataList);
```
