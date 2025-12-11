# Function: getNetFlow(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `getNetFlow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6746:721:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getNetFlow(ISuperfluidToken token, address account) override external view returns (int96 netFlowRate) {
    netFlowRate = int256(FlowRate.unwrap(_getUIndex(abi.encode(token), account).flow_rate())).toInt96();
    if (_isPool(token, account)) {
        netFlowRate += ISuperfluidPool(account).getTotalDisconnectedFlowRate();
    }
    {
        (uint32[] memory slotIds, bytes32[] memory pidList) = _listPoolConnectionIds(token, account);
        for (uint256 i = 0; i < slotIds.length; ++i) {
            ISuperfluidPool pool = ISuperfluidPool(address(uint160(uint256(pidList[i]))));
            netFlowRate += pool.getMemberFlowRate(account);
        }
    }
}
```

## Related Implementations

### _getUIndex(bytes,address)

- **Kind**: internal
- **Source**: 34814:450:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getUIndex(bytes,address)`

```solidity
function _getUIndex(bytes memory eff, address owner) override internal view returns (BasicParticle memory uIndex) {
    (, UniversalIndexData memory universalIndexData) = _decodeUniversalIndexData(ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2));
    uIndex = _getBasicParticleFromUIndex(universalIndexData);
}
```

### _decodeUniversalIndexData(bytes32[])

- **Kind**: internal
- **Source**: 33228:737:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_decodeUniversalIndexData(bytes32[])`

```solidity
function _decodeUniversalIndexData(bytes32[] memory data) internal pure returns (bool exists, UniversalIndexData memory universalIndexData) {
    uint256 a = uint256(data[0]);
    uint256 b = uint256(data[1]);
    exists = (a > 0) || (b > 0);
    if (exists) {
        universalIndexData.flowRate = int96(int256(a >> 160) & int256(uint256(type(uint96).max)));
        universalIndexData.settledAt = uint32(uint256(a >> 128) & uint256(type(uint32).max));
        universalIndexData.totalBuffer = uint256(a >> 32) & uint256(type(uint96).max);
        universalIndexData.isPool = (((a << 224) >> 224) & 1) == 1;
        universalIndexData.settledValue = int256(b);
    }
}
```

### _getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData)

- **Kind**: internal
- **Source**: 34375:397:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData)`

```solidity
function _getBasicParticleFromUIndex(UniversalIndexData memory universalIndexData) internal pure returns (BasicParticle memory particle) {
    particle._flow_rate = FlowRate.wrap(universalIndexData.flowRate);
    particle._settled_at = Time.wrap(universalIndexData.settledAt);
    particle._settled_value = Value.wrap(universalIndexData.settledValue);
}
```

### flow_rate(struct BasicParticle)

- **Kind**: internal
- **Source**: 12672:112:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow_rate(struct BasicParticle)`

```solidity
function flow_rate(BasicParticle memory a) internal pure returns (FlowRate) {
    return a._flow_rate;
}
```

### toInt96(int256)

- **Kind**: internal
- **Source**: 28332:194:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt96(int256)`

```solidity
///  @dev Returns the downcasted int96 from int256, reverting on
///  overflow (when the input is less than smallest int96 or
///  greater than largest int96).
///  Counterpart to Solidity's `int96` operator.
///  Requirements:
///  - input must fit into 96 bits
///  _Available since v4.7._
function toInt96(int256 value) internal pure returns (int96 downcasted) {
    downcasted = int96(value);
    require(downcasted == value, "SafeCast: value doesn't fit in 96 bits");
}
```

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
}
```

### _listPoolConnectionIds(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 43997:360:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_listPoolConnectionIds(contract ISuperfluidToken,address)`

```solidity
function _listPoolConnectionIds(ISuperfluidToken token, address subscriber) private view returns (uint32[] memory slotIds, bytes32[] memory pidList) {
    (slotIds, pidList) = SlotsBitmapLibrary.listData(token, subscriber, _POOL_SUBS_BITMAP_STATE_SLOT_ID, _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START);
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

## External Calls

- **ISuperfluidPool::getTotalDisconnectedFlowRate()**
- **ISuperfluidPool::getMemberFlowRate(address)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)
- **_POOL_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)
- **_POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START** (`uint256`)
- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.getNetFlow(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 1)
  │   💬 Args: [abi.encode(token), account]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 2)
  │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 3)
  │     💬 Args: [universalIndexData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 4)
  │   💬 Args: [_getUIndex(abi.encode(token), account)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 5)
  │   💬 Args: [int256(FlowRate.unwrap(_getUIndex(abi.encode(token), account).flow_rate()))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 6)
  │   💬 Args: [token, account]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._listPoolConnectionIds(contract ISuperfluidToken,address) (NodeID: 7)
      💬 Args: [token, account]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.listData(contract ISuperfluidToken,address,uint256,uint256) (NodeID: 8)
        💬 Args: [token, subscriber, _POOL_SUBS_BITMAP_STATE_SLOT_ID, _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START]
        👁️  Def: public
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
