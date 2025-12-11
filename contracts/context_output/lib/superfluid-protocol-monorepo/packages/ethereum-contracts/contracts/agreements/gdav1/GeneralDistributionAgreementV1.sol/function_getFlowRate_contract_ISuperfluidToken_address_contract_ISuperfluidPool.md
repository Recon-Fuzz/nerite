# Function: getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 7525:307:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to) override external view returns (int96) {
    (, FlowDistributionData memory data) = _getFlowDistributionData(token, _getFlowDistributionHash(from, to));
    return data.flowRate;
}
```

## Related Implementations

### _getFlowDistributionData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 41698:365:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getFlowDistributionData(contract ISuperfluidToken,bytes32)`

```solidity
function _getFlowDistributionData(ISuperfluidToken token, bytes32 distributionFlowHash) internal view returns (bool exist, FlowDistributionData memory flowDistributionData) {
    (exist, flowDistributionData) = _decodeFlowDistributionData(uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0]));
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

## External Calls

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionData(contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [token, _getFlowDistributionHash(from, to)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getFlowDistributionHash(address,contract ISuperfluidPool) (NodeID: 3)
    │   💬 Args: [from, to]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeFlowDistributionData(uint256) (NodeID: 2)
        💬 Args: [uint256(token.getAgreementData(address(this), distributionFlowHash, 1)[0])]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
