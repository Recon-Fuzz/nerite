# Function: distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 17447:1843:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function distribute(ISuperfluidToken token, address from, ISuperfluidPool pool, uint256 requestedAmount, bytes calldata ctx) override external returns (bytes memory newCtx) {
    ISuperfluid.Context memory currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
    newCtx = ctx;
    if ((_isPool(token, address(pool)) == false) || (pool.superToken() != token)) {
        revert GDA_ONLY_SUPER_TOKEN_POOL();
    }
    if (!pool.distributionFromAnyAddress()) {
        if (pool.admin() != currentContext.msgSender) {
            revert GDA_DISTRIBUTE_FROM_ANY_ADDRESS_NOT_ALLOWED();
        }
    }
    if (from != currentContext.msgSender) {
        revert GDA_DISTRIBUTE_FOR_OTHERS_NOT_ALLOWED();
    }
    (, Value actualAmount) = _doDistributeViaPool(abi.encode(token), currentContext.msgSender, address(pool), Value.wrap(requestedAmount.toInt256()));
    if (token.isAccountCriticalNow(from)) {
        revert GDA_INSUFFICIENT_BALANCE();
    }
    emit InstantDistributionUpdated(token, pool, from, currentContext.msgSender, requestedAmount, uint256(Value.unwrap(actualAmount)), currentContext.userData);
}
```

## Related Implementations

### authorizeTokenAccess(contract ISuperfluidToken,bytes)

- **Kind**: internal
- **Source**: 963:468:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:authorizeTokenAccess(contract ISuperfluidToken,bytes)`

```solidity
///  @dev Authorize the msg.sender to access token agreement storage
///  NOTE:
///  - msg.sender must be the expected host contract.
///  - it should revert on unauthorized access.
function authorizeTokenAccess(ISuperfluidToken token, bytes memory ctx) internal view returns (ISuperfluid.Context memory) {
    require(token.getHost() == msg.sender, "unauthorized host");
    require(ISuperfluid(msg.sender).isCtxValid(ctx), "invalid ctx");
    return ISuperfluid(msg.sender).decodeCtx(ctx);
}
```

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
}
```

### _doDistributeViaPool(bytes,address,address,Value)

- **Kind**: internal
- **Source**: 2652:578:188
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/TokenMonad.sol:TokenMonad:_doDistributeViaPool(bytes,address,address,Value)`

```solidity
function _doDistributeViaPool(bytes memory eff, address from, address pool, Value reqAmount) internal returns (bytes memory, Value actualAmount) {
    assert(from != pool);
    BasicParticle memory a = _getUIndex(eff, from);
    PDPoolIndex memory c = _getPDPIndex(eff, pool);
    (a, c, actualAmount) = a.shift2b(c, reqAmount);
    eff = _setUIndex(eff, from, a);
    eff = _setPDPIndex(eff, pool, c);
    return (eff, actualAmount);
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

### _setPDPIndex(bytes,address,struct PDPoolIndex)

- **Kind**: internal
- **Source**: 36077:231:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_setPDPIndex(bytes,address,struct PDPoolIndex)`

```solidity
function _setPDPIndex(bytes memory eff, address pool, PDPoolIndex memory p) override internal returns (bytes memory) {
    assert(SuperfluidPool(pool).operatorSetIndex(p));
    return eff;
}
```

## External Calls

- **ISuperfluidPool::superToken()**
- **ISuperfluidPool::distributionFromAnyAddress()**
- **ISuperfluidPool::admin()**
- **ISuperfluidToken::isAccountCriticalNow(address)**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **SuperfluidPool::poolOperatorGetIndex()**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **SuperfluidPool::operatorSetIndex(struct PDPoolIndex)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 2)
  │   💬 Args: [token, address(pool)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TokenMonad._doDistributeViaPool(bytes,address,address,Value) (NodeID: 3)
      💬 Args: [abi.encode(token), currentContext.msgSender, address(pool), Value.wrap(requestedAmount.toInt256())]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 32)
    │   💬 Args: [requestedAmount]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 4)
    │   💬 Args: [eff, from]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 5)
    │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 6)
    │     💬 Args: [universalIndexData]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPDPIndex(bytes,address) (NodeID: 7)
    │   💬 Args: [eff, pool]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 8)
    │     💬 Args: [data]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 9)
    │   │   💬 Args: [data.totalUnits]
    │   │   👁️  Def: internal
    │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 10)
    │   │ │   💬 Args: [uint256(units)]
    │   │ │   👁️  Def: internal
    │   │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 11)
    │   │     💬 Args: [uint256(units).toInt256()]
    │   │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 12)
    │       💬 Args: [data]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.shift2b(struct BasicParticle,struct PDPoolIndex,Value) (NodeID: 13)
    │   💬 Args: [a, c, reqAmount]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.shift1(struct PDPoolIndex,Value) (NodeID: 14)
    │ │   💬 Args: [b, x]
    │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 15)
    │ │ │   💬 Args: [a]
    │ │ │   👁️  Def: internal
    │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 16)
    │ │ │     💬 Args: [a._wrapped_particle]
    │ │ │     👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(Value,Unit) (NodeID: 17)
    │ │ │   💬 Args: [x, a.total_units]
    │ │ │   👁️  Def: internal
    │ │ ├─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(Value,Unit) (NodeID: 18)
    │ │ │   💬 Args: [x.div(a.total_units), a.total_units]
    │ │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 19)
    │ │     💬 Args: [a._wrapped_particle, x1.div(a.total_units)]
    │ │     👁️  Def: internal
    │ │   ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(Value,Unit) (NodeID: 21)
    │ │   │   💬 Args: [x1, a.total_units]
    │ │   │   👁️  Def: internal
    │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 20)
    │ │       💬 Args: [a]
    │ │       👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 22)
    │     💬 Args: [a, -x1]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 23)
    │       💬 Args: [a]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 24)
    │   💬 Args: [eff, from, a]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 25)
    │ │   💬 Args: [eff, owner]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 26)
    │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 27)
    │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 28)
    │   │   💬 Args: [buffer]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 29)
    │   │   💬 Args: [p]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 30)
    │       💬 Args: [p]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setPDPIndex(bytes,address,struct PDPoolIndex) (NodeID: 31)
        💬 Args: [eff, pool, c]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
