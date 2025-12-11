# Function: realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: external
- **Source Range**: 4580:1711:122

## Implementation

```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256) override external view returns (int256 dynamicBalance, uint256 deposit, uint256 owedDeposit) {
    uint32[] memory slotIds;
    bytes32[] memory sidList;
    (slotIds, sidList) = _listSubscriptionIds(token, account);
    for (uint32 i = 0; i < sidList.length; ++i) {
        bool exist;
        SubscriptionData memory sdata;
        bytes32 iId;
        {
            uint32 subId = slotIds[i];
            (exist, sdata) = _getSubscriptionData(token, sidList[i]);
            assert(exist);
            assert(sdata.subId == subId);
            iId = token.getAgreementStateSlot(address(this), account, _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START + subId, 1)[0];
        }
        {
            IndexData memory idata;
            (exist, idata) = _getIndexData(token, iId);
            assert(exist);
            dynamicBalance = dynamicBalance + (int256(uint256(idata.indexValue - sdata.indexValue)) * int256(uint256(sdata.units)));
        }
    }
    deposit = _getPublisherDeposit(token, account);
    owedDeposit = 0;
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

### _getIndexData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 35754:731:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getIndexData(contract ISuperfluidToken,bytes32)`

```solidity
function _getIndexData(ISuperfluidToken token, bytes32 iId) private view returns (bool exist, IndexData memory idata) {
    bytes32[] memory adata = token.getAgreementData(address(this), iId, 2);
    uint256 a = uint256(adata[0]);
    uint256 b = uint256(adata[1]);
    exist = a > 0;
    if (exist) {
        idata.indexValue = uint128(a);
        idata.totalUnitsApproved = uint128(b);
        idata.totalUnitsPending = uint128(b >> 128);
    }
}
```

### _getPublisherDeposit(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 36582:359:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getPublisherDeposit(contract ISuperfluidToken,address)`

```solidity
function _getPublisherDeposit(ISuperfluidToken token, address publisher) private view returns (uint256) {
    bytes32[] memory data = token.getAgreementStateSlot(address(this), publisher, _PUBLISHER_DEPOSIT_STATE_SLOT_ID, 1);
    return uint256(data[0]);
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## State Variable Reads

- **_SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START** (`uint256`)
- **_SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)
- **_MAX_NUM_SLOTS** (`uint32`)
- **_PUBLISHER_DEPOSIT_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.realtimeBalanceOf(contract ISuperfluidToken,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._listSubscriptionIds(contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [token, account]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.listData(contract ISuperfluidToken,address,uint256,uint256) (NodeID: 2)
  │ │   💬 Args: [token, subscriber, _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID, _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START]
  │ │   👁️  Def: public
  │ └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionId(address,bytes32) (NodeID: 3)
  │     💬 Args: [subscriber, sidList[i]]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionData(contract ISuperfluidToken,bytes32) (NodeID: 4)
  │   💬 Args: [token, sidList[i]]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 5)
  │   💬 Args: [token, iId]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherDeposit(contract ISuperfluidToken,address) (NodeID: 6)
      💬 Args: [token, account]
      👁️  Def: private
```

## Documentation

### Function Documentation

@dev ISuperAgreement.realtimeBalanceOf implementation

### Interface Documentation

 @dev Calculate the real-time balance for the account of this agreement class
 @param account Account the state belongs to
 @param time Time used for the calculation
 @return dynamicBalance Dynamic balance portion of real-time balance of this agreement
 @return deposit Account deposit amount of this agreement
 @return owedDeposit Account owed deposit amount of this agreement
