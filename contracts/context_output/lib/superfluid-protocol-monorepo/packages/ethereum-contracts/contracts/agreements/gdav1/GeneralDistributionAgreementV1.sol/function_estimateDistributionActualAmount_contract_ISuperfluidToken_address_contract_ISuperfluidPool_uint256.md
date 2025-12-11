# Function: estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)`
- **Visibility**: external
- **Source Range**: 10445:538:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function estimateDistributionActualAmount(ISuperfluidToken token, address from, ISuperfluidPool to, uint256 requestedAmount) override external view returns (uint256 actualAmount) {
    bytes memory eff = abi.encode(token);
    Value actualDistributionAmount;
    (, , actualDistributionAmount) = _getUIndex(eff, from).shift2b(_getPDPIndex("", address(to)), Value.wrap(requestedAmount.toInt256()));
    actualAmount = uint256(Value.unwrap(actualDistributionAmount));
}
```

## Related Implementations

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

### shift2b(struct BasicParticle,struct PDPoolIndex,Value)

- **Kind**: internal
- **Source**: 20132:228:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift2b(struct BasicParticle,struct PDPoolIndex,Value)`

```solidity
function shift2b(BasicParticle memory a, PDPoolIndex memory b, Value x) internal pure returns (BasicParticle memory m, PDPoolIndex memory n, Value x1) {
    (n, x1) = b.shift1(x);
    m = a.shift1(-x1);
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

### shift1(struct PDPoolIndex,Value)

- **Kind**: internal
- **Source**: 15151:344:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift1(struct PDPoolIndex,Value)`

```solidity
function shift1(PDPoolIndex memory a, Value x) internal pure returns (PDPoolIndex memory m, Value x1) {
    m = a.clone();
    if (Unit.unwrap(a.total_units) != 0) {
        x1 = x.div(a.total_units).mul(a.total_units);
        m._wrapped_particle = a._wrapped_particle.shift1(x1.div(a.total_units));
    }
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

### div(Value,Unit)

- **Kind**: internal
- **Source**: 8367:128:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:AdditionalMonetaryTypeHelpers:div(Value,Unit)`

```solidity
function div(Value a, Unit b) internal pure returns (Value) {
    return Value.wrap(Value.unwrap(a) / Unit.unwrap(b));
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

### shift1(struct BasicParticle,Value)

- **Kind**: internal
- **Source**: 13022:175:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift1(struct BasicParticle,Value)`

```solidity
function shift1(BasicParticle memory a, Value x) internal pure returns (BasicParticle memory b) {
    b = a.clone();
    b._settled_value = b._settled_value + x;
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **SuperfluidPool::poolOperatorGetIndex()**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 1)
  │   💬 Args: [eff, from]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 2)
  │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 3)
  │     💬 Args: [universalIndexData]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SemanticMoney.shift2b(struct BasicParticle,struct PDPoolIndex,Value) (NodeID: 4)
      💬 Args: [_getUIndex(eff, from), _getPDPIndex("", address(to)), Value.wrap(requestedAmount.toInt256())]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPDPIndex(bytes,address) (NodeID: 15)
    │   💬 Args: ["", address(to)]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 16)
    │     💬 Args: [data]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 17)
    │   │   💬 Args: [data.totalUnits]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 18)
    │   │ │   💬 Args: [uint256(units)]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 19)
    │   │     💬 Args: [uint256(units).toInt256()]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 20)
    │       💬 Args: [data]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 21)
    │   💬 Args: [requestedAmount]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.shift1(struct PDPoolIndex,Value) (NodeID: 5)
    │   💬 Args: [b, x]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 6)
    │ │   💬 Args: [a]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 7)
    │ │     💬 Args: [a._wrapped_particle]
    │ │     👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(Value,Unit) (NodeID: 8)
    │ │   💬 Args: [x, a.total_units]
    │ │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 9)
    │ │   💬 Args: [x.div(a.total_units), a.total_units]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 10)
    │     💬 Args: [a._wrapped_particle, x1.div(a.total_units)]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(Value,Unit) (NodeID: 12)
    │   │   💬 Args: [x1, a.total_units]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 11)
    │       💬 Args: [a]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 13)
        💬 Args: [a, -x1]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 14)
          💬 Args: [a]
          👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
