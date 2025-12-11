# Function: getPoolAdjustmentFlowRate(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `getPoolAdjustmentFlowRate(address)`
- **Visibility**: external
- **Source Range**: 38644:267:123

## Implementation

```solidity
function getPoolAdjustmentFlowRate(address pool) override external view returns (int96) {
    ISuperfluidToken token = ISuperfluidPool(pool).superToken();
    return int256(FlowRate.unwrap(_getPoolAdjustmentFlowRate(abi.encode(token), pool))).toInt96();
}
```

## Related Implementations

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

- **ISuperfluidPool::superToken()**
- **ISuperfluidPool::admin()**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.getPoolAdjustmentFlowRate(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowRate(bytes,address) (NodeID: 1)
  │   💬 Args: [abi.encode(token), pool]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowInfo(bytes,address) (NodeID: 2)
  │     💬 Args: [eff, pool]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 3)
  │   │   💬 Args: [pool, adjustmentRecipient]
  │   │   👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 4)
  │   │   💬 Args: [eff, flowHash]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 5)
  │   │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │   │     👁️  Def: internal
  │   │   └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 6)
  │   │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │   │       👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 7)
  │       💬 Args: [int256(FlowRate.unwrap(_getFlowRate(eff, flowHash)))]
  │       👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 8)
      💬 Args: [int256(FlowRate.unwrap(_getPoolAdjustmentFlowRate(abi.encode(token), pool)))]
      👁️  Def: internal
```
