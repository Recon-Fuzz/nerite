# Function: transfer(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 6354:151:127

## Implementation

```solidity
/// @dev Transfers `amount` units from `msg.sender` to `to`
function transfer(address to, uint256 amount) override external returns (bool) {
    _transfer(msg.sender, to, amount);
    return true;
}
```

## Related Implementations

### _transfer(address,address,uint256)

- **Kind**: internal
- **Source**: 6962:605:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_transfer(address,address,uint256)`

```solidity
function _transfer(address from, address to, uint256 amount) internal {
    if (from == to) revert SUPERFLUID_POOL_SELF_TRANSFER_NOT_ALLOWED();
    if (!transferabilityForUnitsOwner) revert SUPERFLUID_POOL_TRANSFER_UNITS_NOT_ALLOWED();
    uint128 fromUnitsBefore = _getUnits(from);
    uint128 toUnitsBefore = _getUnits(to);
    _updateMemberUnits(from, fromUnitsBefore - amount.toUint128());
    _updateMemberUnits(to, toUnitsBefore + amount.toUint128());
    emit Transfer(from, to, amount);
}
```

### _getUnits(address)

- **Kind**: internal
- **Source**: 8277:130:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_getUnits(address)`

```solidity
function _getUnits(address memberAddr) internal view returns (uint128) {
    return _membersData[memberAddr].ownedUnits;
}
```

### _updateMemberUnits(address,uint128)

- **Kind**: internal
- **Source**: 17038:1797:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_updateMemberUnits(address,uint128)`

```solidity
function _updateMemberUnits(address memberAddr, uint128 newUnits) internal returns (bool) {
    if (GDA.isPool(superToken, memberAddr)) revert SUPERFLUID_POOL_NO_POOL_MEMBERS();
    if (memberAddr == address(0)) revert SUPERFLUID_POOL_NO_ZERO_ADDRESS();
    uint32 time = uint32(ISuperfluid(superToken.getHost()).getNow());
    Time t = Time.wrap(time);
    Unit wrappedUnits = toSemanticMoneyUnit(newUnits);
    PDPoolIndex memory pdPoolIndex = poolIndexDataToPDPoolIndex(_index);
    MemberData memory memberData = _membersData[memberAddr];
    PDPoolMember memory pdPoolMember = _memberDataToPDPoolMember(memberData);
    uint128 oldUnits = memberData.ownedUnits;
    PDPoolMemberMU memory mu = PDPoolMemberMU(pdPoolIndex, pdPoolMember);
    if (!GDA.isMemberConnected(ISuperfluidPool(address(this)), memberAddr)) {
        _shiftDisconnectedUnits(wrappedUnits - mu.m.owned_units, Value.wrap(0), t);
    }
    {
        BasicParticle memory p;
        (pdPoolIndex, pdPoolMember, p) = mu.pool_member_update(p, wrappedUnits, t);
        _index = _pdPoolIndexToPoolIndexData(pdPoolIndex);
        int256 claimedValue = _membersData[memberAddr].claimedValue;
        _membersData[memberAddr] = _pdPoolMemberToMemberData(pdPoolMember, claimedValue);
        assert(GDA.appendIndexUpdateByPool(superToken, p, t));
    }
    emit MemberUnitsUpdated(superToken, memberAddr, oldUnits, newUnits);
    _handlePoolMemberNFT(memberAddr, newUnits);
    return true;
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

### poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData)

- **Kind**: free-function
- **Source**: 1941:298:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData)`

```solidity
function poolIndexDataToPDPoolIndex(SuperfluidPool.PoolIndexData memory data) pure returns (PDPoolIndex memory pdPoolIndex) {
    pdPoolIndex = PDPoolIndex({total_units: toSemanticMoneyUnit(data.totalUnits), _wrapped_particle: poolIndexDataToWrappedParticle(data)});
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

### _pdPoolMemberToMemberData(struct PDPoolMember,int256)

- **Kind**: internal
- **Source**: 13075:706:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_pdPoolMemberToMemberData(struct PDPoolMember,int256)`

```solidity
function _pdPoolMemberToMemberData(PDPoolMember memory pdPoolMember, int256 claimedValue) internal pure returns (MemberData memory memberData) {
    memberData = MemberData({ownedUnits: uint256(int256(Unit.unwrap(pdPoolMember.owned_units))).toUint128(), syncedSettledAt: Time.unwrap(pdPoolMember._synced_particle._settled_at), syncedFlowRate: int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate)).toInt96(), syncedSettledValue: Value.unwrap(pdPoolMember._synced_particle._settled_value), settledValue: Value.unwrap(pdPoolMember._settled_value), claimedValue: claimedValue});
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

### pool_member_update(struct PDPoolMemberMU,struct BasicParticle,Unit,Time)

- **Kind**: internal
- **Source**: 16937:1044:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:pool_member_update(struct PDPoolMemberMU,struct BasicParticle,Unit,Time)`

```solidity
/// Update the unit amount of the member of the pool
function pool_member_update(PDPoolMemberMU memory b1, BasicParticle memory a, Unit u, Time t) internal pure returns (PDPoolIndex memory p, PDPoolMember memory p1, BasicParticle memory b) {
    Unit oldTotalUnit = b1.i.total_units;
    Unit newTotalUnit = (oldTotalUnit + u) - b1.m.owned_units;
    PDPoolMemberMU memory b1s = b1.settle(t);
    FlowRate nr = b1s.i._wrapped_particle._flow_rate;
    FlowRate er;
    if (Unit.unwrap(newTotalUnit) != 0) {
        (nr, er) = nr.mul_quotrem(oldTotalUnit, newTotalUnit);
        er = er;
    } else {
        er = nr.mul(oldTotalUnit);
        nr = FlowRate.wrap(0);
    }
    b1s.i._wrapped_particle = b1s.i._wrapped_particle.flow1(nr);
    b1s.i.total_units = newTotalUnit;
    b = a.settle(t).flow1(a._flow_rate + er);
    p = b1s.i;
    p1 = b1s.m;
    p1.owned_units = u;
    p1._synced_particle = b1s.i._wrapped_particle.clone();
}
```

### mul_quotrem(FlowRate,Unit,Unit)

- **Kind**: internal
- **Source**: 9445:145:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:mul_quotrem(FlowRate,Unit,Unit)`

```solidity
function mul_quotrem(FlowRate r, Unit u1, Unit u2) internal pure returns (FlowRate nr, FlowRate er) {
    return r.mul(u1).quotrem(u2);
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

### quotrem(FlowRate,Unit)

- **Kind**: internal
- **Source**: 9210:230:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:quotrem(FlowRate,Unit)`

```solidity
function quotrem(FlowRate r, Unit u) internal pure returns (FlowRate nr, FlowRate er) {
    nr = r.div(u);
    er = r - nr.mul(u);
}
```

### div(FlowRate,Unit)

- **Kind**: internal
- **Source**: 9065:140:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:div(FlowRate,Unit)`

```solidity
function div(FlowRate a, Unit b) internal pure returns (FlowRate) {
    return FlowRate.wrap(FlowRate.unwrap(a) / Unit.unwrap(b));
}
```

### flow1(struct BasicParticle,FlowRate)

- **Kind**: internal
- **Source**: 13203:154:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow1(struct BasicParticle,FlowRate)`

```solidity
function flow1(BasicParticle memory a, FlowRate r) internal pure returns (BasicParticle memory b) {
    b = a.clone();
    b._flow_rate = r;
}
```

### _pdPoolIndexToPoolIndexData(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 11862:550:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_pdPoolIndexToPoolIndexData(struct PDPoolIndex)`

```solidity
function _pdPoolIndexToPoolIndexData(PDPoolIndex memory pdPoolIndex) internal pure returns (PoolIndexData memory data) {
    data = PoolIndexData({totalUnits: int256(Unit.unwrap(pdPoolIndex.total_units)).toUint256().toUint128(), wrappedSettledAt: Time.unwrap(pdPoolIndex.settled_at()), wrappedFlowRate: int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit())).toInt96(), wrappedSettledValue: Value.unwrap(pdPoolIndex._wrapped_particle._settled_value)});
}
```

### toUint256(int256)

- **Kind**: internal
- **Source**: 17187:168:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint256(int256)`

```solidity
///  @dev Converts a signed int256 into an unsigned uint256.
///  Requirements:
///  - input must be greater than or equal to 0.
///  _Available since v3.0._
function toUint256(int256 value) internal pure returns (uint256) {
    require(value >= 0, "SafeCast: value must be positive");
    return uint256(value);
}
```

### settled_at(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 14467:127:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settled_at(struct PDPoolIndex)`

```solidity
function settled_at(PDPoolIndex memory a) internal pure returns (Time) {
    return a._wrapped_particle.settled_at();
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

### _handlePoolMemberNFT(address,uint128)

- **Kind**: internal
- **Source**: 16034:998:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_handlePoolMemberNFT(address,uint128)`

```solidity
function _handlePoolMemberNFT(address memberAddr, uint128 newUnits) internal {
    IPoolMemberNFT poolMemberNFT = IPoolMemberNFT(_canCallNFTHook(superToken));
    if (address(poolMemberNFT) != address(0)) {
        uint256 tokenId = poolMemberNFT.getTokenId(address(this), memberAddr);
        if (newUnits == 0) {
            if (poolMemberNFT.poolMemberDataByTokenId(tokenId).member != address(0)) {
                poolMemberNFT.onDelete(address(this), memberAddr);
            }
        } else {
            if (poolMemberNFT.poolMemberDataByTokenId(tokenId).member == address(0)) {
                poolMemberNFT.onCreate(address(this), memberAddr);
            } else {
                poolMemberNFT.onUpdate(address(this), memberAddr);
            }
        }
    }
}
```

### _canCallNFTHook(contract ISuperfluidToken)

- **Kind**: internal
- **Source**: 15268:760:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:_canCallNFTHook(contract ISuperfluidToken)`

```solidity
///  @notice Checks whether or not the NFT hook can be called.
///  @dev A staticcall, so `POOL_MEMBER_NFT` must be a view otherwise the assumption is that it reverts
///  @param token the super token that is being streamed
///  @return poolMemberNFT the address returned by low level call
function _canCallNFTHook(ISuperfluidToken token) internal view returns (address poolMemberNFT) {
    (bool success, bytes memory data) = address(token).staticcall(abi.encodeWithSelector(ISuperToken.POOL_MEMBER_NFT.selector));
    if (success) {
        poolMemberNFT = abi.decode(data, (address));
    }
}
```

## External Calls

- **GeneralDistributionAgreementV1::isPool(contract ISuperfluidToken,address)**
- **ISuperfluid::getNow()**
- **ISuperfluidToken::getHost()**
- **GeneralDistributionAgreementV1::isMemberConnected(contract ISuperfluidPool,address)**
- **GeneralDistributionAgreementV1::appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time)**
- **IPoolMemberNFT::getTokenId(address,address)**
- **IPoolMemberNFT::poolMemberDataByTokenId(uint256)**
- **IPoolMemberNFT::onDelete(address,address)**
- **IPoolMemberNFT::onCreate(address,address)**
- **IPoolMemberNFT::onUpdate(address,address)**
- **address::staticcall(bytes memory)**

## State Variable Reads

- **transferabilityForUnitsOwner** (`bool`)
- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)
- **GDA** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]
- **superToken** (`contract ISuperfluidToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]
- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## State Variable Writes

- **_index** (`struct SuperfluidPool.PoolIndexData`)
- **_membersData** (`mapping(address => struct SuperfluidPool.MemberData)`)
- **_disconnectedMembers** (`struct SuperfluidPool.MemberData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.transfer(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperfluidPool._transfer(address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, to, amount]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPool._getUnits(address) (NodeID: 2)
    │   💬 Args: [from]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPool._getUnits(address) (NodeID: 3)
    │   💬 Args: [to]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPool._updateMemberUnits(address,uint128) (NodeID: 4)
    │   💬 Args: [from, fromUnitsBefore - amount.toUint128()]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 93)
    │ │   💬 Args: [amount]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 5)
    │ │   💬 Args: [newUnits]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 6)
    │ │ │   💬 Args: [uint256(units)]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 7)
    │ │     💬 Args: [uint256(units).toInt256()]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 8)
    │ │   💬 Args: [_index]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 9)
    │ │ │   💬 Args: [data.totalUnits]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 10)
    │ │ │ │   💬 Args: [uint256(units)]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 11)
    │ │ │     💬 Args: [uint256(units).toInt256()]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 12)
    │ │     💬 Args: [data]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 13)
    │ │   💬 Args: [memberData]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 14)
    │ │     💬 Args: [memberData.ownedUnits]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 15)
    │ │   │   💬 Args: [uint256(units)]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 16)
    │ │       💬 Args: [uint256(units).toInt256()]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperfluidPool._shiftDisconnectedUnits(Unit,Value,Time) (NodeID: 17)
    │ │   💬 Args: [wrappedUnits - mu.m.owned_units, Value.wrap(0), t]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 18)
    │ │ │   💬 Args: [_index]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 19)
    │ │ │ │   💬 Args: [data.totalUnits]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ ├─ [6] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 20)
    │ │ │ │ │   💬 Args: [uint256(units)]
    │ │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 21)
    │ │ │ │     💬 Args: [uint256(units).toInt256()]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 22)
    │ │ │     💬 Args: [data]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 23)
    │ │ │   💬 Args: [_disconnectedMembers]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 24)
    │ │ │     💬 Args: [memberData.ownedUnits]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 25)
    │ │ │   │   💬 Args: [uint256(units)]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 26)
    │ │ │       💬 Args: [uint256(units).toInt256()]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 27)
    │ │ │   💬 Args: [mu, t]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 28)
    │ │ │ │   💬 Args: [a.i, t]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 29)
    │ │ │ │ │   💬 Args: [a]
    │ │ │ │ │   👁️  Def: internal
    │ │ │ │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 30)
    │ │ │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │ │ │     👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 31)
    │ │ │ │     💬 Args: [m._wrapped_particle, t]
    │ │ │ │     👁️  Def: internal
    │ │ │ │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 32)
    │ │ │ │   │   💬 Args: [a]
    │ │ │ │   │   👁️  Def: internal
    │ │ │ │   └─ [7] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 33)
    │ │ │ │       💬 Args: [a, t]
    │ │ │ │       👁️  Def: internal
    │ │ │ │     └─ [8] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 34)
    │ │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │ │         👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 35)
    │ │ │ │   💬 Args: [a.m]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 36)
    │ │ │ │     💬 Args: [a._synced_particle]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 37)
    │ │ │     💬 Args: [a, t]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 38)
    │ │ │   │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
    │ │ │   │   👁️  Def: internal
    │ │ │   │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 40)
    │ │ │   │ │   💬 Args: [a.m._synced_particle]
    │ │ │   │ │   👁️  Def: internal
    │ │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 39)
    │ │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │   │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 41)
    │ │ │   │   💬 Args: [a.i._wrapped_particle, t]
    │ │ │   │   👁️  Def: internal
    │ │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 42)
    │ │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │   │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 43)
    │ │ │       💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
    │ │ │       👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SuperfluidPool._pdPoolMemberToMemberData(struct PDPoolMember,int256) (NodeID: 44)
    │ │     💬 Args: [mu.m, 0]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 45)
    │ │   │   💬 Args: [uint256(int256(Unit.unwrap(pdPoolMember.owned_units)))]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 46)
    │ │       💬 Args: [int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate))]
    │ │       👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.pool_member_update(struct PDPoolMemberMU,struct BasicParticle,Unit,Time) (NodeID: 47)
    │ │   💬 Args: [mu, p, wrappedUnits, t]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 48)
    │ │ │   💬 Args: [b1, t]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 49)
    │ │ │ │   💬 Args: [a.i, t]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 50)
    │ │ │ │ │   💬 Args: [a]
    │ │ │ │ │   👁️  Def: internal
    │ │ │ │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 51)
    │ │ │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │ │ │     👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 52)
    │ │ │ │     💬 Args: [m._wrapped_particle, t]
    │ │ │ │     👁️  Def: internal
    │ │ │ │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 53)
    │ │ │ │   │   💬 Args: [a]
    │ │ │ │   │   👁️  Def: internal
    │ │ │ │   └─ [7] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 54)
    │ │ │ │       💬 Args: [a, t]
    │ │ │ │       👁️  Def: internal
    │ │ │ │     └─ [8] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 55)
    │ │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │ │         👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 56)
    │ │ │ │   💬 Args: [a.m]
    │ │ │ │   👁️  Def: internal
    │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 57)
    │ │ │ │     💬 Args: [a._synced_particle]
    │ │ │ │     👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 58)
    │ │ │     💬 Args: [a, t]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 59)
    │ │ │   │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
    │ │ │   │   👁️  Def: internal
    │ │ │   │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 61)
    │ │ │   │ │   💬 Args: [a.m._synced_particle]
    │ │ │   │ │   👁️  Def: internal
    │ │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 60)
    │ │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │   │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 62)
    │ │ │   │   💬 Args: [a.i._wrapped_particle, t]
    │ │ │   │   👁️  Def: internal
    │ │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 63)
    │ │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │   │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 64)
    │ │ │       💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul_quotrem(FlowRate,Unit,Unit) (NodeID: 65)
    │ │ │   💬 Args: [nr, oldTotalUnit, newTotalUnit]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 66)
    │ │ │ │   💬 Args: [r, u1]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.quotrem(FlowRate,Unit) (NodeID: 67)
    │ │ │     💬 Args: [r.mul(u1), u2]
    │ │ │     👁️  Def: internal
    │ │ │   ├─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 68)
    │ │ │   │   💬 Args: [r, u]
    │ │ │   │   👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 69)
    │ │ │       💬 Args: [nr, u]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 70)
    │ │ │   💬 Args: [nr, oldTotalUnit]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 71)
    │ │ │   💬 Args: [b1s.i._wrapped_particle, nr]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 72)
    │ │ │     💬 Args: [a]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 73)
    │ │ │   💬 Args: [a, t]
    │ │ │   👁️  Def: internal
    │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 74)
    │ │ │ │   💬 Args: [a]
    │ │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 75)
    │ │ │     💬 Args: [a, t]
    │ │ │     👁️  Def: internal
    │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 76)
    │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
    │ │ │       👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 77)
    │ │ │   💬 Args: [a.settle(t), a._flow_rate + er]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 78)
    │ │ │     💬 Args: [a]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 79)
    │ │     💬 Args: [b1s.i._wrapped_particle]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperfluidPool._pdPoolIndexToPoolIndexData(struct PDPoolIndex) (NodeID: 80)
    │ │   💬 Args: [pdPoolIndex]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 81)
    │ │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units))]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 82)
    │ │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units)).toUint256()]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct PDPoolIndex) (NodeID: 83)
    │ │ │   💬 Args: [pdPoolIndex]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 84)
    │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate_per_unit(struct PDPoolIndex) (NodeID: 85)
    │ │ │   💬 Args: [pdPoolIndex]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 86)
    │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │     👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 87)
    │ │     💬 Args: [int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit()))]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SuperfluidPool._pdPoolMemberToMemberData(struct PDPoolMember,int256) (NodeID: 88)
    │ │   💬 Args: [pdPoolMember, claimedValue]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 89)
    │ │ │   💬 Args: [uint256(int256(Unit.unwrap(pdPoolMember.owned_units)))]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 90)
    │ │     💬 Args: [int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate))]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SuperfluidPool._handlePoolMemberNFT(address,uint128) (NodeID: 91)
    │     💬 Args: [memberAddr, newUnits]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SuperfluidPool._canCallNFTHook(contract ISuperfluidToken) (NodeID: 92)
    │       💬 Args: [superToken]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperfluidPool._updateMemberUnits(address,uint128) (NodeID: 94)
        💬 Args: [to, toUnitsBefore + amount.toUint128()]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 183)
      │   💬 Args: [amount]
      │   👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 95)
      │   💬 Args: [newUnits]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 96)
      │ │   💬 Args: [uint256(units)]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 97)
      │     💬 Args: [uint256(units).toInt256()]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 98)
      │   💬 Args: [_index]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 99)
      │ │   💬 Args: [data.totalUnits]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 100)
      │ │ │   💬 Args: [uint256(units)]
      │ │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 101)
      │ │     💬 Args: [uint256(units).toInt256()]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 102)
      │     💬 Args: [data]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 103)
      │   💬 Args: [memberData]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 104)
      │     💬 Args: [memberData.ownedUnits]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 105)
      │   │   💬 Args: [uint256(units)]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 106)
      │       💬 Args: [uint256(units).toInt256()]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperfluidPool._shiftDisconnectedUnits(Unit,Value,Time) (NodeID: 107)
      │   💬 Args: [wrappedUnits - mu.m.owned_units, Value.wrap(0), t]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 108)
      │ │   💬 Args: [_index]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 109)
      │ │ │   💬 Args: [data.totalUnits]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 110)
      │ │ │ │   💬 Args: [uint256(units)]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 111)
      │ │ │     💬 Args: [uint256(units).toInt256()]
      │ │ │     👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 112)
      │ │     💬 Args: [data]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SuperfluidPool._memberDataToPDPoolMember(struct SuperfluidPool.MemberData) (NodeID: 113)
      │ │   💬 Args: [_disconnectedMembers]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 114)
      │ │     💬 Args: [memberData.ownedUnits]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 115)
      │ │   │   💬 Args: [uint256(units)]
      │ │   │   👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 116)
      │ │       💬 Args: [uint256(units).toInt256()]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 117)
      │ │   💬 Args: [mu, t]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 118)
      │ │ │   💬 Args: [a.i, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 119)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 120)
      │ │ │ │     💬 Args: [a._wrapped_particle]
      │ │ │ │     👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 121)
      │ │ │     💬 Args: [m._wrapped_particle, t]
      │ │ │     👁️  Def: internal
      │ │ │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 122)
      │ │ │   │   💬 Args: [a]
      │ │ │   │   👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 123)
      │ │ │       💬 Args: [a, t]
      │ │ │       👁️  Def: internal
      │ │ │     └─ [8] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 124)
      │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │         👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 125)
      │ │ │   💬 Args: [a.m]
      │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 126)
      │ │ │     💬 Args: [a._synced_particle]
      │ │ │     👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 127)
      │ │     💬 Args: [a, t]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 128)
      │ │   │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
      │ │   │   👁️  Def: internal
      │ │   │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 130)
      │ │   │ │   💬 Args: [a.m._synced_particle]
      │ │   │ │   👁️  Def: internal
      │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 129)
      │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
      │ │   │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 131)
      │ │   │   💬 Args: [a.i._wrapped_particle, t]
      │ │   │   👁️  Def: internal
      │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 132)
      │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
      │ │   │     👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 133)
      │ │       💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
      │ │       👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SuperfluidPool._pdPoolMemberToMemberData(struct PDPoolMember,int256) (NodeID: 134)
      │     💬 Args: [mu.m, 0]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 135)
      │   │   💬 Args: [uint256(int256(Unit.unwrap(pdPoolMember.owned_units)))]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 136)
      │       💬 Args: [int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate))]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.pool_member_update(struct PDPoolMemberMU,struct BasicParticle,Unit,Time) (NodeID: 137)
      │   💬 Args: [mu, p, wrappedUnits, t]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolMemberMU,Time) (NodeID: 138)
      │ │   💬 Args: [b1, t]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 139)
      │ │ │   💬 Args: [a.i, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 140)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 141)
      │ │ │ │     💬 Args: [a._wrapped_particle]
      │ │ │ │     👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 142)
      │ │ │     💬 Args: [m._wrapped_particle, t]
      │ │ │     👁️  Def: internal
      │ │ │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 143)
      │ │ │   │   💬 Args: [a]
      │ │ │   │   👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 144)
      │ │ │       💬 Args: [a, t]
      │ │ │       👁️  Def: internal
      │ │ │     └─ [8] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 145)
      │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │         👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolMember) (NodeID: 146)
      │ │ │   💬 Args: [a.m]
      │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 147)
      │ │ │     💬 Args: [a._synced_particle]
      │ │ │     👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct PDPoolMemberMU,Time) (NodeID: 148)
      │ │     💬 Args: [a, t]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 149)
      │ │   │   💬 Args: [a.m._synced_particle, a.m._synced_particle.settled_at()]
      │ │   │   👁️  Def: internal
      │ │   │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 151)
      │ │   │ │   💬 Args: [a.m._synced_particle]
      │ │   │ │   👁️  Def: internal
      │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 150)
      │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
      │ │   │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 152)
      │ │   │   💬 Args: [a.i._wrapped_particle, t]
      │ │   │   👁️  Def: internal
      │ │   │ └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 153)
      │ │   │     💬 Args: [a._flow_rate, t - a._settled_at]
      │ │   │     👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 154)
      │ │       💬 Args: [(a.i._wrapped_particle.rtb(t) - a.m._synced_particle.rtb(a.m._synced_particle.settled_at())), a.m.owned_units]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul_quotrem(FlowRate,Unit,Unit) (NodeID: 155)
      │ │   💬 Args: [nr, oldTotalUnit, newTotalUnit]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 156)
      │ │ │   💬 Args: [r, u1]
      │ │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.quotrem(FlowRate,Unit) (NodeID: 157)
      │ │     💬 Args: [r.mul(u1), u2]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 158)
      │ │   │   💬 Args: [r, u]
      │ │   │   👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 159)
      │ │       💬 Args: [nr, u]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 160)
      │ │   💬 Args: [nr, oldTotalUnit]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 161)
      │ │   💬 Args: [b1s.i._wrapped_particle, nr]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 162)
      │ │     💬 Args: [a]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 163)
      │ │   💬 Args: [a, t]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 164)
      │ │ │   💬 Args: [a]
      │ │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 165)
      │ │     💬 Args: [a, t]
      │ │     👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 166)
      │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 167)
      │ │   💬 Args: [a.settle(t), a._flow_rate + er]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 168)
      │ │     💬 Args: [a]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 169)
      │     💬 Args: [b1s.i._wrapped_particle]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperfluidPool._pdPoolIndexToPoolIndexData(struct PDPoolIndex) (NodeID: 170)
      │   💬 Args: [pdPoolIndex]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 171)
      │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units))]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 172)
      │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units)).toUint256()]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct PDPoolIndex) (NodeID: 173)
      │ │   💬 Args: [pdPoolIndex]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 174)
      │ │     💬 Args: [a._wrapped_particle]
      │ │     👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate_per_unit(struct PDPoolIndex) (NodeID: 175)
      │ │   💬 Args: [pdPoolIndex]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 176)
      │ │     💬 Args: [a._wrapped_particle]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 177)
      │     💬 Args: [int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit()))]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SuperfluidPool._pdPoolMemberToMemberData(struct PDPoolMember,int256) (NodeID: 178)
      │   💬 Args: [pdPoolMember, claimedValue]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 179)
      │ │   💬 Args: [uint256(int256(Unit.unwrap(pdPoolMember.owned_units)))]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 180)
      │     💬 Args: [int256(FlowRate.unwrap(pdPoolMember._synced_particle._flow_rate))]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SuperfluidPool._handlePoolMemberNFT(address,uint128) (NodeID: 181)
          💬 Args: [memberAddr, newUnits]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SuperfluidPool._canCallNFTHook(contract ISuperfluidToken) (NodeID: 182)
            💬 Args: [superToken]
            👁️  Def: internal
```

## Documentation

### Function Documentation

@dev Transfers `amount` units from `msg.sender` to `to`

### Interface Documentation

 @dev Moves `amount` tokens from the caller's account to `to`.
 Returns a boolean value indicating whether the operation succeeded.
 Emits a {Transfer} event.
