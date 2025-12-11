# Function: estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)`
- **Visibility**: external
- **Source Range**: 8874:1513:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function estimateFlowDistributionActualFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to, int96 requestedFlowRate) override external view returns (int96 actualFlowRate, int96 totalDistributionFlowRate) {
    bytes memory eff = abi.encode(token);
    bytes32 distributionFlowHash = _getFlowDistributionHash(from, to);
    BasicParticle memory fromUIndexData = _getUIndex(eff, from);
    PDPoolIndex memory pdpIndex = _getPDPIndex("", address(to));
    FlowRate oldFlowRate = _getFlowRate(eff, distributionFlowHash);
    FlowRate newActualFlowRate;
    FlowRate oldDistributionFlowRate = pdpIndex.flow_rate();
    FlowRate newDistributionFlowRate;
    FlowRate flowRateDelta = FlowRate.wrap(requestedFlowRate) - oldFlowRate;
    FlowRate currentAdjustmentFlowRate = _getPoolAdjustmentFlowRate(eff, address(to));
    Time t = Time.wrap(uint32(block.timestamp));
    (fromUIndexData, pdpIndex, newDistributionFlowRate) = fromUIndexData.shift_flow2b(pdpIndex, flowRateDelta + currentAdjustmentFlowRate, t);
    newActualFlowRate = (oldFlowRate + (newDistributionFlowRate - oldDistributionFlowRate)) - currentAdjustmentFlowRate;
    actualFlowRate = int256(FlowRate.unwrap(newActualFlowRate)).toInt96();
    totalDistributionFlowRate = int256(FlowRate.unwrap(newDistributionFlowRate)).toInt96();
    if (actualFlowRate < 0) {
        actualFlowRate = 0;
    }
}
```

## Related Implementations

### _getFlowDistributionHash(address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 30805:190:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getFlowDistributionHash(address,contract ISuperfluidPool)`

```solidity
function _getFlowDistributionHash(address from, ISuperfluidPool to) internal view returns (bytes32) {
    return keccak256(abi.encode(block.chainid, "distributionFlow", from, to));
}
```

### _getUIndex(bytes,address)

- **Kind**: internal
- **Source**: 34814:450:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getUIndex(bytes,address)`

```solidity
function _getUIndex(bytes memory eff, address owner) override internal view returns (BasicParticle memory uIndex) {
    (, UniversalIndexData memory universalIndexData) = _decodeUniversalIndexData(ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2));
    uIndex = _getBasicParticleFromUIndex(universalIndexData);
}
```

### _decodeUniversalIndexData(bytes32[])

- **Kind**: internal
- **Source**: 33228:737:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_decodeUniversalIndexData(bytes32[])`

```solidity
function _decodeUniversalIndexData(bytes32[] memory data) internal pure returns (bool exists, UniversalIndexData memory universalIndexData) {
    uint256 a = uint256(data[0]);
    uint256 b = uint256(data[1]);
    exists = (a > 0) || (b > 0);
    if (exists) {
        universalIndexData.flowRate = int96(int256(a >> 160) & int256(uint256(type(uint96).max)));
        universalIndexData.settledAt = uint32(uint256(a >> 128) & uint256(type(uint32).max));
        universalIndexData.totalBuffer = uint256(a >> 32) & uint256(type(uint96).max);
        universalIndexData.isPool = (((a << 224) >> 224) & 1) == 1;
        universalIndexData.settledValue = int256(b);
    }
}
```

### _getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData)

- **Kind**: internal
- **Source**: 34375:397:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData)`

```solidity
function _getBasicParticleFromUIndex(UniversalIndexData memory universalIndexData) internal pure returns (BasicParticle memory particle) {
    particle._flow_rate = FlowRate.wrap(universalIndexData.flowRate);
    particle._settled_at = Time.wrap(universalIndexData.settledAt);
    particle._settled_value = Value.wrap(universalIndexData.settledValue);
}
```

### _getPDPIndex(bytes,address)

- **Kind**: internal
- **Source**: 35787:284:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPDPIndex(bytes,address)`

```solidity
function _getPDPIndex(bytes memory, address pool) override internal view returns (PDPoolIndex memory) {
    SuperfluidPool.PoolIndexData memory data = SuperfluidPool(pool).poolOperatorGetIndex();
    return poolIndexDataToPDPoolIndex(data);
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

### _getFlowRate(bytes,bytes32)

- **Kind**: internal
- **Source**: 36314:317:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getFlowRate(bytes,bytes32)`

```solidity
function _getFlowRate(bytes memory eff, bytes32 distributionFlowHash) override internal view returns (FlowRate) {
    (, FlowDistributionData memory data) = _getFlowDistributionData(ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash);
    return FlowRate.wrap(data.flowRate);
}
```

### _getFlowDistributionData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 41698:365:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getFlowDistributionData(contract ISuperfluidToken,bytes32)`

```solidity
function _getFlowDistributionData(ISuperfluidToken token, bytes32 distributionFlowHash) internal view returns (bool exist, FlowDistributionData memory flowDistributionData) {
    (exist, flowDistributionData) = _decodeFlowDistributionData(uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0]));
}
```

### _decodeFlowDistributionData(uint256)

- **Kind**: internal
- **Source**: 41211:481:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_decodeFlowDistributionData(uint256)`

```solidity
function _decodeFlowDistributionData(uint256 data) internal pure returns (bool exist, FlowDistributionData memory flowDistributionData) {
    exist = data > 0;
    if (exist) {
        flowDistributionData.lastUpdated = uint32((data >> 192) & uint256(type(uint32).max));
        flowDistributionData.flowRate = int96(int256(data >> 96));
        flowDistributionData.buffer = uint96(data & uint256(type(uint96).max));
    }
}
```

### flow_rate(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 14854:147:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow_rate(struct PDPoolIndex)`

```solidity
function flow_rate(PDPoolIndex memory a) internal pure returns (FlowRate) {
    return a._wrapped_particle._flow_rate.mul(a.total_units);
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

### _getPoolAdjustmentFlowRate(bytes,address)

- **Kind**: internal
- **Source**: 38318:320:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolAdjustmentFlowRate(bytes,address)`

```solidity
function _getPoolAdjustmentFlowRate(bytes memory eff, address pool) override internal view returns (FlowRate flowRate) {
    (, , int96 rawFlowRate) = _getPoolAdjustmentFlowInfo(eff, pool);
    flowRate = FlowRate.wrap(int128(rawFlowRate));
}
```

### _getPoolAdjustmentFlowInfo(bytes,address)

- **Kind**: internal
- **Source**: 37819:493:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolAdjustmentFlowInfo(bytes,address)`

```solidity
function _getPoolAdjustmentFlowInfo(bytes memory eff, address pool) internal view returns (address adjustmentRecipient, bytes32 flowHash, int96 flowRate) {
    adjustmentRecipient = ISuperfluidPool(pool).admin();
    flowHash = _getPoolAdjustmentFlowHash(pool, adjustmentRecipient);
    return (adjustmentRecipient, flowHash, int256(FlowRate.unwrap(_getFlowRate(eff, flowHash))).toInt96());
}
```

### _getPoolAdjustmentFlowHash(address,address)

- **Kind**: internal
- **Source**: 31001:254:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolAdjustmentFlowHash(address,address)`

```solidity
function _getPoolAdjustmentFlowHash(address from, address to) internal view returns (bytes32) {
    return keccak256(abi.encode(block.chainid, "poolAdjustmentFlow", from, to));
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

### shift_flow2b(struct BasicParticle,struct PDPoolIndex,FlowRate,Time)

- **Kind**: internal
- **Source**: 20630:465:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift_flow2b(struct BasicParticle,struct PDPoolIndex,FlowRate,Time)`

```solidity
function shift_flow2b(BasicParticle memory a, PDPoolIndex memory b, FlowRate dr, Time t) internal pure returns (BasicParticle memory m, PDPoolIndex memory n, FlowRate r1) {
    BasicParticle memory mempty;
    BasicParticle memory a1;
    BasicParticle memory a2;
    FlowRate r = b.flow_rate();
    (a1, , ) = mempty.flow2(b, -r, t);
    (a2, n, r1) = mempty.flow2(b, r + dr, t);
    m = a.mappend(a1).mappend(a2);
}
```

### flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time)

- **Kind**: internal
- **Source**: 20366:258:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time)`

```solidity
function flow2(BasicParticle memory a, PDPoolIndex memory b, FlowRate r, Time t) internal pure returns (BasicParticle memory m, PDPoolIndex memory n, FlowRate r1) {
    (n, r1) = b.settle(t).flow1(r);
    m = a.settle(t).flow1(-r1);
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

### flow1(struct PDPoolIndex,FlowRate)

- **Kind**: internal
- **Source**: 15501:348:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow1(struct PDPoolIndex,FlowRate)`

```solidity
function flow1(PDPoolIndex memory a, FlowRate r) internal pure returns (PDPoolIndex memory m, FlowRate r1) {
    m = a.clone();
    if (Unit.unwrap(a.total_units) != 0) {
        r1 = r.div(a.total_units).mul(a.total_units);
        m._wrapped_particle = m._wrapped_particle.flow1(r1.div(a.total_units));
    }
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

### mappend(struct BasicParticle,struct BasicParticle)

- **Kind**: internal
- **Source**: 13578:574:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:mappend(struct BasicParticle,struct BasicParticle)`

```solidity
/// Monoid binary operator for basic particle/universal index.
function mappend(BasicParticle memory a, BasicParticle memory b) internal pure returns (BasicParticle memory c) {
    Time t = (Time.unwrap(a._settled_at) > Time.unwrap(b._settled_at)) ? a._settled_at : b._settled_at;
    BasicParticle memory a1 = a.settle(t);
    BasicParticle memory b1 = b.settle(t);
    c._settled_at = t;
    c._settled_value = a1._settled_value + b1._settled_value;
    c._flow_rate = a1._flow_rate + b1._flow_rate;
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **SuperfluidPool::poolOperatorGetIndex()**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidPool::admin()**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionHash(address,contract ISuperfluidPool) (NodeID: 1)
  │   💬 Args: [from, to]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 2)
  │   💬 Args: [eff, from]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 3)
  │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 4)
  │     💬 Args: [universalIndexData]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPDPIndex(bytes,address) (NodeID: 5)
  │   💬 Args: ["", address(to)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 6)
  │     💬 Args: [data]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 7)
  │   │   💬 Args: [data.totalUnits]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
  │   │ │   💬 Args: [uint256(units)]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 9)
  │   │     💬 Args: [uint256(units).toInt256()]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 10)
  │       💬 Args: [data]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 11)
  │   💬 Args: [eff, distributionFlowHash]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 12)
  │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 13)
  │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct PDPoolIndex) (NodeID: 14)
  │   💬 Args: [pdpIndex]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 15)
  │     💬 Args: [a._wrapped_particle._flow_rate, a.total_units]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowRate(bytes,address) (NodeID: 16)
  │   💬 Args: [eff, address(to)]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowInfo(bytes,address) (NodeID: 17)
  │     💬 Args: [eff, pool]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 18)
  │   │   💬 Args: [pool, adjustmentRecipient]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 19)
  │   │   💬 Args: [eff, flowHash]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 20)
  │   │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 21)
  │   │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 22)
  │       💬 Args: [int256(FlowRate.unwrap(_getFlowRate(eff, flowHash)))]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SemanticMoney.shift_flow2b(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 23)
  │   💬 Args: [fromUIndexData, pdpIndex, flowRateDelta + currentAdjustmentFlowRate, t]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct PDPoolIndex) (NodeID: 24)
  │ │   💬 Args: [b]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 25)
  │ │     💬 Args: [a._wrapped_particle._flow_rate, a.total_units]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 26)
  │ │   💬 Args: [mempty, b, -r, t]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 27)
  │ │ │   💬 Args: [b, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 28)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 29)
  │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 30)
  │ │ │     💬 Args: [m._wrapped_particle, t]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 31)
  │ │ │   │   💬 Args: [a]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 32)
  │ │ │       💬 Args: [a, t]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 33)
  │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow1(struct PDPoolIndex,FlowRate) (NodeID: 34)
  │ │ │   💬 Args: [b.settle(t), r]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 35)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 36)
  │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 37)
  │ │ │ │   💬 Args: [r, a.total_units]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 38)
  │ │ │ │   💬 Args: [r.div(a.total_units), a.total_units]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 39)
  │ │ │     💬 Args: [m._wrapped_particle, r1.div(a.total_units)]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 41)
  │ │ │   │   💬 Args: [r1, a.total_units]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 40)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 42)
  │ │ │   💬 Args: [a, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 43)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 44)
  │ │ │     💬 Args: [a, t]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 45)
  │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 46)
  │ │     💬 Args: [a.settle(t), -r1]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 47)
  │ │       💬 Args: [a]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 48)
  │ │   💬 Args: [mempty, b, r + dr, t]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 49)
  │ │ │   💬 Args: [b, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 50)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 51)
  │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │     👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 52)
  │ │ │     💬 Args: [m._wrapped_particle, t]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 53)
  │ │ │   │   💬 Args: [a]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 54)
  │ │ │       💬 Args: [a, t]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 55)
  │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │         👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow1(struct PDPoolIndex,FlowRate) (NodeID: 56)
  │ │ │   💬 Args: [b.settle(t), r]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 57)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 58)
  │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 59)
  │ │ │ │   💬 Args: [r, a.total_units]
  │ │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 60)
  │ │ │ │   💬 Args: [r.div(a.total_units), a.total_units]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 61)
  │ │ │     💬 Args: [m._wrapped_particle, r1.div(a.total_units)]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 63)
  │ │ │   │   💬 Args: [r1, a.total_units]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 62)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 64)
  │ │ │   💬 Args: [a, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 65)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 66)
  │ │ │     💬 Args: [a, t]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 67)
  │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 68)
  │ │     💬 Args: [a.settle(t), -r1]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 69)
  │ │       💬 Args: [a]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 70)
  │ │   💬 Args: [a, a1]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 71)
  │ │ │   💬 Args: [a, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 72)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 73)
  │ │ │     💬 Args: [a, t]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 74)
  │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 75)
  │ │     💬 Args: [b, t]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 76)
  │ │   │   💬 Args: [a]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 77)
  │ │       💬 Args: [a, t]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 78)
  │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │         👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 79)
  │     💬 Args: [a.mappend(a1), a2]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 80)
  │   │   💬 Args: [a, t]
  │   │   👁️  Def: internal
  │   │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 81)
  │   │ │   💬 Args: [a]
  │   │ │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 82)
  │   │     💬 Args: [a, t]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 83)
  │   │       💬 Args: [a._flow_rate, t - a._settled_at]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 84)
  │       💬 Args: [b, t]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 85)
  │     │   💬 Args: [a]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 86)
  │         💬 Args: [a, t]
  │         👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 87)
  │           💬 Args: [a._flow_rate, t - a._settled_at]
  │           👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 88)
  │   💬 Args: [int256(FlowRate.unwrap(newActualFlowRate))]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 89)
      💬 Args: [int256(FlowRate.unwrap(newDistributionFlowRate))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
