# Function: getDisconnectedBalance(uint32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getDisconnectedBalance(uint32)`
- **Visibility**: external
- **Source Range**: 10027:362:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getDisconnectedBalance(uint32 time) override external view returns (int256 balance) {
    PDPoolIndex memory pdPoolIndex = poolIndexDataToPDPoolIndex(_index);
    PDPoolMember memory pdPoolMember = _memberDataToPDPoolMember(_disconnectedMembers);
    return Value.unwrap(PDPoolMemberMU(pdPoolIndex, pdPoolMember).rtb(Time.wrap(time)));
}
```

## Related Implementations

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

### rtb(struct PDPoolMemberMU,Time)

- **Kind**: internal
- **Source**: 16588:286:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:rtb(struct PDPoolMemberMU,Time)`

```solidity
/// Monetary unit rtb function for pool member.
function rtb(PDPoolMemberMU memory a, Time t) internal pure returns (Value v) {
    return a.m._settled_value + (a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())).mul(a.m.owned_units);
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

### settled_at(struct BasicParticle)

- **Kind**: internal
- **Source**: 12286:110:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settled_at(struct BasicParticle)`

```solidity
function settled_at(BasicParticle memory a) internal pure returns (Time) {
    return a._settled_at;
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

### mul(Value,Unit)

- **Kind**: internal
- **Source**: 8234:128:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:mul(Value,Unit)`

```solidity
function mul(Value a, Unit b) internal pure returns (Value) {
    return Value.wrap(Value.unwrap(a) * Unit.unwrap(b));
}
```

## State Variable Reads

- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getDisconnectedBalance(uint32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 1)
  │   💬 Args: [_index]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 2)
  │ │   💬 Args: [data.totalUnits]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 3)
  │ │ │   💬 Args: [uint256(units)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 4)
  │ │     💬 Args: [uint256(units).toInt256()]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 5)
  │     💬 Args: [data]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 6)
  │   💬 Args: [_disconnectedMembers]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 7)
  │     💬 Args: [memberData.ownedUnits]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
  │   │   💬 Args: [uint256(units)]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 9)
  │       💬 Args: [uint256(units).toInt256()]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 10)
      💬 Args: [PDPoolMemberMU(pdPoolIndex, pdPoolMember), Time.wrap(time)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 11)
    │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 13)
    │ │   💬 Args: [a.m._synced_particle]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 12)
    │     💬 Args: [a._flow_rate, t - a._settled_at]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 14)
    │   💬 Args: [a.i._wrapped_particle, t]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 15)
    │     💬 Args: [a._flow_rate, t - a._settled_at]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 16)
        💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The balance of all the disconnected members at `time`
 @param time The time to query
