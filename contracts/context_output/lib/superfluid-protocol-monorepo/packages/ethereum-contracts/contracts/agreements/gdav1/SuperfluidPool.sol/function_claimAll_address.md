# Function: claimAll(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `claimAll(address)`
- **Visibility**: public
- **Source Range**: 19388:450:127

## Implementation

```solidity
/// @inheritdoc ISuperfluidPool
function claimAll(address memberAddr) public returns (bool) {
    bool isConnected = GDA.isMemberConnected(ISuperfluidPool(address(this)), memberAddr);
    uint32 time = uint32(ISuperfluid(superToken.getHost()).getNow());
    int256 claimedAmount = _claimAll(memberAddr, time);
    if (!isConnected) {
        _shiftDisconnectedUnits(Unit.wrap(0), Value.wrap(claimedAmount), Time.wrap(time));
    }
    return true;
}
```

## Related Implementations

### _claimAll(address,uint32)

- **Kind**: internal
- **Source**: 18841:375:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_claimAll(address,uint32)`

```solidity
function _claimAll(address memberAddr, uint32 time) internal returns (int256 amount) {
    amount = getClaimable(memberAddr, time);
    assert(GDA.poolSettleClaim(superToken, memberAddr, (amount)));
    _membersData[memberAddr].claimedValue += amount;
    emit DistributionClaimed(superToken, memberAddr, amount, _membersData[memberAddr].claimedValue);
}
```

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

### _shiftDisconnectedUnits(Unit,Value,Time)

- **Kind**: internal
- **Source**: 20642:642:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_shiftDisconnectedUnits(Unit,Value,Time)`

```solidity
function _shiftDisconnectedUnits(Unit shiftUnits, Value claimedAmount, Time t) internal {
    PDPoolIndex memory pdPoolIndex = poolIndexDataToPDPoolIndex(_index);
    PDPoolMember memory disconnectedMembers = _memberDataToPDPoolMember(_disconnectedMembers);
    PDPoolMemberMU memory mu = PDPoolMemberMU(pdPoolIndex, disconnectedMembers);
    mu = mu.settle(t);
    mu.m.owned_units = mu.m.owned_units + shiftUnits;
    mu.m._settled_value = mu.m._settled_value - claimedAmount;
    _disconnectedMembers = _pdPoolMemberToMemberData(mu.m, 0);
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

### _pdPoolMemberToMemberData(struct PDPoolMember,int256)

- **Kind**: internal
- **Source**: 13075:706:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_pdPoolMemberToMemberData(struct PDPoolMember,int256)`

```solidity
function _pdPoolMemberToMemberData(PDPoolMember memory pdPoolMember, int256 claimedValue) internal pure returns (MemberData memory memberData) {
    memberData = MemberData({ownedUnits: uint256(int256(Unit.unwrap(pdPoolMember.owned_units))).toUint128(), syncedSettledAt: Time.unwrap(pdPoolMember._synced_particle._settled_at), syncedFlowRate: int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate)).toInt96(), syncedSettledValue: Value.unwrap(pdPoolMember._synced_particle._settled_value), settledValue: Value.unwrap(pdPoolMember._settled_value), claimedValue: claimedValue});
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

## External Calls

- **GeneralDistributionAgreementV1::isMemberConnected(contract ISuperfluidPool,address)**
- **ISuperfluid::getNow()**
- **ISuperfluidToken::getHost()**
- **GeneralDistributionAgreementV1::poolSettleClaim(contract ISuperfluidToken,address,int256)**

## State Variable Reads

- **GDA** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]
- **superToken** (`contract ISuperfluidToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]
- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)
- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## State Variable Writes

- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.claimAll(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperfluidPool._claimAll(address,uint32) (NodeID: 1)
  │   💬 Args: [memberAddr, time]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperfluidPool.getClaimable(address,uint32) (NodeID: 2)
  │     💬 Args: [memberAddr, time]
  │     👁️  Def: public
  │   ├─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 3)
  │   │   💬 Args: [_index]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 4)
  │   │ │   💬 Args: [data.totalUnits]
  │   │ │   👁️  Def: internal
  │   │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 5)
  │   │ │ │   💬 Args: [uint256(units)]
  │   │ │ │   👁️  Def: internal
  │   │ │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 6)
  │   │ │     💬 Args: [uint256(units).toInt256()]
  │   │ │     👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 7)
  │   │     💬 Args: [data]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 8)
  │   │   💬 Args: [_membersData[memberAddr]]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 9)
  │   │     💬 Args: [memberData.ownedUnits]
  │   │     👁️  Def: internal
  │   │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 10)
  │   │   │   💬 Args: [uint256(units)]
  │   │   │   👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 11)
  │   │       💬 Args: [uint256(units).toInt256()]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 12)
  │       💬 Args: [PDPoolMemberMU(pdPoolIndex, pdPoolMember), t]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 13)
  │     │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
  │     │   👁️  Def: internal
  │     │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 15)
  │     │ │   💬 Args: [a.m._synced_particle]
  │     │ │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 14)
  │     │     💬 Args: [a._flow_rate, t - a._settled_at]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 16)
  │     │   💬 Args: [a.i._wrapped_particle, t]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 17)
  │     │     💬 Args: [a._flow_rate, t - a._settled_at]
  │     │     👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 18)
  │         💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
  │         👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._shiftDisconnectedUnits(Unit,Value,Time) (NodeID: 19)
      💬 Args: [Unit.wrap(0), Value.wrap(claimedAmount), Time.wrap(time)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 20)
    │   💬 Args: [_index]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 21)
    │ │   💬 Args: [data.totalUnits]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 22)
    │ │ │   💬 Args: [uint256(units)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 23)
    │ │     💬 Args: [uint256(units).toInt256()]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 24)
    │     💬 Args: [data]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 25)
    │   💬 Args: [_disconnectedMembers]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 26)
    │     💬 Args: [memberData.ownedUnits]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 27)
    │   │   💬 Args: [uint256(units)]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 28)
    │       💬 Args: [uint256(units).toInt256()]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 29)
    │   💬 Args: [mu, t]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 30)
    │ │   💬 Args: [a.i, t]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 31)
    │ │ │   💬 Args: [a]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 32)
    │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 33)
    │ │     💬 Args: [m._wrapped_particle, t]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 34)
    │ │   │   💬 Args: [a]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 35)
    │ │       💬 Args: [a, t]
    │ │       👁️  Def: internal
    │ │     └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 36)
    │ │         💬 Args: [a._flow_rate, t - a._settled_at]
    │ │         👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 37)
    │ │   💬 Args: [a.m]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 38)
    │ │     💬 Args: [a._synced_particle]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 39)
    │     💬 Args: [a, t]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 40)
    │   │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 42)
    │   │ │   💬 Args: [a.m._synced_particle]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 41)
    │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │   │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 43)
    │   │   💬 Args: [a.i._wrapped_particle, t]
    │   │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 44)
    │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 45)
    │       💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperfluidPool._pdPoolMemberToMemberData(struct PDPoolMember,int256) (NodeID: 46)
        💬 Args: [mu.m, 0]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 47)
      │   💬 Args: [uint256(int256(Unit.unwrap(pdPoolMember.owned_units)))]
      │   👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 48)
          💬 Args: [int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate))]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc ISuperfluidPool

### Interface Documentation

@notice Claims the claimable balance for `memberAddr` at `block.timestamp`
 @param memberAddr The address of the member
