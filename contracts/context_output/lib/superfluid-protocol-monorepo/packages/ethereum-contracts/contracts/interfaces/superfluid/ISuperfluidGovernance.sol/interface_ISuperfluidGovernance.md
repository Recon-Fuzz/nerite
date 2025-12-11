# Interface: ISuperfluidGovernance

## Metadata

- **Name**: ISuperfluidGovernance
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol
- **Documentation**:  @title Superfluid governance interface
   @author Superfluid

## Errors

### SF_GOV_INVALID_LIQUIDATION_OR_PATRICIAN_PERIOD

```solidity
error SF_GOV_INVALID_LIQUIDATION_OR_PATRICIAN_PERIOD();
```

### SF_GOV_MUST_BE_CONTRACT

```solidity
error SF_GOV_MUST_BE_CONTRACT();
```

## Public/External Functions

### replaceGovernance(contract ISuperfluid,address)

- **Signature**: `replaceGovernance(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 733:87:145

**Signature:**
```solidity
///  @dev Replace the current governance with a new governance
function replaceGovernance(ISuperfluid host, address newGov) external;;
```

### registerAgreementClass(contract ISuperfluid,address)

- **Signature**: `registerAgreementClass(contract ISuperfluid,address)`
- **Visibility**: external
- **Source Range**: 885:100:145

**Signature:**
```solidity
///  @dev Register a new agreement class
function registerAgreementClass(ISuperfluid host, address agreementClass) external;;
```

### updateContracts(contract ISuperfluid,address,address[],address,address)

- **Signature**: `updateContracts(contract ISuperfluid,address,address[],address,address)`
- **Visibility**: external
- **Source Range**: 1188:223:145

**Signature:**
```solidity
///  @dev Update logics of the contracts
///  @custom:note
///  - Because they might have inter-dependencies, it is good to have one single function to update them all
function updateContracts(ISuperfluid host, address hostNewLogic, address[] calldata agreementClassNewLogics, address superTokenFactoryNewLogic, address beaconNewLogic) external;;
```

### batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[])

- **Signature**: `batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[])`
- **Visibility**: external
- **Source Range**: 1535:111:145

**Signature:**
```solidity
///  @dev Update supertoken logic contract to the latest that is managed by the super token factory
function batchUpdateSuperTokenLogic(ISuperfluid host, ISuperToken[] calldata tokens) external;;
```

### batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[])

- **Signature**: `batchUpdateSuperTokenLogic(contract ISuperfluid,contract ISuperToken[],address[])`
- **Visibility**: external
- **Source Range**: 1842:151:145

**Signature:**
```solidity
///  @dev Update supertoken logic contract to the provided logic contracts.
///       Note that this is an overloaded version taking an additional argument `tokenLogics`
function batchUpdateSuperTokenLogic(ISuperfluid host, ISuperToken[] calldata tokens, address[] calldata tokenLogics) external;;
```

### setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address)

- **Signature**: `setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,address)`
- **Visibility**: external
- **Source Range**: 2062:141:145

**Signature:**
```solidity
///  @dev Set configuration as address value
function setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, address value) external;;
```

### setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)

- **Signature**: `setConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 2272:141:145

**Signature:**
```solidity
///  @dev Set configuration as uint256 value
function setConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key, uint256 value) external;;
```

### clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Signature**: `clearConfig(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 2467:120:145

**Signature:**
```solidity
///  @dev Clear configuration
function clearConfig(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) external;;
```

### getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Signature**: `getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 2656:151:145

**Signature:**
```solidity
///  @dev Get configuration as address value
function getConfigAsAddress(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) external view returns (address value);;
```

### getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)

- **Signature**: `getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 2876:151:145

**Signature:**
```solidity
///  @dev Get configuration as uint256 value
function getConfigAsUint256(ISuperfluid host, ISuperfluidToken superToken, bytes32 key) external view returns (uint256 value);;
```
