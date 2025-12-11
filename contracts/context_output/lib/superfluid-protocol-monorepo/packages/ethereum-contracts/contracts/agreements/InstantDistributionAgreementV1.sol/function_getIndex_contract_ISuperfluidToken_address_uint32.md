# Function: getIndex(contract ISuperfluidToken,address,uint32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `getIndex(contract ISuperfluidToken,address,uint32)`
- **Visibility**: external
- **Source Range**: 7326:635:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.getIndex implementation
function getIndex(ISuperfluidToken token, address publisher, uint32 indexId) override external view returns (bool exist, uint128 indexValue, uint128 totalUnitsApproved, uint128 totalUnitsPending) {
    IndexData memory idata;
    bytes32 iId = _getPublisherId(publisher, indexId);
    (exist, idata) = _getIndexData(token, iId);
    if (exist) {
        indexValue = idata.indexValue;
        totalUnitsApproved = idata.totalUnitsApproved;
        totalUnitsPending = idata.totalUnitsPending;
    }
}
```

## Related Implementations

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

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.getIndex(contract ISuperfluidToken,address,uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 1)
  │   💬 Args: [publisher, indexId]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 2)
      💬 Args: [token, iId]
      👁️  Def: private
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.getIndex implementation
