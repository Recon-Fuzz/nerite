# Function: getFlow(contract ISuperfluidToken,address,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getFlow(contract ISuperfluidToken,address,address)`
- **Visibility**: external
- **Source Range**: 10756:570:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getFlow implementation
function getFlow(ISuperfluidToken token, address sender, address receiver) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit, uint256 owedDeposit) {
    (, FlowData memory data) = _getAgreementData(token, _generateFlowId(sender, receiver));
    return (data.timestamp, data.flowRate, data.deposit, data.owedDeposit);
}
```

## Related Implementations

### _getAgreementData(contract ISuperfluidToken,bytes32)

- **Kind**: internal
- **Source**: 34880:298:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getAgreementData(contract ISuperfluidToken,bytes32)`

```solidity
function _getAgreementData(ISuperfluidToken token, bytes32 dId) private view returns (bool exist, FlowData memory) {
    bytes32[] memory data = token.getAgreementData(address(this), dId, 1);
    return _decodeFlowData(uint256(data[0]));
}
```

### _generateFlowId(address,address)

- **Kind**: internal
- **Source**: 57122:155:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_generateFlowId(address,address)`

```solidity
function _generateFlowId(address sender, address receiver) private pure returns (bytes32 id) {
    return keccak256(abi.encode(sender, receiver));
}
```

### _decodeFlowData(uint256)

- **Kind**: internal
- **Source**: 58188:688:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_decodeFlowData(uint256)`

```solidity
function _decodeFlowData(uint256 wordA) internal pure returns (bool exist, FlowData memory flowData) {
    exist = wordA > 0;
    if (exist) {
        flowData.timestamp = uint32(wordA >> 224);
        flowData.flowRate = int96(int256(wordA >> 128) & int256(uint256(type(uint96).max)));
        flowData.deposit = ((wordA >> 64) & uint256(type(uint64).max)) << 32;
        flowData.owedDeposit = (wordA & uint256(type(uint64).max)) << 32;
    }
}
```

## External Calls

- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getFlow(contract ISuperfluidToken,address,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAgreementData(contract ISuperfluidToken,bytes32) (NodeID: 1)
      💬 Args: [token, _generateFlowId(sender, receiver)]
      👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._generateFlowId(address,address) (NodeID: 3)
    │   💬 Args: [sender, receiver]
    │   👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 2)
        💬 Args: [uint256(data[0])]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getFlow implementation
