# Function: clearSlot(contract ISuperfluidToken,address,uint256,uint32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol/contract_SlotsBitmapLibrary.md]

## Metadata

- **Contract**: SlotsBitmapLibrary
- **Signature**: `clearSlot(contract ISuperfluidToken,address,uint256,uint32)`
- **Visibility**: public
- **Source Range**: 2027:714:158

## Implementation

```solidity
function clearSlot(ISuperfluidToken token, address account, uint256 bitmapStateSlotId, uint32 slotId) public {
    uint256 subsBitmap = uint256(token.getAgreementStateSlot(address(this), account, bitmapStateSlotId, 1)[0]);
    bytes32[] memory slotData = new bytes32[](1);
    assert((subsBitmap & (1 << uint256(slotId))) != 0);
    slotData[0] = bytes32(subsBitmap & (~(1 << uint256(slotId))));
    token.updateAgreementStateSlot(account, bitmapStateSlotId, slotData);
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**

## Call Tree

```
No call tree available
```
