# Function: getClaimableNow(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `getClaimableNow(address)`
- **Visibility**: external
- **Source Range**: 13823:301:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function getClaimableNow(address memberAddr) override external view returns (int256 claimableBalance, uint256 timestamp) {
    timestamp = ISuperfluid(superToken.getHost()).getNow();
    return (getClaimable(memberAddr, uint32(timestamp)), timestamp);
}
```

## Related Implementations

### getClaimable(address,uint32)

- **Kind**: internal
- **Source**: 14166:460:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:getClaimable(address,uint32)`

```solidity
/// @inheritdoc ISuperfluidPool
function getClaimable(address memberAddr, uint32 time) override public view returns (int256) {
    Time t = Time.wrap(time);
    PDPoolIndex memory pdPoolIndex = poolIndexDataToPDPoolIndex(_index);
    PDPoolMember memory pdPoolMember = _memberDataToPDPoolMember(_membersData[memberAddr]);
    return Value.unwrap(PDPoolMemberMU(pdPoolIndex, pdPoolMember).rtb(t) - Value.wrap(_membersData[memberAddr].claimedValue));
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

## External Calls

- **ISuperfluid::getNow()**
- **ISuperfluidToken::getHost()**

## State Variable Reads

- **superToken** (`contract ISuperfluidToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]
- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.getClaimableNow(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool.getClaimable(address,uint32) (NodeID: 1)
      💬 Args: [memberAddr, uint32(timestamp)]
      👁️  Def: public
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
    │   💬 Args: [_membersData[memberAddr]]
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
    └─ [2] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 11)
        💬 Args: [PDPoolMemberMU(pdPoolIndex, pdPoolMember), t]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 12)
      │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 14)
      │ │   💬 Args: [a.m._synced_particle]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 13)
      │     💬 Args: [a._flow_rate, t - a._settled_at]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 15)
      │   💬 Args: [a.i._wrapped_particle, t]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 16)
      │     💬 Args: [a._flow_rate, t - a._settled_at]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 17)
          💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice The claimable balance for `memberAddr` at `block.timestamp` in the pool
 @param memberAddr The address of the member
