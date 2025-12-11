# Function: realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: external
- **Source Range**: 3713:536:121

## Implementation

```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256 time) override external view returns (int256 dynamicBalance, uint256 deposit, uint256 owedDeposit) {
    (bool exist, FlowData memory state) = _getAccountFlowState(token, account);
    if (exist) {
        dynamicBalance = ((int256(time) - (int256(state.timestamp))) * state.flowRate);
        deposit = state.deposit;
        owedDeposit = state.owedDeposit;
    }
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
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.realtimeBalanceOf(contract ISuperfluidToken,address,uint256) (NodeID: 0)
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

@dev ISuperAgreement.realtimeBalanceOf implementation

### Interface Documentation

 @dev Calculate the real-time balance for the account of this agreement class
 @param account Account the state belongs to
 @param time Time used for the calculation
 @return dynamicBalance Dynamic balance portion of real-time balance of this agreement
 @return deposit Account deposit amount of this agreement
 @return owedDeposit Account owed deposit amount of this agreement
