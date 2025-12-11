# Function: isPatricianPeriodNow(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `isPatricianPeriodNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 7016:331:121

## Implementation

```solidity
function isPatricianPeriodNow(ISuperfluidToken token, address account) override external view returns (bool isCurrentlyPatricianPeriod, uint256 timestamp) {
    timestamp = ISuperfluid(_host).getNow();
    isCurrentlyPatricianPeriod = isPatricianPeriod(token, account, timestamp);
}
```

## Related Implementations

### isPatricianPeriod(contract ISuperfluidToken,address,uint256)

- **Kind**: internal
- **Source**: 7353:827:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:isPatricianPeriod(contract ISuperfluidToken,address,uint256)`

```solidity
function isPatricianPeriod(ISuperfluidToken token, address account, uint256 timestamp) override public view returns (bool) {
    (int256 availableBalance, , ) = token.realtimeBalanceOf(account, timestamp);
    if (availableBalance >= 0) {
        return true;
    }
    (uint256 liquidationPeriod, uint256 patricianPeriod) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), token);
    (, FlowData memory senderAccountState) = _getAccountFlowState(token, account);
    int256 signedTotalCFADeposit = senderAccountState.deposit.toInt256();
    return SolvencyHelperLibrary.isPatricianPeriod(availableBalance, signedTotalCFADeposit, liquidationPeriod, patricianPeriod);
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

## External Calls

- **ISuperfluid::getNow()**
- **ISuperfluidToken::realtimeBalanceOf(address,uint256)**
- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.isPatricianPeriodNow(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1.isPatricianPeriod(contract ISuperfluidToken,address,uint256) (NodeID: 1)
      💬 Args: [token, account, timestamp]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 2)
    │   💬 Args: [ISuperfluid(_host), token]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 3)
    │     💬 Args: [pppConfig]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._getAccountFlowState(contract ISuperfluidToken,address) (NodeID: 4)
    │   💬 Args: [token, account]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._decodeFlowData(uint256) (NodeID: 5)
    │     💬 Args: [uint256(data[0])]
    │     👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 6)
    │   💬 Args: [senderAccountState.deposit]
    │   👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.isPatricianPeriod(int256,int256,uint256,uint256) (NodeID: 7)
        💬 Args: [availableBalance, signedTotalCFADeposit, liquidationPeriod, patricianPeriod]
        👁️  Def: internal
```
