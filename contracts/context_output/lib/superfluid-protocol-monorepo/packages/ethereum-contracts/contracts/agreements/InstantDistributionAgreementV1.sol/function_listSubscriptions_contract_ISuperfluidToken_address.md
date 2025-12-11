# Function: listSubscriptions(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `listSubscriptions(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 26372:1018:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.listSubscriptions implementation
function listSubscriptions(ISuperfluidToken token, address subscriber) override external view returns (address[] memory publishers, uint32[] memory indexIds, uint128[] memory unitsList) {
    uint32[] memory slotIds;
    bytes32[] memory sidList;
    (slotIds, sidList) = _listSubscriptionIds(token, subscriber);
    bool exist;
    SubscriptionData memory sdata;
    publishers = new address[](sidList.length);
    indexIds = new uint32[](sidList.length);
    unitsList = new uint128[](sidList.length);
    for (uint32 i = 0; i < sidList.length; ++i) {
        uint32 subId = slotIds[i];
        bytes32 sId = sidList[i];
        (exist, sdata) = _getSubscriptionData(token, sId);
        assert(exist);
        assert(sdata.subId == subId);
        publishers[i] = sdata.publisher;
        indexIds[i] = sdata.indexId;
        unitsList[i] = sdata.units;
    }
}
```

## Related Implementations

### _listSubscriptionIds(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 40398:586:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_listSubscriptionIds(contract ISuperfluidToken,address)`

```solidity
function _listSubscriptionIds(ISuperfluidToken token, address subscriber) private view returns (uint32[] memory slotIds, bytes32[] memory sidList) {
    (slotIds, sidList) = SlotsBitmapLibrary.listData(token, subscriber, _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID, _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START);
    for (uint i = 0; i < sidList.length; ++i) {
        sidList[i] = _getSubscriptionId(subscriber, sidList[i]);
    }
}
```

### listData(contract ISuperfluidToken,address,uint256,uint256)

- **Kind**: internal
- **Source**: 2747:1085:158
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol:SlotsBitmapLibrary:listData(contract ISuperfluidToken,address,uint256,uint256)`

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

### _getSubscriptionId(address,bytes32)

- **Kind**: internal
- **Source**: 34517:222:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getSubscriptionId(address,bytes32)`

```solidity
function _getSubscriptionId(address subscriber, bytes32 iId) private pure returns (bytes32 sId) {
    return keccak256(abi.encodePacked("subscription", subscriber, iId));
}
```

### _getSubscriptionData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 38257:865:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getSubscriptionData(contract ISuperfluidToken,bytes32)`

```solidity
function _getSubscriptionData(ISuperfluidToken token, bytes32 sId) private view returns (bool exist, SubscriptionData memory sdata) {
    bytes32[] memory adata = token.getAgreementData(address(this), sId, 2);
    uint256 a = uint256(adata[0]);
    uint256 b = uint256(adata[1]);
    exist = a > 0;
    if (exist) {
        sdata.publisher = address(uint160(a >> (12 * 8)));
        sdata.indexId = uint32((a >> 32) & type(uint32).max);
        sdata.subId = uint32(a & type(uint32).max);
        sdata.indexValue = uint128(b);
        sdata.units = uint128(b >> 128);
    }
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## State Variable Reads

- **_SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)
- **_SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START** (`uint256`)
- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.listSubscriptions(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._listSubscriptionIds(contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [token, subscriber]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.listData(contract ISuperfluidToken,address,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [token, subscriber, _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID, _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionId(address,bytes32) (NodeID: 3)
  │     💬 Args: [subscriber, sidList[i]]
  │     👁️  Def: private
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionData(contract ISuperfluidToken,bytes32) (NodeID: 4)
      💬 Args: [token, sId]
      👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.listSubscriptions implementation
