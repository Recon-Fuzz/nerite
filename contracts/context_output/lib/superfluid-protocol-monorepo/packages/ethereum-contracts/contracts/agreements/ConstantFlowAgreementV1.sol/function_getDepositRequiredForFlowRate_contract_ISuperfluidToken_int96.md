# Function: getDepositRequiredForFlowRate(contract ISuperfluidToken,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getDepositRequiredForFlowRate(contract ISuperfluidToken,int96)`
- **Visibility**: external
- **Source Range**: 6164:846:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getDepositRequiredForFlowRate implementation
function getDepositRequiredForFlowRate(ISuperfluidToken token, int96 flowRate) override external view returns (uint256 deposit) {
    if (flowRate == 0) return 0;
    ISuperfluidGovernance gov = ISuperfluidGovernance(ISuperfluid(_host).getGovernance());
    uint256 minimumDeposit = gov.getConfigAsUint256(ISuperfluid(_host), token, SuperfluidGovernanceConfigs.SUPERTOKEN_MINIMUM_DEPOSIT_KEY);
    uint256 pppConfig = gov.getConfigAsUint256(ISuperfluid(_host), token, SuperfluidGovernanceConfigs.CFAV1_PPP_CONFIG_KEY);
    (uint256 liquidationPeriod, ) = SuperfluidGovernanceConfigs.decodePPPConfig(pppConfig);
    return _getDepositRequiredForFlowRatePure(minimumDeposit, liquidationPeriod, flowRate);
}
```

## Related Implementations

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

### _getDepositRequiredForFlowRatePure(uint256,uint256,int96)

- **Kind**: internal
- **Source**: 5039:576:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getDepositRequiredForFlowRatePure(uint256,uint256,int96)`

```solidity
function _getDepositRequiredForFlowRatePure(uint256 minimumDeposit, uint256 liquidationPeriod, int96 flowRate) internal pure returns (uint256 deposit) {
    if (flowRate < 0) revert CFA_INVALID_FLOW_RATE();
    if ((uint256(int256(flowRate)) * liquidationPeriod) > uint256(int256(type(int96).max))) {
        revert CFA_FLOW_RATE_TOO_BIG();
    }
    uint256 calculatedDeposit = _calculateDeposit(flowRate, liquidationPeriod);
    return AgreementLibrary.max(minimumDeposit, calculatedDeposit);
}
```

### _calculateDeposit(int96,uint256)

- **Kind**: internal
- **Source**: 56465:458:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_calculateDeposit(int96,uint256)`

```solidity
function _calculateDeposit(int96 flowRate, uint256 liquidationPeriod) internal pure returns (uint256 deposit) {
    if (flowRate == 0) return 0;
    assert(liquidationPeriod <= uint256(int256(type(int96).max)));
    deposit = uint256(int256(flowRate * int96(uint96(liquidationPeriod))));
    return _clipDepositNumberRoundingUp(deposit);
}
```

### _clipDepositNumberRoundingUp(uint256)

- **Kind**: internal
- **Source**: 56183:276:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_clipDepositNumberRoundingUp(uint256)`

```solidity
function _clipDepositNumberRoundingUp(uint256 deposit) internal pure returns (uint256) {
    uint256 rounding = ((deposit & type(uint32).max) > 0) ? 1 : 0;
    return ((deposit >> 32) + rounding) << 32;
}
```

### max(uint256,uint256)

- **Kind**: internal
- **Source**: 8484:92:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:max(uint256,uint256)`

```solidity
function max(uint256 a, uint256 b) internal pure returns (uint256) {
    return (a > b) ? a : b;
}
```

## External Calls

- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getDepositRequiredForFlowRate(contract ISuperfluidToken,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 1)
  │   💬 Args: [pppConfig]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getDepositRequiredForFlowRatePure(uint256,uint256,int96) (NodeID: 2)
      💬 Args: [minimumDeposit, liquidationPeriod, flowRate]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._calculateDeposit(int96,uint256) (NodeID: 3)
    │   💬 Args: [flowRate, liquidationPeriod]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingUp(uint256) (NodeID: 4)
    │     💬 Args: [deposit]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: AgreementLibrary.max(uint256,uint256) (NodeID: 5)
        💬 Args: [minimumDeposit, calculatedDeposit]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getDepositRequiredForFlowRate implementation
