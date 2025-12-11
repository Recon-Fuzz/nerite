# Function: getSubscriptionByID(contract ISuperfluidToken,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `getSubscriptionByID(contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 25306:982:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.getSubscriptionByID implementation
function getSubscriptionByID(ISuperfluidToken token, bytes32 agreementId) override external view returns (address publisher, uint32 indexId, bool approved, uint128 units, uint256 pendingDistribution) {
    bool exist;
    bytes32 iId;
    IndexData memory idata;
    SubscriptionData memory sdata;
    (exist, sdata) = _getSubscriptionData(token, agreementId);
    if (!exist) {
        revert IDA_SUBSCRIPTION_DOES_NOT_EXIST();
    }
    publisher = sdata.publisher;
    indexId = sdata.indexId;
    iId = _getPublisherId(publisher, indexId);
    (exist, idata) = _getIndexData(token, iId);
    assert(exist);
    approved = sdata.subId != _UNALLOCATED_SUB_ID;
    units = sdata.units;
    pendingDistribution = approved ? 0 : (uint256(idata.indexValue - sdata.indexValue) * uint256(sdata.units));
}
```

## Related Implementations

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

## External Calls

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## State Variable Reads

- **_UNALLOCATED_SUB_ID** (`uint32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.getSubscriptionByID(contract ISuperfluidToken,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getSubscriptionData(contract ISuperfluidToken,bytes32) (NodeID: 1)
  │   💬 Args: [token, agreementId]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 2)
  │   💬 Args: [publisher, indexId]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 3)
      💬 Args: [token, iId]
      👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.getSubscriptionByID implementation
