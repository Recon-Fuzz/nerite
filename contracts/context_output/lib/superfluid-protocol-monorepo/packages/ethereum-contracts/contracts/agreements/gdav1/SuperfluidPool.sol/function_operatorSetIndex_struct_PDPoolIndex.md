# Function: operatorSetIndex(struct PDPoolIndex)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol/contract_SuperfluidPool.md]

## Metadata

- **Contract**: SuperfluidPool
- **Signature**: `operatorSetIndex(struct PDPoolIndex)`
- **Visibility**: external
- **Source Range**: 19844:168:127

## Implementation

```solidity
function operatorSetIndex(PDPoolIndex calldata index) external onlyGDA() returns (bool) {
    _index = _pdPoolIndexToPoolIndexData(index);
    return true;
}
```

## Related Implementations

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

### settled_at(struct PDPoolIndex)

- **Kind**: internal
- **Source**: 14467:127:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:settled_at(struct PDPoolIndex)`

```solidity
function settled_at(PDPoolIndex memory a) internal pure returns (Time) {
    return a._wrapped_particle.settled_at();
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

### onlyGDA()

- **Kind**: modifier
- **Source**: 21290:111:127
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol:SuperfluidPool:onlyGDA()`

```solidity
modifier onlyGDA() {
    if (msg.sender != address(GDA)) revert SUPERFLUID_POOL_NOT_GDA();
    _;
}
```

## State Variable Reads

- **GDA** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## State Variable Writes

- **_index** (`struct SuperfluidPool.PoolIndexData`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidPool.operatorSetIndex(struct PDPoolIndex) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPool._pdPoolIndexToPoolIndexData(struct PDPoolIndex) (NodeID: 1)
  │   💬 Args: [index]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 2)
  │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units))]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint128(uint256) (NodeID: 3)
  │ │   💬 Args: [int256(Unit.unwrap(pdPoolIndex.total_units)).toUint256()]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.settled_at(struct PDPoolIndex) (NodeID: 4)
  │ │   💬 Args: [pdPoolIndex]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 5)
  │ │     💬 Args: [a._wrapped_particle]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow_rate_per_unit(struct PDPoolIndex) (NodeID: 6)
  │ │   💬 Args: [pdPoolIndex]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 7)
  │ │     💬 Args: [a._wrapped_particle]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 8)
  │     💬 Args: [int256(FlowRate.unwrap(pdPoolIndex.flow_rate_per_unit()))]
  │     👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidPool.onlyGDA() (NodeID: 9)
      💬 Args: [no args]
```
