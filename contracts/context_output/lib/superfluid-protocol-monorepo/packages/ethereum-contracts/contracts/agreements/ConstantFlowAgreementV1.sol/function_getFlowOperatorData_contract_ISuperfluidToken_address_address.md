# Function: getFlowOperatorData(contract ISuperfluidToken,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getFlowOperatorData(contract ISuperfluidToken,address,address)`
- **Visibility**: public
- **Source Range**: 33201:533:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getFlowOperatorData implementation
function getFlowOperatorData(ISuperfluidToken token, address sender, address flowOperator) override public view returns (bytes32 flowOperatorId, uint8 permissions, int96 flowRateAllowance) {
    flowOperatorId = _generateFlowOperatorId(sender, flowOperator);
    (, FlowOperatorData memory flowOperatorData) = _getFlowOperatorData(token, flowOperatorId);
    permissions = flowOperatorData.permissions;
    flowRateAllowance = flowOperatorData.flowRateAllowance;
}
```

## Related Implementations

### _generateFlowOperatorId(address,address)

- **Kind**: internal
- **Source**: 59069:187:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_generateFlowOperatorId(address,address)`

```solidity
function _generateFlowOperatorId(address sender, address flowOperator) private pure returns (bytes32 id) {
    return keccak256(abi.encode("flowOperator", sender, flowOperator));
}
```

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
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getFlowOperatorData(contract ISuperfluidToken,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowOperatorId(address,address) (NodeID: 1)
  │   💬 Args: [sender, flowOperator]
  │   👁️  Def: private
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getFlowOperatorData(contract ISuperfluidToken,bytes32) (NodeID: 2)
      💬 Args: [token, flowOperatorId]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowOperatorData(uint256) (NodeID: 3)
        💬 Args: [uint256(data[0])]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getFlowOperatorData implementation
