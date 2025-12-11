# Function: getMemberFlowRate(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getMemberFlowRate(address)`
- **Visibility**: external
- **Source Range**: 11022:321:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getMemberFlowRate(address memberAddr) override external view returns (int96) {
    uint128 units = _getUnits(memberAddr);
    if (units == 0) return 0; else return (_index.wrappedFlowRate * uint256(units).toInt256()).toInt96();
}
```

## Related Implementations

### _getUnits(address)

- **Kind**: internal
- **Source**: 8277:130:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getUnits(address)`

```solidity
function _getUnits(address memberAddr) internal view returns (uint128) {
    return _membersData[memberAddr].ownedUnits;
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

## State Variable Reads

- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getMemberFlowRate(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPool._getUnits(address) (NodeID: 1)
  │   💬 Args: [memberAddr]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 2)
  │   💬 Args: [uint256(units)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 3)
      💬 Args: [(_index.wrappedFlowRate * uint256(units).toInt256())]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The flow rate a member is receiving from the pool
 @param memberAddr The address of the member
