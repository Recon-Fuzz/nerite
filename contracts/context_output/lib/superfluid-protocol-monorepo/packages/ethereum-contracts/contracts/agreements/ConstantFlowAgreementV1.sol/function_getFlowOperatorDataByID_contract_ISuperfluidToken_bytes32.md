# Function: getFlowOperatorDataByID(contract ISuperfluidToken,bytes32)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getFlowOperatorDataByID(contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 33817:421:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getFlowOperatorDataByID implementation
function getFlowOperatorDataByID(ISuperfluidToken token, bytes32 flowOperatorId) override external view returns (uint8 permissions, int96 flowRateAllowance) {
    (, FlowOperatorData memory flowOperatorData) = _getFlowOperatorData(token, flowOperatorId);
    permissions = flowOperatorData.permissions;
    flowRateAllowance = flowOperatorData.flowRateAllowance;
}
```

## Related Implementations

### _getFlowOperatorData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 35184:409:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getFlowOperatorData(contract ISuperfluidToken,bytes32)`

```solidity
function _getFlowOperatorData(ISuperfluidToken token, bytes32 flowOperatorId) private view returns (bool exist, FlowOperatorData memory) {
    bytes32[] memory data = token.getAgreementData(address(this), flowOperatorId, 1);
    return _decodeFlowOperatorData(uint256(data[0]));
}
```

### _decodeFlowOperatorData(uint256)

- **Kind**: internal
- **Source**: 60137:527:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_decodeFlowOperatorData(uint256)`

```solidity
function _decodeFlowOperatorData(uint256 wordA) internal pure returns (bool exist, FlowOperatorData memory flowOperatorData) {
    exist = wordA > 0;
    if (exist) {
        flowOperatorData.flowRateAllowance = int96(int256(wordA & uint256(int256(type(int96).max))));
        flowOperatorData.permissions = uint8(wordA >> 128) & type(uint8).max;
    }
}
```

## External Calls

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getFlowOperatorDataByID(contract ISuperfluidToken,bytes32) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getFlowOperatorData(contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [token, flowOperatorId]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowOperatorData(uint256) (NodeID: 2)
        💬 Args: [uint256(data[0])]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getFlowOperatorDataByID implementation
