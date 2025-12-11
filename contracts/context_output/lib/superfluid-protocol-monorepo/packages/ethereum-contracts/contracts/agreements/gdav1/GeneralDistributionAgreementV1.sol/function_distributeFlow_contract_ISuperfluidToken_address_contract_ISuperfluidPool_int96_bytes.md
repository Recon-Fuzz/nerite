# Function: distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)`
- **Visibility**: external
- **Source Range**: 19856:4615:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function distributeFlow(ISuperfluidToken token, address from, ISuperfluidPool pool, int96 requestedFlowRate, bytes calldata ctx) override external returns (bytes memory newCtx) {
    if ((_isPool(token, address(pool)) == false) || (pool.superToken() != token)) {
        revert GDA_ONLY_SUPER_TOKEN_POOL();
    }
    if (requestedFlowRate < 0) {
        revert GDA_NO_NEGATIVE_FLOW_RATE();
    }
    _StackVars_DistributeFlow memory flowVars;
    {
        flowVars.currentContext = AgreementLibrary.authorizeTokenAccess(token, ctx);
        flowVars.distributionFlowHash = _getFlowDistributionHash(from, pool);
        flowVars.oldFlowRate = _getFlowRate(abi.encode(token), flowVars.distributionFlowHash);
    }
    newCtx = ctx;
    if ((requestedFlowRate > 0) && (!pool.distributionFromAnyAddress())) {
        if (pool.admin() != flowVars.currentContext.msgSender) {
            revert GDA_DISTRIBUTE_FROM_ANY_ADDRESS_NOT_ALLOWED();
        }
    }
    (, FlowRate actualFlowRate, FlowRate newDistributionFlowRate) = _doDistributeFlowViaPool(abi.encode(token), from, address(pool), flowVars.distributionFlowHash, FlowRate.wrap(requestedFlowRate), Time.wrap(uint32(flowVars.currentContext.timestamp)));
    {
        if (from != flowVars.currentContext.msgSender) {
            if (requestedFlowRate > 0) {
                revert GDA_DISTRIBUTE_FOR_OTHERS_NOT_ALLOWED();
            } else {
                (int256 availableBalance, , ) = token.realtimeBalanceOf(from, flowVars.currentContext.timestamp);
                _StackVars_Liquidation memory liquidationData;
                {
                    liquidationData.token = token;
                    liquidationData.sender = from;
                    liquidationData.liquidator = flowVars.currentContext.msgSender;
                    liquidationData.distributionFlowHash = flowVars.distributionFlowHash;
                    liquidationData.signedTotalGDADeposit = _getUIndexData(abi.encode(token), from).totalBuffer.toInt256();
                    liquidationData.availableBalance = availableBalance;
                }
                if (availableBalance < 0) {
                    _makeLiquidationPayouts(liquidationData);
                } else {
                    revert GDA_NON_CRITICAL_SENDER();
                }
            }
        }
    }
    {
        _adjustBuffer(token, address(pool), from, flowVars.distributionFlowHash, actualFlowRate);
    }
    if (from == flowVars.currentContext.msgSender) {
        (int256 availableBalance, , ) = token.realtimeBalanceOf(from, flowVars.currentContext.timestamp);
        if ((requestedFlowRate > 0) && (availableBalance < 0)) {
            revert GDA_INSUFFICIENT_BALANCE();
        }
    }
    {
        (address adjustmentFlowRecipient, , int96 adjustmentFlowRate) = _getPoolAdjustmentFlowInfo(abi.encode(token), address(pool));
        emit FlowDistributionUpdated(token, pool, from, flowVars.currentContext.msgSender, int256(FlowRate.unwrap(flowVars.oldFlowRate)).toInt96(), int256(FlowRate.unwrap(actualFlowRate)).toInt96(), int256(FlowRate.unwrap(newDistributionFlowRate)).toInt96(), adjustmentFlowRecipient, adjustmentFlowRate, flowVars.currentContext.userData);
    }
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

### _getFlowDistributionHash(address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 30805:190:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getFlowDistributionHash(address,contract ISuperfluidPool)`

```solidity
function _getFlowDistributionHash(address from, ISuperfluidPool to) internal view returns (bytes32) {
    return keccak256(abi.encode(block.chainid, "distributionFlow", from, to));
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

### _doDistributeFlowViaPool(bytes,address,address,bytes32,FlowRate,Time)

- **Kind**: internal
- **Source**: 3459:2351:188
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/TokenMonad.sol:TokenMonad:_doDistributeFlowViaPool(bytes,address,address,bytes32,FlowRate,Time)`

```solidity
function _doDistributeFlowViaPool(bytes memory eff, address from, address pool, bytes32 flowHash, FlowRate reqFlowRate, Time t) internal returns (bytes memory, FlowRate newActualFlowRate, FlowRate newDistributionFlowRate) {
    assert(from != pool);
    BasicParticle memory a = _getUIndex(eff, from);
    BasicParticle memory b = _getUIndex(eff, pool);
    PDPoolIndex memory c = _getPDPIndex(eff, pool);
    DistributeFlowVars memory vars;
    vars.currentAdjustmentFlowRate = _getPoolAdjustmentFlowRate(eff, pool);
    {
        FlowRate oldFlowRate = _getFlowRate(eff, flowHash);
        FlowRate oldDistributionFlowRate = c.flow_rate();
        FlowRate shiftFlowRate = reqFlowRate - oldFlowRate;
        (b, c, newDistributionFlowRate) = b.shift_flow2b(c, shiftFlowRate + vars.currentAdjustmentFlowRate, t);
        assert(FlowRate.unwrap(newDistributionFlowRate) >= 0);
        newActualFlowRate = (oldFlowRate + (newDistributionFlowRate - oldDistributionFlowRate)) - vars.currentAdjustmentFlowRate;
        if (FlowRate.unwrap(newActualFlowRate) >= 0) {
            vars.newAdjustmentFlowRate = FlowRate.wrap(0);
        } else {
            vars.newAdjustmentFlowRate = -newActualFlowRate;
            newActualFlowRate = FlowRate.wrap(0);
        }
        vars.actualFlowRateDelta = newActualFlowRate - oldFlowRate;
        (a, b) = a.shift_flow2b(b, vars.actualFlowRateDelta, t);
    }
    eff = _setUIndex(eff, from, a);
    eff = _setUIndex(eff, pool, b);
    eff = _setPDPIndex(eff, pool, c);
    eff = _setFlowInfo(eff, flowHash, from, pool, newActualFlowRate, vars.actualFlowRateDelta);
    eff = _setPoolAdjustmentFlowRate(eff, pool, vars.newAdjustmentFlowRate, t);
    return (eff, newActualFlowRate, newDistributionFlowRate);
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

### flow_rate(struct BasicParticle)

- **Kind**: internal
- **Source**: 12672:112:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:flow_rate(struct BasicParticle)`

```solidity
function flow_rate(BasicParticle memory a) internal pure returns (FlowRate) {
    return a._flow_rate;
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

### _setPoolAdjustmentFlowRate(bytes,address,FlowRate,Time)

- **Kind**: internal
- **Source**: 38917:260:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_setPoolAdjustmentFlowRate(bytes,address,FlowRate,Time)`

```solidity
function _setPoolAdjustmentFlowRate(bytes memory eff, address pool, FlowRate flowRate, Time t) override internal returns (bytes memory) {
    return _setPoolAdjustmentFlowRate(eff, pool, false, flowRate, t);
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

### _makeLiquidationPayouts(struct GeneralDistributionAgreementV1._StackVars_Liquidation)

- **Kind**: internal
- **Source**: 25261:1757:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_makeLiquidationPayouts(struct GeneralDistributionAgreementV1._StackVars_Liquidation)`

```solidity
function _makeLiquidationPayouts(_StackVars_Liquidation memory data) internal {
    (, FlowDistributionData memory flowDistributionData) = _getFlowDistributionData(ISuperfluidToken(data.token), data.distributionFlowHash);
    int256 signedSingleDeposit = flowDistributionData.buffer.toInt256();
    bool isCurrentlyPatricianPeriod;
    {
        (uint256 liquidationPeriod, uint256 patricianPeriod) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), data.token);
        isCurrentlyPatricianPeriod = SolvencyHelperLibrary.isPatricianPeriod(data.availableBalance, data.signedTotalGDADeposit, liquidationPeriod, patricianPeriod);
    }
    int256 totalRewardLeft = data.availableBalance + data.signedTotalGDADeposit;
    if (totalRewardLeft >= 0) {
        int256 rewardAmount = (signedSingleDeposit * totalRewardLeft) / data.signedTotalGDADeposit;
        data.token.makeLiquidationPayoutsV2(data.distributionFlowHash, abi.encode(2, isCurrentlyPatricianPeriod ? 0 : 1), data.liquidator, isCurrentlyPatricianPeriod, data.sender, rewardAmount.toUint256(), rewardAmount * (-1));
    } else {
        int256 rewardAmount = signedSingleDeposit;
        data.token.makeLiquidationPayoutsV2(data.distributionFlowHash, abi.encode(2, 2), data.liquidator, false, data.sender, rewardAmount.toUint256(), totalRewardLeft * (-1));
    }
}
```

### decode3PsData(contract ISuperfluid,contract ISuperfluidToken)

- **Kind**: internal
- **Source**: 257:557:159
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SolvencyHelperLibrary.sol:SolvencyHelperLibrary:decode3PsData(contract ISuperfluid,contract ISuperfluidToken)`

```solidity
function decode3PsData(ISuperfluid host, ISuperfluidToken token) internal view returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    ISuperfluidGovernance gov = ISuperfluidGovernance(host.getGovernance());
    uint256 pppConfig = gov.getConfigAsUint256(host, token, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY);
    (liquidationPeriod, patricianPeriod) = SuperfluidGovernanceConfigs.decodePPPConfig(pppConfig);
}
```

### decodePPPConfig(uint256)

- **Kind**: internal
- **Source**: 11842:260:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:decodePPPConfig(uint256)`

```solidity
function decodePPPConfig(uint256 pppConfig) internal pure returns (uint256 liquidationPeriod, uint256 patricianPeriod) {
    liquidationPeriod = (pppConfig >> 32) & type(uint32).max;
    patricianPeriod = pppConfig & type(uint32).max;
}
```

### isPatricianPeriod(int256,int256,uint256,uint256)

- **Kind**: internal
- **Source**: 820:533:159
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/SolvencyHelperLibrary.sol:SolvencyHelperLibrary:isPatricianPeriod(int256,int256,uint256,uint256)`

```solidity
function isPatricianPeriod(int256 availableBalance, int256 signedTotalDeposit, uint256 liquidationPeriod, uint256 patricianPeriod) internal pure returns (bool) {
    if (signedTotalDeposit == 0) {
        return false;
    }
    int256 totalRewardLeft = availableBalance + signedTotalDeposit;
    int256 totalOutflowRate = signedTotalDeposit / int256(liquidationPeriod);
    return (totalRewardLeft / totalOutflowRate) > int256(liquidationPeriod - patricianPeriod);
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

### _adjustBuffer(contract ISuperfluidToken,address,address,bytes32,FlowRate)

- **Kind**: internal
- **Source**: 27024:2474:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_adjustBuffer(contract ISuperfluidToken,address,address,bytes32,FlowRate)`

```solidity
function _adjustBuffer(ISuperfluidToken token, address pool, address from, bytes32 flowHash, FlowRate newFlowRate) internal {
    ISuperfluidGovernance gov = ISuperfluidGovernance(ISuperfluid(_host).getGovernance());
    uint256 minimumDeposit = gov.getConfigAsUint256(ISuperfluid(msg.sender), ISuperfluidToken(token), SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
    (uint256 liquidationPeriod, ) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), ISuperfluidToken(token));
    (, FlowDistributionData memory flowDistributionData) = _getFlowDistributionData(ISuperfluidToken(token), flowHash);
    Value newBufferAmount = newFlowRate.mul(Time.wrap(uint32(liquidationPeriod)));
    if ((Value.unwrap(newBufferAmount).toUint256() < minimumDeposit) && (FlowRate.unwrap(newFlowRate) > 0)) {
        newBufferAmount = Value.wrap(minimumDeposit.toInt256());
    }
    Value bufferDelta = newBufferAmount - Value.wrap(uint256(flowDistributionData.buffer).toInt256());
    {
        bytes32[] memory data = _encodeFlowDistributionData(FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: uint256(Value.unwrap(newBufferAmount))}));
        ISuperfluidToken(token).updateAgreementData(flowHash, data);
    }
    UniversalIndexData memory universalIndexData = _getUIndexData(abi.encode(token), from);
    universalIndexData.totalBuffer = (universalIndexData.totalBuffer.toInt256() + Value.unwrap(bufferDelta)).toUint256();
    ISuperfluidToken(token).updateAgreementStateSlot(from, _UNIVERSAL_INDEX_STATE_SLOT_ID, _encodeUniversalIndexData(universalIndexData));
    {
        emit BufferAdjusted(ISuperfluidToken(token), ISuperfluidPool(pool), from, Value.unwrap(bufferDelta), Value.unwrap(newBufferAmount).toUint256(), universalIndexData.totalBuffer);
    }
}
```

### _encodeUniversalIndexData(struct GeneralDistributionAgreementV1.UniversalIndexData)

- **Kind**: internal
- **Source**: 32738:484:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_encodeUniversalIndexData(struct GeneralDistributionAgreementV1.UniversalIndexData)`

```solidity
function _encodeUniversalIndexData(UniversalIndexData memory uIndexData) internal pure returns (bytes32[] memory data) {
    data = new bytes32[](2);
    data[0] = bytes32((((uint256(int256(uIndexData.flowRate)) << 160) | (uint256(uIndexData.settledAt) << 128)) | (uint256(uIndexData.totalBuffer.toUint96()) << 32)) | (uIndexData.isPool ? 1 : 0));
    data[1] = bytes32(uint256(uIndexData.settledValue));
}
```

## External Calls

- **ISuperfluidPool::superToken()**
- **ISuperfluidPool::distributionFromAnyAddress()**
- **ISuperfluidPool::admin()**
- **ISuperfluidToken::realtimeBalanceOf(address,uint256)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**
- **SuperfluidPool::poolOperatorGetIndex()**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **SuperfluidPool::operatorSetIndex(struct PDPoolIndex)**
- **ISuperfluidToken::updateAgreementData(bytes32,bytes32[])**
- **ISuperfluidToken::makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)**
- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)
- **SUPERTOKEN_MINIMUM_DEPOSIT_KEY** (`bytes32`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [token, address(pool)]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 2)
  │   💬 Args: [token, ctx]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionHash(address,contract ISuperfluidPool) (NodeID: 3)
  │   💬 Args: [from, pool]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 4)
  │   💬 Args: [abi.encode(token), flowVars.distributionFlowHash]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 5)
  │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 6)
  │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │       👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: TokenMonad._doDistributeFlowViaPool(bytes,address,address,bytes32,FlowRate,Time) (NodeID: 7)
  │   💬 Args: [abi.encode(token), from, address(pool), flowVars.distributionFlowHash, FlowRate.wrap(requestedFlowRate), Time.wrap(uint32(flowVars.currentContext.timestamp))]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 8)
  │ │   💬 Args: [eff, from]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 9)
  │ │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 10)
  │ │     💬 Args: [universalIndexData]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 11)
  │ │   💬 Args: [eff, pool]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 12)
  │ │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 13)
  │ │     💬 Args: [universalIndexData]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPDPIndex(bytes,address) (NodeID: 14)
  │ │   💬 Args: [eff, pool]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: Unknown.poolIndexDataToPDPoolIndex(struct SuperfluidPool.PoolIndexData) (NodeID: 15)
  │ │     💬 Args: [data]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: Unknown.toSemanticMoneyUnit(uint128) (NodeID: 16)
  │ │   │   💬 Args: [data.totalUnits]
  │ │   │   👁️  Def: internal
  │ │   │ ├─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 17)
  │ │   │ │   💬 Args: [uint256(units)]
  │ │   │ │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt128(int256) (NodeID: 18)
  │ │   │     💬 Args: [uint256(units).toInt256()]
  │ │   │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: Unknown.poolIndexDataToWrappedParticle(struct SuperfluidPool.PoolIndexData) (NodeID: 19)
  │ │       💬 Args: [data]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowRate(bytes,address) (NodeID: 20)
  │ │   💬 Args: [eff, pool]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowInfo(bytes,address) (NodeID: 21)
  │ │     💬 Args: [eff, pool]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 22)
  │ │   │   💬 Args: [pool, adjustmentRecipient]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 23)
  │ │   │   💬 Args: [eff, flowHash]
  │ │   │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 24)
  │ │   │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 25)
  │ │   │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 26)
  │ │       💬 Args: [int256(FlowRate.unwrap(_getFlowRate(eff, flowHash)))]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 27)
  │ │   💬 Args: [eff, flowHash]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 28)
  │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 29)
  │ │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct PDPoolIndex) (NodeID: 30)
  │ │   💬 Args: [c]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 31)
  │ │     💬 Args: [a._wrapped_particle._flow_rate, a.total_units]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.shift_flow2b(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 32)
  │ │   💬 Args: [b, c, shiftFlowRate + vars.currentAdjustmentFlowRate, t]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct PDPoolIndex) (NodeID: 33)
  │ │ │   💬 Args: [b]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 34)
  │ │ │     💬 Args: [a._wrapped_particle._flow_rate, a.total_units]
  │ │ │     👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 35)
  │ │ │   💬 Args: [mempty, b, -r, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 36)
  │ │ │ │   💬 Args: [b, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 37)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 38)
  │ │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 39)
  │ │ │ │     💬 Args: [m._wrapped_particle, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 40)
  │ │ │ │   │   💬 Args: [a]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 41)
  │ │ │ │       💬 Args: [a, t]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 42)
  │ │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │         👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct PDPoolIndex,FlowRate) (NodeID: 43)
  │ │ │ │   💬 Args: [b.settle(t), r]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 44)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 45)
  │ │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 46)
  │ │ │ │ │   💬 Args: [r, a.total_units]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 47)
  │ │ │ │ │   💬 Args: [r.div(a.total_units), a.total_units]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 48)
  │ │ │ │     💬 Args: [m._wrapped_particle, r1.div(a.total_units)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 50)
  │ │ │ │   │   💬 Args: [r1, a.total_units]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 49)
  │ │ │ │       💬 Args: [a]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 51)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 52)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 53)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 54)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 55)
  │ │ │     💬 Args: [a.settle(t), -r1]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 56)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct PDPoolIndex,FlowRate,Time) (NodeID: 57)
  │ │ │   💬 Args: [mempty, b, r + dr, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct PDPoolIndex,Time) (NodeID: 58)
  │ │ │ │   💬 Args: [b, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 59)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 60)
  │ │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 61)
  │ │ │ │     💬 Args: [m._wrapped_particle, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 62)
  │ │ │ │   │   💬 Args: [a]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 63)
  │ │ │ │       💬 Args: [a, t]
  │ │ │ │       👁️  Def: internal
  │ │ │ │     └─ [7] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 64)
  │ │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │         👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct PDPoolIndex,FlowRate) (NodeID: 65)
  │ │ │ │   💬 Args: [b.settle(t), r]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct PDPoolIndex) (NodeID: 66)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ │ └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 67)
  │ │ │ │ │     💬 Args: [a._wrapped_particle]
  │ │ │ │ │     👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 68)
  │ │ │ │ │   💬 Args: [r, a.total_units]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Unit) (NodeID: 69)
  │ │ │ │ │   💬 Args: [r.div(a.total_units), a.total_units]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 70)
  │ │ │ │     💬 Args: [m._wrapped_particle, r1.div(a.total_units)]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   ├─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.div(FlowRate,Unit) (NodeID: 72)
  │ │ │ │   │   💬 Args: [r1, a.total_units]
  │ │ │ │   │   👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 71)
  │ │ │ │       💬 Args: [a]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 73)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 74)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 75)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 76)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 77)
  │ │ │     💬 Args: [a.settle(t), -r1]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 78)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 79)
  │ │ │   💬 Args: [a, a1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 80)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 81)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 82)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 83)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 84)
  │ │ │     💬 Args: [b, t]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 85)
  │ │ │   │   💬 Args: [a]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 86)
  │ │ │       💬 Args: [a, t]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 87)
  │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │         👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 88)
  │ │     💬 Args: [a.mappend(a1), a2]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 89)
  │ │   │   💬 Args: [a, t]
  │ │   │   👁️  Def: internal
  │ │   │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 90)
  │ │   │ │   💬 Args: [a]
  │ │   │ │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 91)
  │ │   │     💬 Args: [a, t]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 92)
  │ │   │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 93)
  │ │       💬 Args: [b, t]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 94)
  │ │     │   💬 Args: [a]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 95)
  │ │         💬 Args: [a, t]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 96)
  │ │           💬 Args: [a._flow_rate, t - a._settled_at]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SemanticMoney.shift_flow2b(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 97)
  │ │   💬 Args: [a, b, vars.actualFlowRateDelta, t]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 98)
  │ │ │   💬 Args: [b]
  │ │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 99)
  │ │ │   💬 Args: [mempty, b, -r, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 100)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 101)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 102)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 103)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 104)
  │ │ │ │   💬 Args: [a.settle(t), -r]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 105)
  │ │ │ │     💬 Args: [a]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 106)
  │ │ │ │   💬 Args: [b, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 107)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 108)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 109)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 110)
  │ │ │     💬 Args: [b.settle(t), r]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 111)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 112)
  │ │ │   💬 Args: [mempty, b, r + dr, t]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 113)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 114)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 115)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 116)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 117)
  │ │ │ │   💬 Args: [a.settle(t), -r]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 118)
  │ │ │ │     💬 Args: [a]
  │ │ │ │     👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 119)
  │ │ │ │   💬 Args: [b, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 120)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 121)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 122)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 123)
  │ │ │     💬 Args: [b.settle(t), r]
  │ │ │     👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 124)
  │ │ │       💬 Args: [a]
  │ │ │       👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 125)
  │ │ │   💬 Args: [a, a1]
  │ │ │   👁️  Def: internal
  │ │ │ ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 126)
  │ │ │ │   💬 Args: [a, t]
  │ │ │ │   👁️  Def: internal
  │ │ │ │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 127)
  │ │ │ │ │   💬 Args: [a]
  │ │ │ │ │   👁️  Def: internal
  │ │ │ │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 128)
  │ │ │ │     💬 Args: [a, t]
  │ │ │ │     👁️  Def: internal
  │ │ │ │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 129)
  │ │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │ │       👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 130)
  │ │ │     💬 Args: [b, t]
  │ │ │     👁️  Def: internal
  │ │ │   ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 131)
  │ │ │   │   💬 Args: [a]
  │ │ │   │   👁️  Def: internal
  │ │ │   └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 132)
  │ │ │       💬 Args: [a, t]
  │ │ │       👁️  Def: internal
  │ │ │     └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 133)
  │ │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │ │ │         👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 134)
  │ │     💬 Args: [a.mappend(a1), a2]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 135)
  │ │   │   💬 Args: [a, t]
  │ │   │   👁️  Def: internal
  │ │   │ ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 136)
  │ │   │ │   💬 Args: [a]
  │ │   │ │   👁️  Def: internal
  │ │   │ └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 137)
  │ │   │     💬 Args: [a, t]
  │ │   │     👁️  Def: internal
  │ │   │   └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 138)
  │ │   │       💬 Args: [a._flow_rate, t - a._settled_at]
  │ │   │       👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 139)
  │ │       💬 Args: [b, t]
  │ │       👁️  Def: internal
  │ │     ├─ [5] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 140)
  │ │     │   💬 Args: [a]
  │ │     │   👁️  Def: internal
  │ │     └─ [5] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 141)
  │ │         💬 Args: [a, t]
  │ │         👁️  Def: internal
  │ │       └─ [6] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 142)
  │ │           💬 Args: [a._flow_rate, t - a._settled_at]
  │ │           👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 143)
  │ │   💬 Args: [eff, from, a]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 144)
  │ │ │   💬 Args: [eff, owner]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 145)
  │ │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 146)
  │ │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 147)
  │ │   │   💬 Args: [buffer]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 148)
  │ │   │   💬 Args: [p]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 149)
  │ │       💬 Args: [p]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 150)
  │ │   💬 Args: [eff, pool, b]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 151)
  │ │ │   💬 Args: [eff, owner]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 152)
  │ │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 153)
  │ │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
  │ │     👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 154)
  │ │   │   💬 Args: [buffer]
  │ │   │   👁️  Def: internal
  │ │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 155)
  │ │   │   💬 Args: [p]
  │ │   │   👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 156)
  │ │       💬 Args: [p]
  │ │       👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setPDPIndex(bytes,address,struct PDPoolIndex) (NodeID: 157)
  │ │   💬 Args: [eff, pool, c]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setFlowInfo(bytes,bytes32,address,address,FlowRate,FlowRate) (NodeID: 158)
  │ │   💬 Args: [eff, flowHash, from, pool, newActualFlowRate, vars.actualFlowRateDelta]
  │ │   👁️  Def: internal
  │ │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 159)
  │ │ │   💬 Args: [ISuperfluidToken(token), flowHash]
  │ │ │   👁️  Def: internal
  │ │ │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 160)
  │ │ │     💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │ │     👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData) (NodeID: 161)
  │ │     💬 Args: [FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: flowDistributionData.buffer})]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 162)
  │ │       💬 Args: [int256(FlowRate.unwrap(newFlowRate))]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setPoolAdjustmentFlowRate(bytes,address,FlowRate,Time) (NodeID: 163)
  │     💬 Args: [eff, pool, vars.newAdjustmentFlowRate, t]
  │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setPoolAdjustmentFlowRate(bytes,address,bool,FlowRate,Time) (NodeID: 164)
  │       💬 Args: [eff, pool, false, flowRate, t]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 165)
  │     │   💬 Args: [pool, adjustmentRecipient]
  │     │   👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 166)
  │     │   💬 Args: [eff, adjustmentFlowHash]
  │     │   👁️  Def: internal
  │     │ └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 167)
  │     │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │     │     👁️  Def: internal
  │     │   └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 168)
  │     │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │     │       👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: TokenMonad._doFlow(bytes,address,address,bytes32,FlowRate,Time) (NodeID: 169)
  │         💬 Args: [eff, pool, adjustmentRecipient, adjustmentFlowHash, flowRate, t]
  │         👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 170)
  │       │   💬 Args: [eff, flowHash]
  │       │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 171)
  │       │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │       │     👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 172)
  │       │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 173)
  │       │   💬 Args: [eff, from]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 174)
  │       │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 175)
  │       │     💬 Args: [universalIndexData]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 176)
  │       │   💬 Args: [eff, to]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 177)
  │       │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │       │ │   👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 178)
  │       │     💬 Args: [universalIndexData]
  │       │     👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: SemanticMoney.shift_flow2b(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 179)
  │       │   💬 Args: [a, b, flowRateDelta, t]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 180)
  │       │ │   💬 Args: [b]
  │       │ │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 181)
  │       │ │   💬 Args: [mempty, b, -r, t]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 182)
  │       │ │ │   💬 Args: [a, t]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 183)
  │       │ │ │ │   💬 Args: [a]
  │       │ │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 184)
  │       │ │ │     💬 Args: [a, t]
  │       │ │ │     👁️  Def: internal
  │       │ │ │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 185)
  │       │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │ │       👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 186)
  │       │ │ │   💬 Args: [a.settle(t), -r]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 187)
  │       │ │ │     💬 Args: [a]
  │       │ │ │     👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 188)
  │       │ │ │   💬 Args: [b, t]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 189)
  │       │ │ │ │   💬 Args: [a]
  │       │ │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 190)
  │       │ │ │     💬 Args: [a, t]
  │       │ │ │     👁️  Def: internal
  │       │ │ │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 191)
  │       │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │ │       👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 192)
  │       │ │     💬 Args: [b.settle(t), r]
  │       │ │     👁️  Def: internal
  │       │ │   └─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 193)
  │       │ │       💬 Args: [a]
  │       │ │       👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.flow2(struct BasicParticle,struct BasicParticle,FlowRate,Time) (NodeID: 194)
  │       │ │   💬 Args: [mempty, b, r + dr, t]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 195)
  │       │ │ │   💬 Args: [a, t]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 196)
  │       │ │ │ │   💬 Args: [a]
  │       │ │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 197)
  │       │ │ │     💬 Args: [a, t]
  │       │ │ │     👁️  Def: internal
  │       │ │ │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 198)
  │       │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │ │       👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 199)
  │       │ │ │   💬 Args: [a.settle(t), -r]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 200)
  │       │ │ │     💬 Args: [a]
  │       │ │ │     👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 201)
  │       │ │ │   💬 Args: [b, t]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 202)
  │       │ │ │ │   💬 Args: [a]
  │       │ │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 203)
  │       │ │ │     💬 Args: [a, t]
  │       │ │ │     👁️  Def: internal
  │       │ │ │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 204)
  │       │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │ │       👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.flow1(struct BasicParticle,FlowRate) (NodeID: 205)
  │       │ │     💬 Args: [b.settle(t), r]
  │       │ │     👁️  Def: internal
  │       │ │   └─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 206)
  │       │ │       💬 Args: [a]
  │       │ │       👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 207)
  │       │ │   💬 Args: [a, a1]
  │       │ │   👁️  Def: internal
  │       │ │ ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 208)
  │       │ │ │   💬 Args: [a, t]
  │       │ │ │   👁️  Def: internal
  │       │ │ │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 209)
  │       │ │ │ │   💬 Args: [a]
  │       │ │ │ │   👁️  Def: internal
  │       │ │ │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 210)
  │       │ │ │     💬 Args: [a, t]
  │       │ │ │     👁️  Def: internal
  │       │ │ │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 211)
  │       │ │ │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │ │       👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 212)
  │       │ │     💬 Args: [b, t]
  │       │ │     👁️  Def: internal
  │       │ │   ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 213)
  │       │ │   │   💬 Args: [a]
  │       │ │   │   👁️  Def: internal
  │       │ │   └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 214)
  │       │ │       💬 Args: [a, t]
  │       │ │       👁️  Def: internal
  │       │ │     └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 215)
  │       │ │         💬 Args: [a._flow_rate, t - a._settled_at]
  │       │ │         👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: SemanticMoney.mappend(struct BasicParticle,struct BasicParticle) (NodeID: 216)
  │       │     💬 Args: [a.mappend(a1), a2]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 217)
  │       │   │   💬 Args: [a, t]
  │       │   │   👁️  Def: internal
  │       │   │ ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 218)
  │       │   │ │   💬 Args: [a]
  │       │   │ │   👁️  Def: internal
  │       │   │ └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 219)
  │       │   │     💬 Args: [a, t]
  │       │   │     👁️  Def: internal
  │       │   │   └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 220)
  │       │   │       💬 Args: [a._flow_rate, t - a._settled_at]
  │       │   │       👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: SemanticMoney.settle(struct BasicParticle,Time) (NodeID: 221)
  │       │       💬 Args: [b, t]
  │       │       👁️  Def: internal
  │       │     ├─ [8] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 222)
  │       │     │   💬 Args: [a]
  │       │     │   👁️  Def: internal
  │       │     └─ [8] ⚙️ FUNCTION: SemanticMoney.rtb(struct BasicParticle,Time) (NodeID: 223)
  │       │         💬 Args: [a, t]
  │       │         👁️  Def: internal
  │       │       └─ [9] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 224)
  │       │           💬 Args: [a._flow_rate, t - a._settled_at]
  │       │           👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 225)
  │       │   💬 Args: [eff, from, a]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 226)
  │       │ │   💬 Args: [eff, owner]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 227)
  │       │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 228)
  │       │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 229)
  │       │   │   💬 Args: [buffer]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 230)
  │       │   │   💬 Args: [p]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 231)
  │       │       💬 Args: [p]
  │       │       👁️  Def: internal
  │       ├─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 232)
  │       │   💬 Args: [eff, to, b]
  │       │   👁️  Def: internal
  │       │ ├─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 233)
  │       │ │   💬 Args: [eff, owner]
  │       │ │   👁️  Def: internal
  │       │ │ └─ [7] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 234)
  │       │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │       │ │     👁️  Def: internal
  │       │ └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 235)
  │       │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
  │       │     👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 236)
  │       │   │   💬 Args: [buffer]
  │       │   │   👁️  Def: internal
  │       │   ├─ [7] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 237)
  │       │   │   💬 Args: [p]
  │       │   │   👁️  Def: internal
  │       │   └─ [7] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 238)
  │       │       💬 Args: [p]
  │       │       👁️  Def: internal
  │       └─ [5] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setFlowInfo(bytes,bytes32,address,address,FlowRate,FlowRate) (NodeID: 239)
  │           💬 Args: [eff, flowHash, from, to, flowRate, flowRateDelta]
  │           👁️  Def: internal
  │         ├─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 240)
  │         │   💬 Args: [ISuperfluidToken(token), flowHash]
  │         │   👁️  Def: internal
  │         │ └─ [7] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 241)
  │         │     💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │         │     👁️  Def: internal
  │         └─ [6] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData) (NodeID: 242)
  │             💬 Args: [FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: flowDistributionData.buffer})]
  │             👁️  Def: internal
  │           └─ [7] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 243)
  │               💬 Args: [int256(FlowRate.unwrap(newFlowRate))]
  │               👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 244)
  │   💬 Args: [abi.encode(token), from]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 245)
  │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 246)
  │   💬 Args: [_getUIndexData(abi.encode(token), from).totalBuffer]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._makeLiquidationPayouts(struct GeneralDistributionAgreementV1._StackVars_Liquidation) (NodeID: 247)
  │   💬 Args: [liquidationData]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 248)
  │ │   💬 Args: [ISuperfluidToken(data.token), data.distributionFlowHash]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 249)
  │ │     💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 250)
  │ │   💬 Args: [flowDistributionData.buffer]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 251)
  │ │   💬 Args: [ISuperfluid(_host), data.token]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 252)
  │ │     💬 Args: [pppConfig]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.isPatricianPeriod(int256,int256,uint256,uint256) (NodeID: 253)
  │ │   💬 Args: [data.availableBalance, data.signedTotalGDADeposit, liquidationPeriod, patricianPeriod]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 254)
  │ │   💬 Args: [rewardAmount]
  │ │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 255)
  │     💬 Args: [rewardAmount]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._adjustBuffer(contract ISuperfluidToken,address,address,bytes32,FlowRate) (NodeID: 256)
  │   💬 Args: [token, address(pool), from, flowVars.distributionFlowHash, actualFlowRate]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 257)
  │ │   💬 Args: [ISuperfluid(_host), ISuperfluidToken(token)]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 258)
  │ │     💬 Args: [pppConfig]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 259)
  │ │   💬 Args: [ISuperfluidToken(token), flowHash]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 260)
  │ │     💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: AdditionalMonetaryTypeHelpers.mul(FlowRate,Time) (NodeID: 261)
  │ │   💬 Args: [newFlowRate, Time.wrap(uint32(liquidationPeriod))]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 262)
  │ │   💬 Args: [Value.unwrap(newBufferAmount)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 263)
  │ │   💬 Args: [minimumDeposit]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 264)
  │ │   💬 Args: [uint256(flowDistributionData.buffer)]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeFlowDistributionData(struct GeneralDistributionAgreementV1.FlowDistributionData) (NodeID: 265)
  │ │   💬 Args: [FlowDistributionData({lastUpdated: uint32(block.timestamp), flowRate: int256(FlowRate.unwrap(newFlowRate)).toInt96(), buffer: uint256(Value.unwrap(newBufferAmount))})]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 266)
  │ │     💬 Args: [int256(FlowRate.unwrap(newFlowRate))]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 267)
  │ │   💬 Args: [abi.encode(token), from]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 268)
  │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
  │ │     👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 269)
  │ │   💬 Args: [universalIndexData.totalBuffer]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 270)
  │ │   💬 Args: [(universalIndexData.totalBuffer.toInt256() + Value.unwrap(bufferDelta))]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 271)
  │ │   💬 Args: [universalIndexData]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 272)
  │ │     💬 Args: [uIndexData.totalBuffer]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toUint256(int256) (NodeID: 273)
  │     💬 Args: [Value.unwrap(newBufferAmount)]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowInfo(bytes,address) (NodeID: 274)
  │   💬 Args: [abi.encode(token), address(pool)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdjustmentFlowHash(address,address) (NodeID: 275)
  │ │   💬 Args: [pool, adjustmentRecipient]
  │ │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowRate(bytes,bytes32) (NodeID: 276)
  │ │   💬 Args: [eff, flowHash]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 277)
  │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))), distributionFlowHash]
  │ │     👁️  Def: internal
  │ │   └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 278)
  │ │       💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
  │ │       👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 279)
  │     💬 Args: [int256(FlowRate.unwrap(_getFlowRate(eff, flowHash)))]
  │     👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 280)
  │   💬 Args: [int256(FlowRate.unwrap(flowVars.oldFlowRate))]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 281)
  │   💬 Args: [int256(FlowRate.unwrap(actualFlowRate))]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SafeCast.toInt96(int256) (NodeID: 282)
      💬 Args: [int256(FlowRate.unwrap(newDistributionFlowRate))]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
