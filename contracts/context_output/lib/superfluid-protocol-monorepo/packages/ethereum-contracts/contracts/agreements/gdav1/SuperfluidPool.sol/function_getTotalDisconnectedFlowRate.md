# Function: getTotalDisconnectedFlowRate()

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getTotalDisconnectedFlowRate()`
- **Visibility**: external
- **Source Range**: 9842:143:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getTotalDisconnectedFlowRate() override external view returns (int96 flowRate) {
    return _getTotalDisconnectedFlowRate();
}
```

## Related Implementations

### _getTotalDisconnectedFlowRate()

- **Kind**: internal
- **Source**: 9415:385:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getTotalDisconnectedFlowRate()`

```solidity
function _getTotalDisconnectedFlowRate() internal view returns (int96 flowRate) {
    PDPoolIndex memory pdPoolIndex = poolIndexDataToPDPoolIndex(_index);
    PDPoolMember memory disconnectedMembers = _memberDataToPDPoolMember(_disconnectedMembers);
    return int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit().mul(disconnectedMembers.owned_units))).toInt96();
}
```

### poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData)

- **Kind**: free-function
- **Source**: 1941:298:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData)`

```solidity
function poolIndexDataToPDPoolIndex(SuperfluidPool.PoolIndexData memory data) pure returns (PDPoolIndex memory pdPoolIndex) {
    pdPoolIndex = PDPoolIndex({total_units: toSemanticMoneyUnit(data.totalUnits), _wrapped_particle: poolIndexDataToWrappedParticle(data)});
}
```

### toSemanticMoneyUnit(uint128)

- **Kind**: free-function
- **Source**: 1283:253:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:toSemanticMoneyUnit(uint128)`

```solidity
function toSemanticMoneyUnit(uint128 units) pure returns (Unit) {
    return Unit.wrap(uint256(units).toInt256().toInt128());
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

### toInt128(int256)

- **Kind**: internal
- **Source**: 26101:198:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt128(int256)`

```solidity
///  @dev Returns the downcasted int128 from int256, reverting on
///  overflow (when the input is less than smallest int128 or
///  greater than largest int128).
///  Counterpart to Solidity's `int128` operator.
///  Requirements:
///  - input must fit into 128 bits
///  _Available since v3.1._
function toInt128(int256 value) internal pure returns (int128 downcasted) {
    downcasted = int128(value);
    require(downcasted == value, "SafeCast: value doesn't fit in 128 bits");
}
```

### poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData)

- **Kind**: free-function
- **Source**: 1538:401:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData)`

```solidity
function poolIndexDataToWrappedParticle(SuperfluidPool.PoolIndexData memory data) pure returns (BasicParticle memory wrappedParticle) {
    wrappedParticle = BasicParticle({_settled_at: Time.wrap(data.wrappedSettledAt), _flow_rate: FlowRate.wrap(int128(data.wrappedFlowRate)), _settled_value: Value.wrap(data.wrappedSettledValue)});
}
```

### _memberDataToPDPoolMember(struct SuperfluidPool.MemberData)

- **Kind**: internal
- **Source**: 12418:651:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_memberDataToPDPoolMember(struct SuperfluidPool.MemberData)`

```solidity
function _memberDataToPDPoolMember(MemberData memory memberData) internal pure returns (PDPoolMember memory pdPoolMember) {
    pdPoolMember = PDPoolMember({owned_units: toSemanticMoneyUnit(memberData.ownedUnits), _synced_particle: BasicParticle({_settled_at: Time.wrap(memberData.syncedSettledAt), _flow_rate: FlowRate.wrap(int128(memberData.syncedFlowRate)), _settled_value: Value.wrap(memberData.syncedSettledValue)}), _settled_value: Value.wrap(memberData.settledValue)});
}
```

### flow_rate_per_unit(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 15007:138:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow_rate_per_unit(struct PDPoolIndex)`

```solidity
function flow_rate_per_unit(PDPoolIndex memory a) internal pure returns (FlowRate) {
    return a._wrapped_particle.flow_rate();
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

### mul(FlowRate,Unit)

- **Kind**: internal
- **Source**: 8920:140:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:mul(FlowRate,Unit)`

```solidity
function mul(FlowRate r, Unit u) internal pure returns (FlowRate) {
    return FlowRate.wrap(FlowRate.unwrap(r) * Unit.unwrap(u));
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
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getTotalDisconnectedFlowRate() (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._getTotalDisconnectedFlowRate() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 2)
    │   💬 Args: [_index]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 3)
    │ │   💬 Args: [data.totalUnits]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 4)
    │ │ │   💬 Args: [uint256(units)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 5)
    │ │     💬 Args: [uint256(units).toInt256()]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 6)
    │     💬 Args: [data]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 7)
    │   💬 Args: [_disconnectedMembers]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 8)
    │     💬 Args: [memberData.ownedUnits]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 9)
    │   │   💬 Args: [uint256(units)]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 10)
    │       💬 Args: [uint256(units).toInt256()]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow_rate_per_unit(struct PDPoolIndex) (NodeID: 11)
    │   💬 Args: [pdPoolIndex]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 12)
    │     💬 Args: [a._wrapped_particle]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 13)
    │   💬 Args: [pdPoolIndex.flow_rate_per_unit(), disconnectedMembers.owned_units]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 14)
        💬 Args: [int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit().mul(disconnectedMembers.owned_units)))]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The flow rate of the disconnected members
