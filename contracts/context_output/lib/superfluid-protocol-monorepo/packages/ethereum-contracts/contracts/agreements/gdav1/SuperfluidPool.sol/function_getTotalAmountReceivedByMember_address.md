# Function: getTotalAmountReceivedByMember(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getTotalAmountReceivedByMember(address)`
- **Visibility**: external
- **Source Range**: 10431:549:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getTotalAmountReceivedByMember(address memberAddr) override external view returns (uint256) {
    MemberData memory memberData = _membersData[memberAddr];
    return uint256(Value.unwrap(PDPoolMemberMU(poolIndexDataToPDPoolIndex(_index), _memberDataToPDPoolMember(memberData)).settle(Time.wrap(uint32(block.timestamp))).m._settled_value));
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

### settle(struct PDPoolMemberMU,Time)

- **Kind**: internal
- **Source**: 16265:265:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settle(struct PDPoolMemberMU,Time)`

```solidity
/// Monetary unit settle function for pool member.
function settle(PDPoolMemberMU memory a, Time t) internal pure returns (PDPoolMemberMU memory b) {
    b.i = a.i.settle(t);
    b.m = a.m.clone();
    b.m._settled_value = a.rtb(t);
    b.m._synced_particle = b.i._wrapped_particle;
}
```

### settle(struct PDPoolIndex,Time)

- **Kind**: internal
- **Source**: 14654:194:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settle(struct PDPoolIndex,Time)`

```solidity
/// Monetary unit settle function for pool index.
function settle(PDPoolIndex memory a, Time t) internal pure returns (PDPoolIndex memory m) {
    m = a.clone();
    m._wrapped_particle = m._wrapped_particle.settle(t);
}
```

### clone(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 14262:199:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:clone(struct PDPoolIndex)`

```solidity
/// Pure data clone function.
function clone(PDPoolIndex memory a) internal pure returns (PDPoolIndex memory b) {
    b.total_units = a.total_units;
    b._wrapped_particle = a._wrapped_particle.clone();
}
```

### clone(struct BasicParticle)

- **Kind**: internal
- **Source**: 12043:237:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:clone(struct BasicParticle)`

```solidity
/// Pure data clone function.
function clone(BasicParticle memory a) internal pure returns (BasicParticle memory b) {
    b._settled_at = a._settled_at;
    b._flow_rate = a._flow_rate;
    b._settled_value = a._settled_value;
}
```

### settle(struct BasicParticle,Time)

- **Kind**: internal
- **Source**: 12476:190:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settle(struct BasicParticle,Time)`

```solidity
/// Monetary unit settle function for basic particle/universal index.
function settle(BasicParticle memory a, Time t) internal pure returns (BasicParticle memory b) {
    b = a.clone();
    b._settled_value = rtb(a, t);
    b._settled_at = t;
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

### mul(FlowRate,Time)

- **Kind**: internal
- **Source**: 8764:151:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:mul(FlowRate,Time)`

```solidity
function mul(FlowRate r, Time t) internal pure returns (Value) {
    return Value.wrap(FlowRate.unwrap(r) * int256(uint256(Time.unwrap(t))));
}
```

### clone(struct PDPoolMember)

- **Kind**: internal
- **Source**: 15960:244:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:clone(struct PDPoolMember)`

```solidity
/// Pure data clone function.
function clone(PDPoolMember memory a) internal pure returns (PDPoolMember memory b) {
    b.owned_units = a.owned_units;
    b._settled_value = a._settled_value;
    b._synced_particle = a._synced_particle.clone();
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

### settled_at(struct BasicParticle)

- **Kind**: internal
- **Source**: 12286:110:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settled_at(struct BasicParticle)`

```solidity
function settled_at(BasicParticle memory a) internal pure returns (Time) {
    return a._settled_at;
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

- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)
- **_index** (`struct SuperfluidPool.PoolIndexData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getTotalAmountReceivedByMember(address) (NodeID: 0)
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
  │   💬 Args: [memberData]
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
  └─ [1] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 10)
      💬 Args: [PDPoolMemberMU(poolIndexDataToPDPoolIndex(_index), _memberDataToPDPoolMember(memberData)), Time.wrap(uint32(block.timestamp))]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 11)
    │   💬 Args: [a.i, t]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 12)
    │ │   💬 Args: [a]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 13)
    │ │     💬 Args: [a._wrapped_particle]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 14)
    │     💬 Args: [m._wrapped_particle, t]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 15)
    │   │   💬 Args: [a]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 16)
    │       💬 Args: [a, t]
    │       👁️  Def: internal
    │     └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 17)
    │         💬 Args: [a._flow_rate, t - a._settled_at]
    │         👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 18)
    │   💬 Args: [a.m]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 19)
    │     💬 Args: [a._synced_particle]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 20)
        💬 Args: [a, t]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 21)
      │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 23)
      │ │   💬 Args: [a.m._synced_particle]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 22)
      │     💬 Args: [a._flow_rate, t - a._settled_at]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 24)
      │   💬 Args: [a.i._wrapped_particle, t]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 25)
      │     💬 Args: [a._flow_rate, t - a._settled_at]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 26)
          💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The total amount received by `memberAddr` in the pool
 @param memberAddr The address of the member
 @return totalAmountReceived The total amount received by the member
