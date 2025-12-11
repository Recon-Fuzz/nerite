# Function: distribute(contract ISuperfluidToken,uint32,uint256,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `distribute(contract ISuperfluidToken,uint32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 9609:818:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.distribute implementation
function distribute(ISuperfluidToken token, uint32 indexId, uint256 amount, bytes calldata ctx) override external returns (bytes memory newCtx) {
    ISuperfluid.Context memory context = AgreementLibrary.authorizeTokenAccess(token, ctx);
    address publisher = context.msgSender;
    (bytes32 iId, IndexData memory idata) = _loadIndexData(token, publisher, indexId);
    uint256 totalUnits = uint256(idata.totalUnitsApproved + idata.totalUnitsPending);
    if (totalUnits > 0) {
        uint128 indexDelta = (amount / totalUnits).toUint128();
        _updateIndex(token, publisher, indexId, iId, idata, idata.indexValue + indexDelta, context.userData);
    }
    newCtx = ctx;
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

### _loadIndexData(contract ISuperfluidToken,address,uint32)

- **Kind**: internal
- **Source**: 11991:406:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_loadIndexData(contract ISuperfluidToken,address,uint32)`

```solidity
function _loadIndexData(ISuperfluidToken token, address publisher, uint32 indexId) private view returns (bytes32 iId, IndexData memory idata) {
    bool exist;
    iId = _getPublisherId(publisher, indexId);
    (exist, idata) = _getIndexData(token, iId);
    if (!exist) revert IDA_INDEX_DOES_NOT_EXIST();
}
```

### _getPublisherId(address,uint32)

- **Kind**: internal
- **Source**: 34290:221:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getPublisherId(address,uint32)`

```solidity
function _getPublisherId(address publisher, uint32 indexId) private pure returns (bytes32 iId) {
    return keccak256(abi.encodePacked("publisher", publisher, indexId));
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

### toUint128(uint256)

- **Kind**: internal
- **Source**: 9088:192:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint128(uint256)`

```solidity
///  @dev Returns the downcasted uint128 from uint256, reverting on
///  overflow (when the input is greater than largest uint128).
///  Counterpart to Solidity's `uint128` operator.
///  Requirements:
///  - input must fit into 128 bits
///  _Available since v2.5._
function toUint128(uint256 value) internal pure returns (uint128) {
    require(value <= type(uint128).max, "SafeCast: value doesn't fit in 128 bits");
    return uint128(value);
}
```

### _updateIndex(contract ISuperfluidToken,address,uint32,bytes32,struct InstantDistributionAgreementV1.IndexData,uint128,bytes)

- **Kind**: internal
- **Source**: 10433:1552:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_updateIndex(contract ISuperfluidToken,address,uint32,bytes32,struct InstantDistributionAgreementV1.IndexData,uint128,bytes)`

```solidity
function _updateIndex(ISuperfluidToken token, address publisher, uint32 indexId, bytes32 iId, IndexData memory idata, uint128 newIndexValue, bytes memory userData) private {
    token.settleBalance(publisher, (-int256(uint256(newIndexValue - idata.indexValue))) * int256(uint256(idata.totalUnitsApproved)));
    _adjustPublisherDeposit(token, publisher, int256(uint256(newIndexValue - idata.indexValue)) * int256(uint256(idata.totalUnitsPending)));
    uint128 oldIndexValue = idata.indexValue;
    idata.indexValue = newIndexValue;
    token.updateAgreementData(iId, _encodeIndexData(idata));
    emit IndexUpdated(token, publisher, indexId, oldIndexValue, newIndexValue, idata.totalUnitsPending, idata.totalUnitsApproved, userData);
    if (token.isAccountCriticalNow(publisher)) {
        revert IDA_INSUFFICIENT_BALANCE();
    }
}
```

### _adjustPublisherDeposit(contract ISuperfluidToken,address,int256)

- **Kind**: internal
- **Source**: 36947:553:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_adjustPublisherDeposit(contract ISuperfluidToken,address,int256)`

```solidity
function _adjustPublisherDeposit(ISuperfluidToken token, address publisher, int256 delta) private {
    if (delta == 0) return;
    bytes32[] memory data = token.getAgreementStateSlot(address(this), publisher, _PUBLISHER_DEPOSIT_STATE_SLOT_ID, 1);
    data[0] = bytes32(uint256(uint256(data[0]).toInt256() + delta));
    token.updateAgreementStateSlot(publisher, _PUBLISHER_DEPOSIT_STATE_SLOT_ID, data);
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

### _encodeIndexData(struct InstantDistributionAgreementV1.IndexData)

- **Kind**: internal
- **Source**: 35022:435:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_encodeIndexData(struct InstantDistributionAgreementV1.IndexData)`

```solidity
function _encodeIndexData(IndexData memory idata) private pure returns (bytes32[] memory data) {
    data = new bytes32[](2);
    data[0] = bytes32(uint256(1 << 128) | uint256(idata.indexValue));
    data[1] = bytes32((uint256(idata.totalUnitsApproved)) | (uint256(idata.totalUnitsPending) << 128));
}
```

## External Calls

- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidToken::settleBalance(address,int256)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluidToken::isAccountCriticalNow(address)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**

## State Variable Reads

- **_PUBLISHER_DEPOSIT_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.distribute(contract ISuperfluidToken,uint32,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._loadIndexData(contract ISuperfluidToken,address,uint32) (NodeID: 2)
  │   💬 Args: [token, publisher, indexId]
  │   👁️  Def: private
  │ ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 3)
  │ │   💬 Args: [publisher, indexId]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 4)
  │     💬 Args: [token, iId]
  │     👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 5)
  │   💬 Args: [(amount / totalUnits)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._updateIndex(contract ISuperfluidToken,address,uint32,bytes32,struct InstantDistributionAgreementV1.IndexData,uint128,bytes) (NodeID: 6)
      💬 Args: [token, publisher, indexId, iId, idata, idata.indexValue + indexDelta, context.userData]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._adjustPublisherDeposit(contract ISuperfluidToken,address,int256) (NodeID: 7)
    │   💬 Args: [token, publisher, int256(uint256(newIndexValue - idata.indexValue)) * int256(uint256(idata.totalUnitsPending))]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
    │     💬 Args: [uint256(data[0])]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 9)
        💬 Args: [idata]
        👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.distribute implementation
