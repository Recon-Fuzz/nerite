# Function: realtimeBalanceOfNow(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `realtimeBalanceOfNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6341:347:123

## Implementation

```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOfNow(ISuperfluidToken token, address account) external view returns (int256 availableBalance, uint256 buffer, uint256 owedBuffer, uint256 timestamp) {
    (availableBalance, buffer, owedBuffer) = realtimeBalanceOf(token, account, block.timestamp);
    timestamp = block.timestamp;
}
```

## Related Implementations

### realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

- **Kind**: internal
- **Source**: 4951:1322:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`

```solidity
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256 time) override public view returns (int256 rtb, uint256 buf, uint256 owedBuffer) {
    UniversalIndexData memory universalIndexData = _getUIndexData(abi.encode(token), account);
    if (_isPool(token, account)) {
        rtb = ISuperfluidPool(account).getDisconnectedBalance(uint32(time));
    } else {
        rtb = Value.unwrap(_getBasicParticleFromUIndex(universalIndexData).rtb(Time.wrap(uint32(time))));
    }
    int256 fromPools;
    {
        (uint32[] memory slotIds, bytes32[] memory pidList) = _listPoolConnectionIds(token, account);
        for (uint256 i = 0; i < slotIds.length; ++i) {
            address pool = address(uint160(uint256(pidList[i])));
            (bool exist, PoolMemberData memory poolMemberData) = _getPoolMemberData(token, account, ISuperfluidPool(pool));
            assert(exist);
            assert(poolMemberData.pool == pool);
            fromPools += ISuperfluidPool(pool).getClaimable(account, uint32(time));
        }
    }
    rtb += fromPools;
    buf = uint256(universalIndexData.totalBuffer.toInt256());
    owedBuffer = 0;
}
```

### _getUIndexData(bytes,address)

- **Kind**: internal
- **Source**: 33971:398:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getUIndexData(bytes,address)`

```solidity
function _getUIndexData(bytes memory eff, address owner) internal view returns (UniversalIndexData memory universalIndexData) {
    (, universalIndexData) = _decodeUniversalIndexData(ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2));
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

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
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

### rtb(struct BasicParticle,Time)

- **Kind**: internal
- **Source**: 12861:155:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:rtb(struct BasicParticle,Time)`

```solidity
/// Monetary unit rtb function for basic particle/universal index.
function rtb(BasicParticle memory a, Time t) internal pure returns (Value v) {
    return a._flow_rate.mul(t - a._settled_at) + a._settled_value;
}
```

### mul(FlowRate,Time)

- **Kind**: internal
- **Source**: 8764:151:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:mul(FlowRate,Time)`

```solidity
function mul(FlowRate r, Time t) internal pure returns (Value) {
    return Value.wrap(FlowRate.unwrap(r) * int256(uint256(Time.unwrap(t))));
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

### _getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 43023:373:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool)`

```solidity
function _getPoolMemberData(ISuperfluidToken token, address poolMember, ISuperfluidPool pool) internal view returns (bool exist, PoolMemberData memory poolMemberData) {
    (exist, poolMemberData) = _decodePoolMemberData(uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0]));
}
```

### _decodePoolMemberData(uint256)

- **Kind**: internal
- **Source**: 42663:354:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_decodePoolMemberData(uint256)`

```solidity
function _decodePoolMemberData(uint256 data) internal pure returns (bool exist, PoolMemberData memory poolMemberData) {
    exist = data > 0;
    if (exist) {
        poolMemberData.pool = address(uint160(data & uint256(type(uint160).max)));
        poolMemberData.poolID = uint32(data >> 160);
    }
}
```

### _getPoolMemberHash(address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 30596:203:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolMemberHash(address,contract ISuperfluidPool)`

```solidity
function _getPoolMemberHash(address poolMember, ISuperfluidPool pool) internal view returns (bytes32) {
    return keccak256(abi.encode(block.chainid, "poolMember", poolMember, address(pool)));
}
```

### toInt256(uint256)

- **Kind**: internal
- **Source**: 34781:297:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt256(uint256)`

```solidity
///  @dev Converts an unsigned uint256 into a signed int256.
///  Requirements:
///  - input must be less than or equal to maxInt256.
///  _Available since v3.0._
function toInt256(uint256 value) internal pure returns (int256) {
    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
    return int256(value);
}
```

## External Calls

- **ISuperfluidPool::getDisconnectedBalance(uint32)**
- **ISuperfluidPool::getClaimable(address,uint32)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)
- **_POOL_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)
- **_POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START** (`uint256`)
- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.realtimeBalanceOfNow(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1.realtimeBalanceOf(contract ISuperfluidToken,address,uint256) (NodeID: 1)
      💬 Args: [token, account, block.timestamp]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 2)
    │   💬 Args: [abi.encode(token), account]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 3)
    │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 4)
    │   💬 Args: [token, account]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 5)
    │   💬 Args: [universalIndexData]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 6)
    │   💬 Args: [_getBasicParticleFromUIndex(universalIndexData), Time.wrap(uint32(time))]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 7)
    │     💬 Args: [a._flow_rate, t - a._settled_at]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._listPoolConnectionIds(contract ISuperfluidToken,address) (NodeID: 8)
    │   💬 Args: [token, account]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: SlotsBitmapLibrary.listData(contract ISuperfluidToken,address,uint256,uint256) (NodeID: 9)
    │     💬 Args: [token, subscriber, _POOL_SUBS_BITMAP_STATE_SLOT_ID, _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START]
    │     👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 10)
    │   💬 Args: [token, account, ISuperfluidPool(pool)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodePoolMemberData(uint256) (NodeID: 11)
    │     💬 Args: [uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0])]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 12)
    │       💬 Args: [poolMember, pool]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 13)
        💬 Args: [universalIndexData.totalBuffer]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperAgreement.realtimeBalanceOf implementation
