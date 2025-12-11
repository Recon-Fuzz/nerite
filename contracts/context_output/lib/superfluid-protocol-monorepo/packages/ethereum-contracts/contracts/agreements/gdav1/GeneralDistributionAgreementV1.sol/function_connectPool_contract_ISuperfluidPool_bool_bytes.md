# Function: connectPool(contract ISuperfluidPool,bool,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `connectPool(contract ISuperfluidPool,bool,bytes)`
- **Visibility**: public
- **Source Range**: 14421:1670:123

## Implementation

```solidity
function connectPool(ISuperfluidPool pool, bool doConnect, bytes calldata ctx) public returns (bytes memory newCtx) {
    ISuperfluidToken token = pool.superToken();
    ISuperfluid.Context memory currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
    address msgSender = currentContext.msgSender;
    newCtx = ctx;
    bool isConnected = _isMemberConnected(token, address(pool), msgSender);
    if (doConnect != isConnected) {
        assert(SuperfluidPool(address(pool)).operatorConnectMember(msgSender, doConnect, uint32(currentContext.timestamp)));
        if (doConnect) {
            uint32 poolSlotID = _findAndFillPoolConnectionsBitmap(token, msgSender, bytes32(uint256(uint160(address(pool)))));
            token.createAgreement(_getPoolMemberHash(msgSender, pool), _encodePoolMemberData(PoolMemberData({poolID: poolSlotID, pool: address(pool)})));
        } else {
            (, PoolMemberData memory poolMemberData) = _getPoolMemberData(token, msgSender, pool);
            token.terminateAgreement(_getPoolMemberHash(msgSender, pool), 1);
            _clearPoolConnectionsBitmap(token, msgSender, poolMemberData.poolID);
        }
        emit PoolConnectionUpdated(token, pool, msgSender, doConnect, currentContext.userData);
    }
}
```

## Related Implementations

### authorizeTokenAccess(contract ISuperfluidToken,bytes)

- **Kind**: internal
- **Source**: 963:468:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:authorizeTokenAccess(contract ISuperfluidToken,bytes)`

```solidity
///  @dev Authorize the msg.sender to access token agreement storage
///  NOTE:
///  - msg.sender must be the expected host contract.
///  - it should revert on unauthorized access.
function authorizeTokenAccess(ISuperfluidToken token, bytes memory ctx) internal view returns (ISuperfluid.Context memory) {
    require(token.getHost() == msg.sender, "unauthorized host");
    require(ISuperfluid(msg.sender).isCtxValid(ctx), "invalid ctx");
    return ISuperfluid(msg.sender).decodeCtx(ctx);
}
```

### _isMemberConnected(contract ISuperfluidToken,address,address)

- **Kind**: internal
- **Source**: 16097:222:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isMemberConnected(contract ISuperfluidToken,address,address)`

```solidity
function _isMemberConnected(ISuperfluidToken token, address pool, address member) internal view returns (bool) {
    (bool exist, ) = _getPoolMemberData(token, member, ISuperfluidPool(pool));
    return exist;
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

### _findAndFillPoolConnectionsBitmap(contract ISuperfluidToken,address,bytes32)

- **Kind**: internal
- **Source**: 43432:344:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_findAndFillPoolConnectionsBitmap(contract ISuperfluidToken,address,bytes32)`

```solidity
function _findAndFillPoolConnectionsBitmap(ISuperfluidToken token, address poolMember, bytes32 poolID) private returns (uint32 slotId) {
    return SlotsBitmapLibrary.findEmptySlotAndFill(token, poolMember, _POOL_SUBS_BITMAP_STATE_SLOT_ID, _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START, poolID);
}
```

### findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)

- **Kind**: internal
- **Source**: 797:1224:158
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol:SlotsBitmapLibrary:findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32)`

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

### _encodePoolMemberData(struct GeneralDistributionAgreementV1.PoolMemberData)

- **Kind**: internal
- **Source**: 42358:299:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_encodePoolMemberData(struct GeneralDistributionAgreementV1.PoolMemberData)`

```solidity
function _encodePoolMemberData(PoolMemberData memory poolMemberData) internal pure returns (bytes32[] memory data) {
    data = new bytes32[](1);
    data[0] = bytes32((uint256(uint32(poolMemberData.poolID)) << 160) | uint256(uint160(poolMemberData.pool)));
}
```

### _clearPoolConnectionsBitmap(contract ISuperfluidToken,address,uint32)

- **Kind**: internal
- **Source**: 43782:209:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_clearPoolConnectionsBitmap(contract ISuperfluidToken,address,uint32)`

```solidity
function _clearPoolConnectionsBitmap(ISuperfluidToken token, address poolMember, uint32 slotId) private {
    SlotsBitmapLibrary.clearSlot(token, poolMember, _POOL_SUBS_BITMAP_STATE_SLOT_ID, slotId);
}
```

### clearSlot(contract ISuperfluidToken,address,uint256,uint32)

- **Kind**: internal
- **Source**: 2027:714:158
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SlotsBitmapLibrary.sol:SlotsBitmapLibrary:clearSlot(contract ISuperfluidToken,address,uint256,uint32)`

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

- **ISuperfluidPool::superToken()**
- **SuperfluidPool::operatorConnectMember(address,bool,uint32)**
- **ISuperfluidToken::createAgreement(bytes32,bytes32[])**
- **ISuperfluidToken::terminateAgreement(bytes32,uint256)**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**

## State Variable Reads

- **_POOL_SUBS_BITMAP_STATE_SLOT_ID** (`uint256`)
- **_POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START** (`uint256`)
- **_MAX_NUM_SLOTS** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.connectPool(contract ISuperfluidPool,bool,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isMemberConnected(contract ISuperfluidToken,address,address) (NodeID: 2)
  │   💬 Args: [token, address(pool), msgSender]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 3)
  │     💬 Args: [token, member, ISuperfluidPool(pool)]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodePoolMemberData(uint256) (NodeID: 4)
  │       💬 Args: [uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0])]
  │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 5)
  │         💬 Args: [poolMember, pool]
  │         👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._findAndFillPoolConnectionsBitmap(contract ISuperfluidToken,address,bytes32) (NodeID: 6)
  │   💬 Args: [token, msgSender, bytes32(uint256(uint160(address(pool))))]
  │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.findEmptySlotAndFill(contract ISuperfluidToken,address,uint256,uint256,bytes32) (NodeID: 7)
  │     💬 Args: [token, poolMember, _POOL_SUBS_BITMAP_STATE_SLOT_ID, _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START, poolID]
  │     👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 8)
  │   💬 Args: [msgSender, pool]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodePoolMemberData(struct GeneralDistributionAgreementV1.PoolMemberData) (NodeID: 9)
  │   💬 Args: [PoolMemberData({poolID: poolSlotID, pool: address(pool)})]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 10)
  │   💬 Args: [token, msgSender, pool]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodePoolMemberData(uint256) (NodeID: 11)
  │     💬 Args: [uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0])]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 12)
  │       💬 Args: [poolMember, pool]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 13)
  │   💬 Args: [msgSender, pool]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._clearPoolConnectionsBitmap(contract ISuperfluidToken,address,uint32) (NodeID: 14)
      💬 Args: [token, msgSender, poolMemberData.poolID]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: SlotsBitmapLibrary.clearSlot(contract ISuperfluidToken,address,uint256,uint32) (NodeID: 15)
        💬 Args: [token, poolMember, _POOL_SUBS_BITMAP_STATE_SLOT_ID, slotId]
        👁️  Def: public
```
