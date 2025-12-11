# Function: poolSettleClaim(contract ISuperfluidToken,address,int256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `poolSettleClaim(contract ISuperfluidToken,address,int256)`
- **Visibility**: external
- **Source Range**: 16989:400:123

## Implementation

```solidity
function poolSettleClaim(ISuperfluidToken superToken, address claimRecipient, int256 amount) external returns (bool) {
    if (_isPool(superToken, msg.sender) == false) {
        revert GDA_ONLY_SUPER_TOKEN_POOL();
    }
    _doShift(abi.encode(superToken), msg.sender, claimRecipient, Value.wrap(amount));
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

### _doShift(bytes,address,address,Value)

- **Kind**: internal
- **Source**: 1543:429:188
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/TokenMonad.sol:TokenMonad:_doShift(bytes,address,address,Value)`

```solidity
function _doShift(bytes memory eff, address from, address to, Value amount) internal returns (bytes memory) {
    if (from == to) return eff;
    BasicParticle memory a = _getUIndex(eff, from);
    BasicParticle memory b = _getUIndex(eff, to);
    (a, b) = a.shift2(b, amount);
    eff = _setUIndex(eff, from, a);
    eff = _setUIndex(eff, to, b);
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

### shift2(struct BasicParticle,struct BasicParticle,Value)

- **Kind**: internal
- **Source**: 18574:214:187
- **Link**: `lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol:SemanticMoney:shift2(struct BasicParticle,struct BasicParticle,Value)`

```solidity
function shift2(BasicParticle memory a, BasicParticle memory b, Value x) internal pure returns (BasicParticle memory m, BasicParticle memory n) {
    m = a.shift1(-x);
    n = b.shift1(x);
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

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.poolSettleClaim(contract ISuperfluidToken,address,int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 1)
  │   💬 Args: [superToken, msg.sender]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: TokenMonad._doShift(bytes,address,address,Value) (NodeID: 2)
      💬 Args: [abi.encode(superToken), msg.sender, claimRecipient, Value.wrap(amount)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 3)
    │   💬 Args: [eff, from]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 4)
    │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 5)
    │     💬 Args: [universalIndexData]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndex(bytes,address) (NodeID: 6)
    │   💬 Args: [eff, to]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 7)
    │ │   💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │ │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getBasicParticleFromUIndex(struct GeneralDistributionAgreementV1.UniversalIndexData) (NodeID: 8)
    │     💬 Args: [universalIndexData]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SemanticMoney.shift2(struct BasicParticle,struct BasicParticle,Value) (NodeID: 9)
    │   💬 Args: [a, b, amount]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 10)
    │ │   💬 Args: [a, -x]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 11)
    │ │     💬 Args: [a]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SemanticMoney.shift1(struct BasicParticle,Value) (NodeID: 12)
    │     💬 Args: [b, x]
    │     👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.clone(struct BasicParticle) (NodeID: 13)
    │       💬 Args: [a]
    │       👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 14)
    │   💬 Args: [eff, from, a]
    │   👁️  Def: internal
    │ ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 15)
    │ │   💬 Args: [eff, owner]
    │ │   👁️  Def: internal
    │ │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 16)
    │ │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
    │ │     👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 17)
    │     💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 18)
    │   │   💬 Args: [buffer]
    │   │   👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 19)
    │   │   💬 Args: [p]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 20)
    │       💬 Args: [p]
    │       👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._setUIndex(bytes,address,struct BasicParticle) (NodeID: 21)
        💬 Args: [eff, to, b]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 22)
      │   💬 Args: [eff, owner]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 23)
      │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._encodeUniversalIndexData(struct BasicParticle,uint256,bool) (NodeID: 24)
          💬 Args: [p, universalIndexData.totalBuffer, universalIndexData.isPool]
          👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SafeCast.toUint96(uint256) (NodeID: 25)
        │   💬 Args: [buffer]
        │   👁️  Def: internal
        ├─ [4] ⚙️ FUNCTION: SemanticMoney.settled_at(struct BasicParticle) (NodeID: 26)
        │   💬 Args: [p]
        │   👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: SemanticMoney.flow_rate(struct BasicParticle) (NodeID: 27)
            💬 Args: [p]
            👁️  Def: internal
```
