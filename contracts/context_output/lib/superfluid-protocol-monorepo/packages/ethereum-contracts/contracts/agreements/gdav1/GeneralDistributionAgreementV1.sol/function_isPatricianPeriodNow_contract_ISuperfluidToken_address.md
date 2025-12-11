# Function: isPatricianPeriodNow(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `isPatricianPeriodNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 29536:330:123

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
- **Source**: 29872:697:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:isPatricianPeriod(contract ISuperfluidToken,address,uint256)`

```solidity
function isPatricianPeriod(ISuperfluidToken token, address account, uint256 timestamp) override public view returns (bool) {
    (int256 availableBalance, , ) = token.realtimeBalanceOf(account, timestamp);
    if (availableBalance >= 0) {
        return true;
    }
    (uint256 liquidationPeriod, uint256 patricianPeriod) = SolvencyHelperLibrary.decode3PsData(ISuperfluid(_host), token);
    return SolvencyHelperLibrary.isPatricianPeriod(availableBalance, _getUIndexData(abi.encode(token), account).totalBuffer.toInt256(), liquidationPeriod, patricianPeriod);
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

## External Calls

- **ISuperfluid::getNow()**
- **ISuperfluidToken::realtimeBalanceOf(address,uint256)**
- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.isPatricianPeriodNow(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1.isPatricianPeriod(contract ISuperfluidToken,address,uint256) (NodeID: 1)
      💬 Args: [token, account, timestamp]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.decode3PsData(contract ISuperfluid,contract ISuperfluidToken) (NodeID: 2)
    │   💬 Args: [ISuperfluid(_host), token]
    │   👁️  Def: internal
    │ └─ [3] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.decodePPPConfig(uint256) (NodeID: 3)
    │     💬 Args: [pppConfig]
    │     👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SolvencyHelperLibrary.isPatricianPeriod(int256,int256,uint256,uint256) (NodeID: 4)
        💬 Args: [availableBalance, _getUIndexData(abi.encode(token), account).totalBuffer.toInt256(), liquidationPeriod, patricianPeriod]
        👁️  Def: internal
      ├─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getUIndexData(bytes,address) (NodeID: 5)
      │   💬 Args: [abi.encode(token), account]
      │   👁️  Def: internal
      │ └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodeUniversalIndexData(bytes32[]) (NodeID: 6)
      │     💬 Args: [ISuperfluidToken(abi.decode(eff, (address))).getAgreementStateSlot(address(this), owner, _UNIVERSAL_INDEX_STATE_SLOT_ID, 2)]
      │     👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 7)
          💬 Args: [_getUIndexData(abi.encode(token), account).totalBuffer]
          👁️  Def: internal
```
