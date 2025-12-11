# Function: getSubscription(contract ISuperfluidToken,address,uint32,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `getSubscription(contract ISuperfluidToken,address,uint32,address)`
- **Visibility**: external
- **Source Range**: 24356:864:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.getSubscription implementation
function getSubscription(ISuperfluidToken token, address publisher, uint32 indexId, address subscriber) override external view returns (bool exist, bool approved, uint128 units, uint256 pendingDistribution) {
    bytes32 iId;
    bytes32 sId;
    IndexData memory idata;
    SubscriptionData memory sdata;
    (iId, sId, idata, exist, sdata) = _loadAllData(token, publisher, subscriber, indexId, false);
    if (!exist) return (false, false, 0, 0);
    approved = sdata.subId != _UNALLOCATED_SUB_ID;
    units = sdata.units;
    pendingDistribution = approved ? 0 : (uint256(idata.indexValue - sdata.indexValue) * uint256(sdata.units));
}
```

## Related Implementations

### _loadAllData(contract ISuperfluidToken,address,address,uint32,bool)

- **Kind**: internal
- **Source**: 33085:1014:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_loadAllData(contract ISuperfluidToken,address,address,uint32,bool)`

```solidity
function _loadAllData(ISuperfluidToken token, address publisher, address subscriber, uint32 indexId, bool requireSubscriptionExisting) private view returns (bytes32 iId, bytes32 sId, IndexData memory idata, bool subscriptionExists, SubscriptionData memory sdata) {
    bool indexExists;
    iId = _getPublisherId(publisher, indexId);
    sId = _getSubscriptionId(subscriber, iId);
    (indexExists, idata) = _getIndexData(token, iId);
    if (!indexExists) revert IDA_INDEX_DOES_NOT_EXIST();
    (subscriptionExists, sdata) = _getSubscriptionData(token, sId);
    if (requireSubscriptionExisting) {
        if (!subscriptionExists) {
            revert IDA_SUBSCRIPTION_DOES_NOT_EXIST();
        }
        assert(sdata.publisher == publisher);
        assert(sdata.indexId == indexId);
    }
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

### _getSubscriptionId(address,bytes32)

- **Kind**: internal
- **Source**: 34517:222:122
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol:InstantDistributionAgreementV1:_getSubscriptionId(address,bytes32)`

```solidity
function _getSubscriptionId(address subscriber, bytes32 iId) private pure returns (bytes32 sId) {
    return keccak256(abi.encodePacked("subscription", subscriber, iId));
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

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## State Variable Reads

- **_UNALLOCATED_SUB_ID** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.getSubscription(contract ISuperfluidToken,address,uint32,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._loadAllData(contract ISuperfluidToken,address,address,uint32,bool) (NodeID: 1)
      💬 Args: [token, publisher, subscriber, indexId, false]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 2)
    │   💬 Args: [publisher, indexId]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionId(address,bytes32) (NodeID: 3)
    │   💬 Args: [subscriber, iId]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 4)
    │   💬 Args: [token, iId]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionData(contract ISuperfluidToken,bytes32) (NodeID: 5)
        💬 Args: [token, sId]
        👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.getSubscription implementation
