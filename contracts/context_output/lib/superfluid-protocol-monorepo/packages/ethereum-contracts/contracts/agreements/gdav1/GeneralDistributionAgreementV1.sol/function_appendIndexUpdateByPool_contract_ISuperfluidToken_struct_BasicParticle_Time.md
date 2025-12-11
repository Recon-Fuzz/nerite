# Function: appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time)`
- **Visibility**: external
- **Source Range**: 16518:465:123

## Implementation

```solidity
function appendIndexUpdateByPool(ISuperfluidToken token, BasicParticle memory p, Time t) external returns (bool) {
    if (_isPool(token, msg.sender) == false) {
        revert GDA_ONLY_SUPER_TOKEN_POOL();
    }
    bytes memory eff = abi.encode(token);
    _setUIndex(eff, msg.sender, _getUIndex(eff, msg.sender).mappend(p));
    _setPoolAdjustmentFlowRate(eff, msg.sender, true, p.flow_rate(), t);
    return true;
}
```

## Related Implementations

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
}
```

### _setUIndex(bytes,address,struct BasicParticle)

- **Kind**: internal
- **Source**: 35270:511:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_setUIndex(bytes,address,struct BasicParticle)`

```solidity
function _setUIndex(bytes memory eff, address owner, BasicParticle memory p) override internal returns (bytes memory) {
    UniversalIndexData memory universalIndexData = _getUIndexData(eff, owner);
    ISuperfluidToken(abi.decode(eff, (address))).updateAgreementStateSlot(owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, _encodeUniversalIndexData(p, universalIndexData.totalBuffer, universalIndexData.isPool));
    return eff;
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

### _getUIndexData(bytes,address)

- **Kind**: internal
- **Source**: 33971:398:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getUIndexData(bytes,address)`

```solidity
function _getUIndexData(bytes memory eff, address owner) internal view returns (UniversalIndexData memory universalIndexData) {
    (, universalIndexData) = _decodeUniversalIndexData(ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2));
}
```

### _encodeUniversalIndexData(struct BasicParticle,uint256,bool)

- **Kind**: internal
- **Source**: 32233:499:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_encodeUniversalIndexData(struct BasicParticle,uint256,bool)`

```solidity
function _encodeUniversalIndexData(BasicParticle memory p, uint256 buffer, bool isPool_) internal pure returns (bytes32[] memory data) {
    data = new bytes32[](2);
    data[0] = bytes32((((uint256(int256(FlowRate.unwrap(p.flow_rate()))) << 160) | (uint256(Time.unwrap(p.settled_at())) << 128)) | (uint256(buffer.toUint96()) << 32)) | (isPool_ ? 1 : 0));
    data[1] = bytes32(uint256(Value.unwrap(p._settled_value)));
}
```

### toUint96(uint256)

- **Kind**: internal
- **Source**: 11168:187:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toUint96(uint256)`

```solidity
///  @dev Returns the downcasted uint96 from uint256, reverting on
///  overflow (when the input is greater than largest uint96).
///  Counterpart to Solidity's `uint96` operator.
///  Requirements:
///  - input must fit into 96 bits
///  _Available since v4.2._
function toUint96(uint256 value) internal pure returns (uint96) {
    require(value <= type(uint96).max, "SafeCast: value doesn't fit in 96 bits");
    return uint96(value);
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

### flow_rate(struct BasicParticle)

- **Kind**: internal
- **Source**: 12672:112:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow_rate(struct BasicParticle)`

```solidity
function flow_rate(BasicParticle memory a) internal pure returns (FlowRate) {
    return a._flow_rate;
}
```

### _setPoolAdjustmentFlowRate(bytes,address,bool,FlowRate,Time)

- **Kind**: internal
- **Source**: 39183:596:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_setPoolAdjustmentFlowRate(bytes,address,bool,FlowRate,Time)`

```solidity
function _setPoolAdjustmentFlowRate(bytes memory eff, address pool, bool doShiftFlow, FlowRate flowRate, Time t) internal returns (bytes memory) {
    address adjustmentRecipient = ISuperfluidPool(pool).admin();
    bytes32 adjustmentFlowHash = _getPoolAdjustmentFlowHash(pool, adjustmentRecipient);
    if (doShiftFlow) {
        flowRate = flowRate + _getFlowRate(eff, adjustmentFlowHash);
    }
    eff = _doFlow(eff, pool, adjustmentRecipient, adjustmentFlowHash, flowRate, t);
    return eff;
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

### _doFlow(bytes,address,address,bytes32,FlowRate,Time)

- **Kind**: internal
- **Source**: 1978:668:188
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/TokenMonad.sol:TokenMonad:_doFlow(bytes,address,address,bytes32,FlowRate,Time)`

```solidity
function _doFlow(bytes memory eff, address from, address to, bytes32 flowHash, FlowRate flowRate, Time t) internal returns (bytes memory) {
    if (from == to) return eff;
    FlowRate flowRateDelta = flowRate - _getFlowRate(eff, flowHash);
    BasicParticle memory a = _getUIndex(eff, from);
    BasicParticle memory b = _getUIndex(eff, to);
    (a, b) = a.shift_flow2b(b, flowRateDelta, t);
    eff = _setUIndex(eff, from, a);
    eff = _setUIndex(eff, to, b);
    eff = _setFlowInfo(eff, flowHash, from, to, flowRate, flowRateDelta);
    return eff;
}
```

### shift_flow2b(struct BasicParticle,struct BasicParticle,FlowRate,Time)

- **Kind**: internal
- **Source**: 19042:448:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift_flow2b(struct BasicParticle,struct BasicParticle,FlowRate,Time)`

```solidity
function shift_flow2b(BasicParticle memory a, BasicParticle memory b, FlowRate dr, Time t) internal pure returns (BasicParticle memory m, BasicParticle memory n) {
    BasicParticle memory mempty;
    BasicParticle memory a1;
    BasicParticle memory a2;
    FlowRate r = b.flow_rate();
    (a1, ) = mempty.flow2(b, -r, t);
    (a2, n) = mempty.flow2(b, r + dr, t);
    m = a.mappend(a1).mappend(a2);
}
```

### flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time)

- **Kind**: internal
- **Source**: 18794:242:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time)`

```solidity
function flow2(BasicParticle memory a, BasicParticle memory b, FlowRate r, Time t) internal pure returns (BasicParticle memory m, BasicParticle memory n) {
    m = a.settle(t).flow1(-r);
    n = b.settle(t).flow1(r);
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

### _setFlowInfo(bytes,bytes32,address,address,FlowRate,FlowRate)

- **Kind**: internal
- **Source**: 36637:844:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_setFlowInfo(bytes,bytes32,address,address,FlowRate,FlowRate)`

```solidity
function _setFlowInfo(bytes memory eff, bytes32 flowHash, address, address, FlowRate newFlowRate, FlowRate) override internal returns (bytes memory) {
    address token = abi.decode(eff, (address));
    (, FlowDistributionData memory flowDistributionData) = _getFlowDistributionData(ISuperfluidToken(token), flowHash);
    ISuperfluidToken(token).updateAgreementData(flowHash, _encodeFlowDistributionData(FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: flowDistributionData.buffer})));
    return eff;
}
```

### _encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData)

- **Kind**: internal
- **Source**: 40783:422:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData)`

```solidity
function _encodeFlowDistributionData(FlowDistributionData memory flowDistributionData) internal pure returns (bytes32[] memory data) {
    data = new bytes32[](1);
    data[0] = bytes32(((uint256(uint32(flowDistributionData.lastUpdated)) << 192) | (uint256(uint96(flowDistributionData.flowRate)) << 96)) | uint256(flowDistributionData.buffer));
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

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **ISuperfluidPool::admin()**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [token, msg.sender]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 2)
  │   💬 Args: [eff, msg.sender, _getUIndex(eff, msg.sender).mappend(p)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 9)
  │ │   💬 Args: [eff, msg.sender]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 10)
  │ │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 11)
  │ │     💬 Args: [universalIndexData]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 12)
  │ │   💬 Args: [_getUIndex(eff, msg.sender), p]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 13)
  │ │ │   💬 Args: [a, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 14)
  │ │ │ │   💬 Args: [a]
  │ │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 15)
  │ │ │     💬 Args: [a, t]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 16)
  │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │       👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 17)
  │ │     💬 Args: [b, t]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 18)
  │ │   │   💬 Args: [a]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 19)
  │ │       💬 Args: [a, t]
  │ │       👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 20)
  │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │         👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 3)
  │ │   💬 Args: [eff, owner]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 4)
  │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 5)
  │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 6)
  │   │   💬 Args: [buffer]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 7)
  │   │   💬 Args: [p]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 8)
  │       💬 Args: [p]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setPoolAdjustmentFlowRate(bytes,address,bool,FlowRate,Time) (NodeID: 21)
      💬 Args: [eff, msg.sender, true, p.flow_rate(), t]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 101)
    │   💬 Args: [p]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 22)
    │   💬 Args: [pool, adjustmentRecipient]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 23)
    │   💬 Args: [eff, adjustmentFlowHash]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 24)
    │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 25)
    │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: TokenMonad._doFlow(bytes,address,address,bytes32,FlowRate,Time) (NodeID: 26)
        💬 Args: [eff, pool, adjustmentRecipient, adjustmentFlowHash, flowRate, t]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 27)
      │   💬 Args: [eff, flowHash]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 28)
      │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
      │     👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 29)
      │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 30)
      │   💬 Args: [eff, from]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 31)
      │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 32)
      │     💬 Args: [universalIndexData]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 33)
      │   💬 Args: [eff, to]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 34)
      │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │ │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 35)
      │     💬 Args: [universalIndexData]
      │     👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: SemanticMoney.shift_flow2b(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 36)
      │   💬 Args: [a, b, flowRateDelta, t]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 37)
      │ │   💬 Args: [b]
      │ │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 38)
      │ │   💬 Args: [mempty, b, -r, t]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 39)
      │ │ │   💬 Args: [a, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 40)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 41)
      │ │ │     💬 Args: [a, t]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 42)
      │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │       👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 43)
      │ │ │   💬 Args: [a.settle(t), -r]
      │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 44)
      │ │ │     💬 Args: [a]
      │ │ │     👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 45)
      │ │ │   💬 Args: [b, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 46)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 47)
      │ │ │     💬 Args: [a, t]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 48)
      │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │       👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 49)
      │ │     💬 Args: [b.settle(t), r]
      │ │     👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 50)
      │ │       💬 Args: [a]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 51)
      │ │   💬 Args: [mempty, b, r + dr, t]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 52)
      │ │ │   💬 Args: [a, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 53)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 54)
      │ │ │     💬 Args: [a, t]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 55)
      │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │       👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 56)
      │ │ │   💬 Args: [a.settle(t), -r]
      │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 57)
      │ │ │     💬 Args: [a]
      │ │ │     👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 58)
      │ │ │   💬 Args: [b, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 59)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 60)
      │ │ │     💬 Args: [a, t]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 61)
      │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │       👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 62)
      │ │     💬 Args: [b.settle(t), r]
      │ │     👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 63)
      │ │       💬 Args: [a]
      │ │       👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 64)
      │ │   💬 Args: [a, a1]
      │ │   👁️  Def: internal
      │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 65)
      │ │ │   💬 Args: [a, t]
      │ │ │   👁️  Def: internal
      │ │ │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 66)
      │ │ │ │   💬 Args: [a]
      │ │ │ │   👁️  Def: internal
      │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 67)
      │ │ │     💬 Args: [a, t]
      │ │ │     👁️  Def: internal
      │ │ │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 68)
      │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
      │ │ │       👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 69)
      │ │     💬 Args: [b, t]
      │ │     👁️  Def: internal
      │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 70)
      │ │   │   💬 Args: [a]
      │ │   │   👁️  Def: internal
      │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 71)
      │ │       💬 Args: [a, t]
      │ │       👁️  Def: internal
      │ │     └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 72)
      │ │         💬 Args: [a._flow_rate, t - a._settled_at]
      │ │         👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 73)
      │     💬 Args: [a.mappend(a1), a2]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 74)
      │   │   💬 Args: [a, t]
      │   │   👁️  Def: internal
      │   │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 75)
      │   │ │   💬 Args: [a]
      │   │ │   👁️  Def: internal
      │   │ └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 76)
      │   │     💬 Args: [a, t]
      │   │     👁️  Def: internal
      │   │   └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 77)
      │   │       💬 Args: [a._flow_rate, t - a._settled_at]
      │   │       👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 78)
      │       💬 Args: [b, t]
      │       👁️  Def: internal
      │     ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 79)
      │     │   💬 Args: [a]
      │     │   👁️  Def: internal
      │     └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 80)
      │         💬 Args: [a, t]
      │         👁️  Def: internal
      │       └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 81)
      │           💬 Args: [a._flow_rate, t - a._settled_at]
      │           👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 82)
      │   💬 Args: [eff, from, a]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 83)
      │ │   💬 Args: [eff, owner]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 84)
      │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 85)
      │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 86)
      │   │   💬 Args: [buffer]
      │   │   👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 87)
      │   │   💬 Args: [p]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 88)
      │       💬 Args: [p]
      │       👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 89)
      │   💬 Args: [eff, to, b]
      │   👁️  Def: internal
      │ ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 90)
      │ │   💬 Args: [eff, owner]
      │ │   👁️  Def: internal
      │ │ └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 91)
      │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │ │     👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 92)
      │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
      │     👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 93)
      │   │   💬 Args: [buffer]
      │   │   👁️  Def: internal
      │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 94)
      │   │   💬 Args: [p]
      │   │   👁️  Def: internal
      │   └─ [5] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 95)
      │       💬 Args: [p]
      │       👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setFlowInfo(bytes,bytes32,address,address,FlowRate,FlowRate) (NodeID: 96)
          💬 Args: [eff, flowHash, from, to, flowRate, flowRateDelta]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 97)
        │   💬 Args: [ISuperfluidToken(token), flowHash]
        │   👁️  Def: internal
        │ └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 98)
        │     💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
        │     👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData) (NodeID: 99)
            💬 Args: [FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: flowDistributionData.buffer})]
            👁️  Def: internal
          └─ [5] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 100)
              💬 Args: [int256(FlowRate.unwrap(newFlowRate))]
              👁️  Def: internal
```
