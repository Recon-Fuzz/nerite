# Contract: GDAv1Forwarder

## Metadata

- **Name**: GDAv1Forwarder
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol
- **Documentation**:  @title GDAv1Forwarder
   @author Superfluid
   The GDAv1Forwarder contract provides an easy to use interface to
   GeneralDistributionAgreementV1 specific functionality of Super Tokens.
   Instances of this contract can operate on the protocol only if configured as "trusted forwarder"
   by protocol governance.

## State Variables

### _host (inherited from ForwarderBase)

```solidity
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### _gda

```solidity
IGeneralDistributionAgreementV1 internal immutable _gda
```

**IGeneralDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IGeneralDistributionAgreementV1.sol/contract_IGeneralDistributionAgreementV1.md]

## Public/External Functions

### constructor(contract ISuperfluid)

- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 935:271:176
- **Details**: [function_constructor_contract_ISuperfluid.md](./function_constructor_contract_ISuperfluid.md)

**Signature:**
```solidity
constructor(ISuperfluid host) ForwarderBase(host);
```

### createPool(contract ISuperfluidToken,address,struct PoolConfig)

- **Signature**: `createPool(contract ISuperfluidToken,address,struct PoolConfig)`
- **Visibility**: external
- **Source Range**: 1617:244:176
- **Details**: [function_createPool_contract_ISuperfluidToken_address_struct_PoolConfig.md](./function_createPool_contract_ISuperfluidToken_address_struct_PoolConfig.md)

**Signature:**
```solidity
///  @dev Creates a new Superfluid Pool.
///  @param token The Super Token address.
///  @param admin The pool admin address.
///  @param config The pool configuration (see PoolConfig in IGeneralDistributionAgreementV1.sol)
///  @return success A boolean value indicating whether the pool was created successfully.
///  @return pool The address of the deployed Superfluid Pool
function createPool(ISuperfluidToken token, address admin, PoolConfig memory config) external returns (bool success, ISuperfluidPool pool);
```

### updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)

- **Signature**: `updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 2141:361:176
- **Details**: [function_updateMemberUnits_contract_ISuperfluidPool_address_uint128_bytes.md](./function_updateMemberUnits_contract_ISuperfluidPool_address_uint128_bytes.md)

**Signature:**
```solidity
///  @dev Updates the units of a pool member.
///  @param pool The Superfluid Pool to update.
///  @param memberAddress The address of the member to update.
///  @param newUnits The new units of the member.
///  @param userData User-specific data.
function updateMemberUnits(ISuperfluidPool pool, address memberAddress, uint128 newUnits, bytes memory userData) external returns (bool success);
```

### claimAll(contract ISuperfluidPool,address,bytes)

- **Signature**: `claimAll(contract ISuperfluidPool,address,bytes)`
- **Visibility**: external
- **Source Range**: 2734:315:176
- **Details**: [function_claimAll_contract_ISuperfluidPool_address_bytes.md](./function_claimAll_contract_ISuperfluidPool_address_bytes.md)

**Signature:**
```solidity
///  @dev Claims all tokens from the pool.
///  @param pool The Superfluid Pool to claim from.
///  @param memberAddress The address of the member to claim for.
///  @param userData User-specific data.
function claimAll(ISuperfluidPool pool, address memberAddress, bytes memory userData) external returns (bool success);
```

### connectPool(contract ISuperfluidPool,bytes)

- **Signature**: `connectPool(contract ISuperfluidPool,bytes)`
- **Visibility**: external
- **Source Range**: 3292:255:176
- **Details**: [function_connectPool_contract_ISuperfluidPool_bytes.md](./function_connectPool_contract_ISuperfluidPool_bytes.md)

**Signature:**
```solidity
///  @dev Connects a pool member to `pool`.
///  @param pool The Superfluid Pool to connect.
///  @param userData User-specific data.
///  @return A boolean value indicating whether the connection was successful.
function connectPool(ISuperfluidPool pool, bytes memory userData) external returns (bool);
```

### disconnectPool(contract ISuperfluidPool,bytes)

- **Signature**: `disconnectPool(contract ISuperfluidPool,bytes)`
- **Visibility**: external
- **Source Range**: 3801:261:176
- **Details**: [function_disconnectPool_contract_ISuperfluidPool_bytes.md](./function_disconnectPool_contract_ISuperfluidPool_bytes.md)

**Signature:**
```solidity
///  @dev Disconnects a pool member from `pool`.
///  @param pool The Superfluid Pool to disconnect.
///  @param userData User-specific data.
///  @return A boolean value indicating whether the disconnection was successful.
function disconnectPool(ISuperfluidPool pool, bytes memory userData) external returns (bool);
```

### distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)

- **Signature**: `distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 4524:392:176
- **Details**: [function_distribute_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256_bytes.md](./function_distribute_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256_bytes.md)

**Signature:**
```solidity
///  @dev Tries to distribute `requestedAmount` amount of `token` from `from` to `pool`.
///  @param token The Super Token address.
///  @param from The address from which to distribute tokens.
///  @param pool The Superfluid Pool address.
///  @param requestedAmount The amount of tokens to distribute.
///  @param userData User-specific data.
///  @return A boolean value indicating whether the distribution was successful.
function distribute(ISuperfluidToken token, address from, ISuperfluidPool pool, uint256 requestedAmount, bytes memory userData) external returns (bool);
```

### distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)

- **Signature**: `distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)`
- **Visibility**: external
- **Source Range**: 5386:414:176
- **Details**: [function_distributeFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96_bytes.md](./function_distributeFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96_bytes.md)

**Signature:**
```solidity
///  @dev Tries to distribute flow at `requestedFlowRate` of `token` from `from` to `pool`.
///  @param token The Super Token address.
///  @param from The address from which to distribute tokens.
///  @param pool The Superfluid Pool address.
///  @param requestedFlowRate The flow rate of tokens to distribute.
///  @param userData User-specific data.
///  @return A boolean value indicating whether the distribution was successful.
function distributeFlow(ISuperfluidToken token, address from, ISuperfluidPool pool, int96 requestedFlowRate, bytes memory userData) external returns (bool);
```

### isPool(contract ISuperfluidToken,address)

- **Signature**: `isPool(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6047:145:176
- **Details**: [function_isPool_contract_ISuperfluidToken_address.md](./function_isPool_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
///  @dev Checks if the specified account is a pool.
///  @param token The Super Token address.
///  @param account The account address to check.
///  @return A boolean value indicating whether the account is a pool.
function isPool(ISuperfluidToken token, address account) virtual external view returns (bool);
```

### getNetFlow(contract ISuperfluidToken,address)

- **Signature**: `getNetFlow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6422:146:176
- **Details**: [function_getNetFlow_contract_ISuperfluidToken_address.md](./function_getNetFlow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
///  @dev Gets the GDA net flow rate for the specified account.
///  @param token The Super Token address.
///  @param account The account address.
///  @return The gda net flow rate for the account.
function getNetFlow(ISuperfluidToken token, address account) external view returns (int96);
```

### getFlowDistributionFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)

- **Signature**: `getFlowDistributionFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 6852:210:176
- **Details**: [function_getFlowDistributionFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md](./function_getFlowDistributionFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md)

**Signature:**
```solidity
///  @dev Gets the flow rate of tokens between the specified accounts.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The receiver address (the pool address).
///  @return The flow distribution flow rate
function getFlowDistributionFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to) external view returns (int96);
```

### getPoolAdjustmentFlowRate(address)

- **Signature**: `getPoolAdjustmentFlowRate(address)`
- **Visibility**: external
- **Source Range**: 7238:147:176
- **Details**: [function_getPoolAdjustmentFlowRate_address.md](./function_getPoolAdjustmentFlowRate_address.md)

**Signature:**
```solidity
///  @dev Gets the pool adjustment flow rate for the specified pool.
///  @param pool The pool address.
///  @return The pool adjustment flow rate.
function getPoolAdjustmentFlowRate(address pool) virtual external view returns (int96);
```

### estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)

- **Signature**: `estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)`
- **Visibility**: external
- **Source Range**: 7742:350:176
- **Details**: [function_estimateFlowDistributionActualFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96.md](./function_estimateFlowDistributionActualFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96.md)

**Signature:**
```solidity
///  @dev Estimates the actual flow rate for flow distribution to the specified pool.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The pool address.
///  @param requestedFlowRate The requested flow rate.
///  @return actualFlowRate
///  @return totalDistributionFlowRate
function estimateFlowDistributionActualFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to, int96 requestedFlowRate) external view returns (int96 actualFlowRate, int96 totalDistributionFlowRate);
```

### estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)

- **Signature**: `estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)`
- **Visibility**: external
- **Source Range**: 8429:303:176
- **Details**: [function_estimateDistributionActualAmount_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256.md](./function_estimateDistributionActualAmount_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256.md)

**Signature:**
```solidity
///  @dev Estimates the actual amount for distribution to the specified pool.
///  @param token The Super Token address.
///  @param from The sender address.
///  @param to The pool address.
///  @param requestedAmount The requested amount.
///  @return actualAmount The actual amount for distribution.
function estimateDistributionActualAmount(ISuperfluidToken token, address from, ISuperfluidPool to, uint256 requestedAmount) external view returns (uint256 actualAmount);
```

### isMemberConnected(contract ISuperfluidPool,address)

- **Signature**: `isMemberConnected(contract ISuperfluidPool,address)`
- **Visibility**: external
- **Source Range**: 8999:154:176
- **Details**: [function_isMemberConnected_contract_ISuperfluidPool_address.md](./function_isMemberConnected_contract_ISuperfluidPool_address.md)

**Signature:**
```solidity
///  @dev Checks if the specified member is connected to the pool.
///  @param pool The Superfluid Pool address.
///  @param member The member address.
///  @return A boolean value indicating whether the member is connected to the pool.
function isMemberConnected(ISuperfluidPool pool, address member) external view returns (bool);
```

### getPoolAdjustmentFlowInfo(contract ISuperfluidPool)

- **Signature**: `getPoolAdjustmentFlowInfo(contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 9361:173:176
- **Details**: [function_getPoolAdjustmentFlowInfo_contract_ISuperfluidPool.md](./function_getPoolAdjustmentFlowInfo_contract_ISuperfluidPool.md)

**Signature:**
```solidity
///  @dev Gets the pool adjustment flow information for the specified pool.
///  @param pool The pool address.
///  @return The pool admin, pool ID, and pool adjustment flow rate.
function getPoolAdjustmentFlowInfo(ISuperfluidPool pool) virtual external view returns (address, bytes32, int96);
```
