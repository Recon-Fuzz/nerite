# Function: getAccountFlowInfo(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `getAccountFlowInfo(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 8373:443:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getAccountFlowInfo(ISuperfluidToken token, address account) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit) {
    UniversalIndexData memory universalIndexData = _getUIndexData(abi.encode(token), account);
    timestamp = universalIndexData.settledAt;
    flowRate = universalIndexData.flowRate;
    deposit = universalIndexData.totalBuffer;
}
```

## Related Implementations

### _getUIndexData(bytes,address)

- **Kind**: internal
- **Source**: 33971:398:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getUIndexData(bytes,address)`

```solidity
function _getUIndexData(bytes memory eff, address owner) internal view returns (UniversalIndexData memory universalIndexData) {
    (, universalIndexData) = _decodeUniversalIndexData(ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2));
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

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.getAccountFlowInfo(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 1)
      💬 Args: [abi.encode(token), account]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 2)
        💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
