# Function: createIndex(contract ISuperfluidToken,uint32,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `createIndex(contract ISuperfluidToken,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 6554:697:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.createIndex implementation
function createIndex(ISuperfluidToken token, uint32 indexId, bytes calldata ctx) override external returns (bytes memory newCtx) {
    ISuperfluid.Context memory context = AgreementLibrary.authorizeTokenAccess(token, ctx);
    address publisher = context.msgSender;
    bytes32 iId = _getPublisherId(publisher, indexId);
    if (_hasIndexData(token, iId)) {
        revert IDA_INDEX_ALREADY_EXISTS();
    }
    token.createAgreement(iId, _encodeIndexData(IndexData(0, 0, 0)));
    emit IndexCreated(token, publisher, indexId, context.userData);
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

### _getPublisherId(address,uint32)

- **Kind**: internal
- **Source**: 34290:221:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getPublisherId(address,uint32)`

```solidity
function _getPublisherId(address publisher, uint32 indexId) private pure returns (bytes32 iId) {
    return keccak256(abi.encodePacked("publisher", publisher, indexId));
}
```

### _hasIndexData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 35463:285:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_hasIndexData(contract ISuperfluidToken,bytes32)`

```solidity
function _hasIndexData(ISuperfluidToken token, bytes32 iId) private view returns (bool exist) {
    bytes32[] memory adata = token.getAgreementData(address(this), iId, 2);
    uint256 a = uint256(adata[0]);
    exist = a > 0;
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

- **ISuperfluidToken::createAgreement(bytes32,bytes32[])**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.createIndex(contract ISuperfluidToken,uint32,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 2)
  │   💬 Args: [publisher, indexId]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._hasIndexData(contract ISuperfluidToken,bytes32) (NodeID: 3)
  │   💬 Args: [token, iId]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._encodeIndexData(struct InstantDistributionAgreementV1.IndexData) (NodeID: 4)
      💬 Args: [IndexData(0, 0, 0)]
      👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.createIndex implementation
