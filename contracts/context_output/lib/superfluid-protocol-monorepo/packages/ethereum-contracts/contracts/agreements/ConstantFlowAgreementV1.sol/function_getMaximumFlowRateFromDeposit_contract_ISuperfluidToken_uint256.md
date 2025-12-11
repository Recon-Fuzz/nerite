# Function: getMaximumFlowRateFromDeposit(contract ISuperfluidToken,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]

## Metadata

- **Contract**: ConstantFlowAgreementV1
- **Signature**: `getMaximumFlowRateFromDeposit(contract ISuperfluidToken,uint256)`
- **Visibility**: external
- **Source Range**: 5706:367:121

## Implementation

```solidity
/// @dev IConstantFlowAgreementV1.getMaximumFlowRateFromDeposit implementation
function getMaximumFlowRateFromDeposit(ISuperfluidToken token, uint256 deposit) override external view returns (int96 flowRate) {
    (uint256 liquidationPeriod, ) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), token);
    flowRate = _getMaximumFlowRateFromDepositPure(liquidationPeriod, deposit);
}
```

## Related Implementations

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

### _getMaximumFlowRateFromDepositPure(uint256,uint256)

- **Kind**: internal
- **Source**: 4459:573:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_getMaximumFlowRateFromDepositPure(uint256,uint256)`

```solidity
function _getMaximumFlowRateFromDepositPure(uint256 liquidationPeriod, uint256 deposit) internal pure returns (int96 flowRate) {
    if (deposit > MAXIMUM_DEPOSIT) revert CFA_DEPOSIT_TOO_BIG();
    deposit = _clipDepositNumberRoundingDown(deposit);
    uint256 flowrate1 = deposit / liquidationPeriod;
    return int96(int256(flowrate1));
}
```

### _clipDepositNumberRoundingDown(uint256)

- **Kind**: internal
- **Source**: 56022:155:121
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol:ConstantFlowAgreementV1:_clipDepositNumberRoundingDown(uint256)`

```solidity
function _clipDepositNumberRoundingDown(uint256 deposit) internal pure returns (uint256) {
    return ((deposit >> 32)) << 32;
}
```

## External Calls

- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**

## State Variable Reads

- **MAXIMUM_DEPOSIT** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: ConstantFlowAgreementV1.getMaximumFlowRateFromDeposit(contract ISuperfluidToken,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 1)
  │   💬 Args: [ISuperfluid(_host), token]
  │   👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 2)
  │     💬 Args: [pppConfig]
  │     👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: ConstantFlowAgreementV1._getMaximumFlowRateFromDepositPure(uint256,uint256) (NodeID: 3)
      💬 Args: [liquidationPeriod, deposit]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: ConstantFlowAgreementV1._clipDepositNumberRoundingDown(uint256) (NodeID: 4)
        💬 Args: [deposit]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev IConstantFlowAgreementV1.getMaximumFlowRateFromDeposit implementation
