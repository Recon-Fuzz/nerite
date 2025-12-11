# Function: calculateDistribution(contract ISuperfluidToken,address,uint32,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]

## Metadata

- **Contract**: InstantDistributionAgreementV1
- **Signature**: `calculateDistribution(contract ISuperfluidToken,address,uint32,uint256)`
- **Visibility**: external
- **Source Range**: 8049:727:122

## Implementation

```solidity
/// @dev IInstantDistributionAgreementV1.calculateDistribution implementation
function calculateDistribution(ISuperfluidToken token, address publisher, uint32 indexId, uint256 amount) override external view returns (uint256 actualAmount, uint128 newIndexValue) {
    bytes32 iId = _getPublisherId(publisher, indexId);
    (bool exist, IndexData memory idata) = _getIndexData(token, iId);
    if (!exist) revert IDA_INDEX_DOES_NOT_EXIST();
    uint256 totalUnits = uint256(idata.totalUnitsApproved + idata.totalUnitsPending);
    uint128 indexDelta = (amount / totalUnits).toUint128();
    newIndexValue = idata.indexValue + indexDelta;
    actualAmount = uint256(indexDelta) * totalUnits;
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

## External Calls

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: InstantDistributionAgreementV1.calculateDistribution(contract ISuperfluidToken,address,uint32,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getPublisherId(address,uint32) (NodeID: 1)
  │   💬 Args: [publisher, indexId]
  │   👁️  Def: private
  ├─ [1] ⚙️ FUNCTION: InstantDistributionAgreementV1._getIndexData(contract ISuperfluidToken,bytes32) (NodeID: 2)
  │   💬 Args: [token, iId]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 3)
      💬 Args: [(amount / totalUnits)]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IInstantDistributionAgreementV1.calculateDistribution implementation
