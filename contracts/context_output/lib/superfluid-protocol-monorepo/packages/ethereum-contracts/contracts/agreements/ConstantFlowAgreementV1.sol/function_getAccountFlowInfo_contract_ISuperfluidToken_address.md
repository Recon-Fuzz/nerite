# Function: getAccountFlowInfo(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getAccountFlowInfo(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 12001:488:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getAccountFlowInfo implementation
function getAccountFlowInfo(ISuperfluidToken token, address account) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit, uint256 owedDeposit) {
    (, FlowData memory state) = _getAccountFlowState(token, account);
    return (state.timestamp, state.flowRate, state.deposit, state.owedDeposit);
}
```

## Related Implementations

### _getAccountFlowState(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 34532:342:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getAccountFlowState(contract ISuperfluidToken,address)`

```solidity
function _getAccountFlowState(ISuperfluidToken token, address account) private view returns (bool exist, FlowData memory) {
    bytes32[] memory data = token.getAgreementStateSlot(address(this), account, 0, 1);
    return _decodeFlowData(uint256(data[0]));
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

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getAccountFlowInfo(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 1)
      💬 Args: [token, account]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 2)
        💬 Args: [uint256(data[0])]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getAccountFlowInfo implementation
