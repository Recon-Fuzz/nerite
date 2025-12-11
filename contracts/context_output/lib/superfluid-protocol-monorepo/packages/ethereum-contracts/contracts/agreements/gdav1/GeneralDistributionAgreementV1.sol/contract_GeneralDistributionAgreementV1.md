# Contract: GeneralDistributionAgreementV1

## Metadata

- **Name**: GeneralDistributionAgreementV1
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol
- **Documentation**:  @title General Distribution Agreement
   @author Superfluid
   @notice
   Storage Layout Notes
   Agreement State
   Universal Index Data
   slotId           = _UNIVERSAL_INDEX_STATE_SLOT_ID or 0
   msg.sender       = address of GDAv1
   account          = context.msgSender
   Universal Index Data stores a Basic Particle for an account as well as the total buffer and
   whether the account is a pool or not.
   SlotsBitmap Data
   slotId           = _POOL_SUBS_BITMAP_STATE_SLOT_ID or 1
   msg.sender       = address of GDAv1
   account          = context.msgSender
   Slots Bitmap Data Slot stores a bitmap of the slots that are "enabled" for a pool member.
   Pool Connections Data Slot Id Start
   slotId (start)   = _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START or 1 << 128 or 340282366920938463463374607431768211456
   msg.sender       = address of GDAv1
   account          = context.msgSender
   Pool Connections Data Slot Id Start indicates the starting slot for where we begin to store the pools that a
   pool member is a part of.
   Agreement Data
   NOTE The Agreement Data slot is calculated with the following function:
   keccak256(abi.encode("AgreementData", agreementClass, agreementId))
   agreementClass       = address of GDAv1
   agreementId          = DistributionFlowId | PoolMemberId
   DistributionFlowId   =
   keccak256(abi.encode(block.chainid, "distributionFlow", from, pool))
   DistributionFlowId stores FlowDistributionData between a sender (from) and pool.
   PoolMemberId         =
   keccak256(abi.encode(block.chainid, "poolMember", member, pool))
   PoolMemberId stores PoolMemberData for a member at a pool.

## Implements Interfaces

- **ISuperAgreement** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol/interface_ISuperAgreement.md]

## State Variables

### _initialized (inherited from Initializable)

```solidity
///  @dev Indicates that the contract has been initialized.
///  @custom:oz-retyped-from bool
uint8 private _initialized
```

### _initializing (inherited from Initializable)

```solidity
///  @dev Indicates that the contract is in the process of being initialized.
bool private _initializing
```

### _host (inherited from AgreementBase)

```solidity
address internal immutable _host
```

### SLOTS_BITMAP_LIBRARY_ADDRESS

```solidity
address public constant SLOTS_BITMAP_LIBRARY_ADDRESS = address(SlotsBitmapLibrary)
```

### SUPERFLUID_POOL_DEPLOYER_ADDRESS

```solidity
address public constant SUPERFLUID_POOL_DEPLOYER_ADDRESS = address(SuperfluidPoolDeployerLibrary)
```

### _UNIVERSAL_INDEX_STATE_SLOT_ID

```solidity
/// @dev Universal Index state slot id for storing universal index data
uint256 private constant _UNIVERSAL_INDEX_STATE_SLOT_ID = 0
```

### _POOL_SUBS_BITMAP_STATE_SLOT_ID

```solidity
/// @dev Pool member state slot id for storing subs bitmap
uint256 private constant _POOL_SUBS_BITMAP_STATE_SLOT_ID = 1
```

### _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START

```solidity
/// @dev Pool member state slot id starting point for pool connections
uint256 private constant _POOL_CONNECTIONS_DATA_STATE_SLOT_ID_START = 1 << 128
```

### SUPERTOKEN_MINIMUM_DEPOSIT_KEY

```solidity
/// @dev SuperToken minimum deposit key
bytes32 private constant SUPERTOKEN_MINIMUM_DEPOSIT_KEY = keccak256("org.superfluid-finance.superfluid.superTokenMinimumDeposit")
```

### superfluidPoolBeacon

```solidity
SuperfluidUpgradeableBeacon public immutable superfluidPoolBeacon
```

**SuperfluidUpgradeableBeacon**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol/contract_SuperfluidUpgradeableBeacon.md]

## Structs

### DistributeFlowVars (inherited from TokenMonad)

```solidity
struct DistributeFlowVars {
    FlowRate currentAdjustmentFlowRate;
    FlowRate newAdjustmentFlowRate;
    FlowRate actualFlowRateDelta;
}
```

### UniversalIndexData

```solidity
struct UniversalIndexData {
    int96 flowRate;
    uint32 settledAt;
    uint256 totalBuffer;
    bool isPool;
    int256 settledValue;
}
```

### PoolMemberData

```solidity
struct PoolMemberData {
    address pool;
    uint32 poolID;
}
```

### FlowDistributionData

```solidity
struct FlowDistributionData {
    uint32 lastUpdated;
    int96 flowRate;
    uint256 buffer;
}
```

### _StackVars_DistributeFlow

```solidity
struct _StackVars_DistributeFlow {
    ISuperfluid.Context currentContext;
    bytes32 distributionFlowHash;
    FlowRate oldFlowRate;
}
```

### _StackVars_Liquidation

```solidity
struct _StackVars_Liquidation {
    ISuperfluidToken token;
    int256 availableBalance;
    address sender;
    bytes32 distributionFlowHash;
    int256 signedTotalGDADeposit;
    address liquidator;
}
```

## Errors

### AGREEMENT_BASE_ONLY_HOST (inherited from AgreementBase)

```solidity
error AGREEMENT_BASE_ONLY_HOST();
```

### GDA_DISTRIBUTE_FOR_OTHERS_NOT_ALLOWED (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_DISTRIBUTE_FOR_OTHERS_NOT_ALLOWED();
```

### GDA_DISTRIBUTE_FROM_ANY_ADDRESS_NOT_ALLOWED (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_DISTRIBUTE_FROM_ANY_ADDRESS_NOT_ALLOWED();
```

### GDA_FLOW_DOES_NOT_EXIST (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_FLOW_DOES_NOT_EXIST();
```

### GDA_NON_CRITICAL_SENDER (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_NON_CRITICAL_SENDER();
```

### GDA_INSUFFICIENT_BALANCE (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_INSUFFICIENT_BALANCE();
```

### GDA_NO_NEGATIVE_FLOW_RATE (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_NO_NEGATIVE_FLOW_RATE();
```

### GDA_ADMIN_CANNOT_BE_POOL (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_ADMIN_CANNOT_BE_POOL();
```

### GDA_NOT_POOL_ADMIN (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_NOT_POOL_ADMIN();
```

### GDA_NO_ZERO_ADDRESS_ADMIN (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_NO_ZERO_ADDRESS_ADMIN();
```

### GDA_ONLY_SUPER_TOKEN_POOL (inherited from IGeneralDistributionAgreementV1)

```solidity
error GDA_ONLY_SUPER_TOKEN_POOL();
```

## Events

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

### CodeUpdated (inherited from UUPSProxiable)

```solidity
event CodeUpdated(bytes32 uuid, address codeAddress);
```

### InstantDistributionUpdated (inherited from IGeneralDistributionAgreementV1)

```solidity
event InstantDistributionUpdated(ISuperfluidToken indexed token, ISuperfluidPool indexed pool, address indexed distributor, address operator, uint256 requestedAmount, uint256 actualAmount, bytes userData);
```

### FlowDistributionUpdated (inherited from IGeneralDistributionAgreementV1)

```solidity
event FlowDistributionUpdated(ISuperfluidToken indexed token, ISuperfluidPool indexed pool, address indexed distributor, address operator, int96 oldFlowRate, int96 newDistributorToPoolFlowRate, int96 newTotalDistributionFlowRate, address adjustmentFlowRecipient, int96 adjustmentFlowRate, bytes userData);
```

### PoolCreated (inherited from IGeneralDistributionAgreementV1)

```solidity
event PoolCreated(ISuperfluidToken indexed token, address indexed admin, ISuperfluidPool pool);
```

### PoolConnectionUpdated (inherited from IGeneralDistributionAgreementV1)

```solidity
event PoolConnectionUpdated(ISuperfluidToken indexed token, ISuperfluidPool indexed pool, address indexed account, bool connected, bytes userData);
```

### BufferAdjusted (inherited from IGeneralDistributionAgreementV1)

```solidity
event BufferAdjusted(ISuperfluidToken indexed token, ISuperfluidPool indexed pool, address indexed from, int256 bufferDelta, uint256 newBufferAmount, uint256 totalBufferAmount);
```

## Public/External Functions

### constructor(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)

- **Signature**: `constructor(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)`
- **Visibility**: public
- **Source Range**: 4774:171:123
- **Details**: [function_constructor_contract_ISuperfluid_contract_SuperfluidUpgradeableBeacon.md](./function_constructor_contract_ISuperfluid_contract_SuperfluidUpgradeableBeacon.md)

**Signature:**
```solidity
constructor(ISuperfluid host, SuperfluidUpgradeableBeacon superfluidPoolBeacon_) AgreementBase(address(host));
```

### realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: public
- **Source Range**: 4951:1322:123
- **Details**: [function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md](./function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md)

**Signature:**
```solidity
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256 time) override public view returns (int256 rtb, uint256 buf, uint256 owedBuffer);
```

### realtimeBalanceOfNow(contract ISuperfluidToken,address)

- **Signature**: `realtimeBalanceOfNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6341:347:123
- **Details**: [function_realtimeBalanceOfNow_contract_ISuperfluidToken_address.md](./function_realtimeBalanceOfNow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOfNow(ISuperfluidToken token, address account) external view returns (int256 availableBalance, uint256 buffer, uint256 owedBuffer, uint256 timestamp);
```

### getNetFlow(contract ISuperfluidToken,address)

- **Signature**: `getNetFlow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 6746:721:123
- **Details**: [function_getNetFlow_contract_ISuperfluidToken_address.md](./function_getNetFlow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getNetFlow(ISuperfluidToken token, address account) override external view returns (int96 netFlowRate);
```

### getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)

- **Signature**: `getFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 7525:307:123
- **Details**: [function_getFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md](./function_getFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to) override external view returns (int96);
```

### getFlow(contract ISuperfluidToken,address,contract ISuperfluidPool)

- **Signature**: `getFlow(contract ISuperfluidToken,address,contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 7890:425:123
- **Details**: [function_getFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md](./function_getFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getFlow(ISuperfluidToken token, address from, ISuperfluidPool to) override external view returns (uint256 lastUpdated, int96 flowRate, uint256 deposit);
```

### getAccountFlowInfo(contract ISuperfluidToken,address)

- **Signature**: `getAccountFlowInfo(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 8373:443:123
- **Details**: [function_getAccountFlowInfo_contract_ISuperfluidToken_address.md](./function_getAccountFlowInfo_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getAccountFlowInfo(ISuperfluidToken token, address account) override external view returns (uint256 timestamp, int96 flowRate, uint256 deposit);
```

### estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)

- **Signature**: `estimateFlowDistributionActualFlowRate(contract ISuperfluidToken,address,contract ISuperfluidPool,int96)`
- **Visibility**: external
- **Source Range**: 8874:1513:123
- **Details**: [function_estimateFlowDistributionActualFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96.md](./function_estimateFlowDistributionActualFlowRate_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function estimateFlowDistributionActualFlowRate(ISuperfluidToken token, address from, ISuperfluidPool to, int96 requestedFlowRate) override external view returns (int96 actualFlowRate, int96 totalDistributionFlowRate);
```

### estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)

- **Signature**: `estimateDistributionActualAmount(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256)`
- **Visibility**: external
- **Source Range**: 10445:538:123
- **Details**: [function_estimateDistributionActualAmount_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256.md](./function_estimateDistributionActualAmount_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function estimateDistributionActualAmount(ISuperfluidToken token, address from, ISuperfluidPool to, uint256 requestedAmount) override external view returns (uint256 actualAmount);
```

### createPool(contract ISuperfluidToken,address,struct PoolConfig)

- **Signature**: `createPool(contract ISuperfluidToken,address,struct PoolConfig)`
- **Visibility**: external
- **Source Range**: 12289:364:123
- **Details**: [function_createPool_contract_ISuperfluidToken_address_struct_PoolConfig.md](./function_createPool_contract_ISuperfluidToken_address_struct_PoolConfig.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function createPool(ISuperfluidToken token, address admin, PoolConfig memory config) override external returns (ISuperfluidPool pool);
```

### createPoolWithCustomERC20Metadata(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)

- **Signature**: `createPoolWithCustomERC20Metadata(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)`
- **Visibility**: external
- **Source Range**: 12711:315:123
- **Details**: [function_createPoolWithCustomERC20Metadata_contract_ISuperfluidToken_address_struct_PoolConfig_struct_PoolERC20Metadata.md](./function_createPoolWithCustomERC20Metadata_contract_ISuperfluidToken_address_struct_PoolConfig_struct_PoolERC20Metadata.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function createPoolWithCustomERC20Metadata(ISuperfluidToken token, address admin, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) override external returns (ISuperfluidPool pool);
```

### updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)

- **Signature**: `updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 13084:482:123
- **Details**: [function_updateMemberUnits_contract_ISuperfluidPool_address_uint128_bytes.md](./function_updateMemberUnits_contract_ISuperfluidPool_address_uint128_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function updateMemberUnits(ISuperfluidPool pool, address memberAddress, uint128 newUnits, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### claimAll(contract ISuperfluidPool,address,bytes)

- **Signature**: `claimAll(contract ISuperfluidPool,address,bytes)`
- **Visibility**: external
- **Source Range**: 13624:298:123
- **Details**: [function_claimAll_contract_ISuperfluidPool_address_bytes.md](./function_claimAll_contract_ISuperfluidPool_address_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function claimAll(ISuperfluidPool pool, address memberAddress, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### connectPool(contract ISuperfluidPool,bytes)

- **Signature**: `connectPool(contract ISuperfluidPool,bytes)`
- **Visibility**: external
- **Source Range**: 13980:163:123
- **Details**: [function_connectPool_contract_ISuperfluidPool_bytes.md](./function_connectPool_contract_ISuperfluidPool_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function connectPool(ISuperfluidPool pool, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### disconnectPool(contract ISuperfluidPool,bytes)

- **Signature**: `disconnectPool(contract ISuperfluidPool,bytes)`
- **Visibility**: external
- **Source Range**: 14201:167:123
- **Details**: [function_disconnectPool_contract_ISuperfluidPool_bytes.md](./function_disconnectPool_contract_ISuperfluidPool_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function disconnectPool(ISuperfluidPool pool, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### connectPool(contract ISuperfluidPool,bool,bytes)

- **Signature**: `connectPool(contract ISuperfluidPool,bool,bytes)`
- **Visibility**: public
- **Source Range**: 14421:1670:123
- **Details**: [function_connectPool_contract_ISuperfluidPool_bool_bytes.md](./function_connectPool_contract_ISuperfluidPool_bool_bytes.md)

**Signature:**
```solidity
function connectPool(ISuperfluidPool pool, bool doConnect, bytes calldata ctx) public returns (bytes memory newCtx);
```

### isMemberConnected(contract ISuperfluidPool,address)

- **Signature**: `isMemberConnected(contract ISuperfluidPool,address)`
- **Visibility**: external
- **Source Range**: 16325:187:123
- **Details**: [function_isMemberConnected_contract_ISuperfluidPool_address.md](./function_isMemberConnected_contract_ISuperfluidPool_address.md)

**Signature:**
```solidity
function isMemberConnected(ISuperfluidPool pool, address member) override external view returns (bool);
```

### appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time)

- **Signature**: `appendIndexUpdateByPool(contract ISuperfluidToken,struct BasicParticle,Time)`
- **Visibility**: external
- **Source Range**: 16518:465:123
- **Details**: [function_appendIndexUpdateByPool_contract_ISuperfluidToken_struct_BasicParticle_Time.md](./function_appendIndexUpdateByPool_contract_ISuperfluidToken_struct_BasicParticle_Time.md)

**Signature:**
```solidity
function appendIndexUpdateByPool(ISuperfluidToken token, BasicParticle memory p, Time t) external returns (bool);
```

### poolSettleClaim(contract ISuperfluidToken,address,int256)

- **Signature**: `poolSettleClaim(contract ISuperfluidToken,address,int256)`
- **Visibility**: external
- **Source Range**: 16989:400:123
- **Details**: [function_poolSettleClaim_contract_ISuperfluidToken_address_int256.md](./function_poolSettleClaim_contract_ISuperfluidToken_address_int256.md)

**Signature:**
```solidity
function poolSettleClaim(ISuperfluidToken superToken, address claimRecipient, int256 amount) external returns (bool);
```

### distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)

- **Signature**: `distribute(contract ISuperfluidToken,address,contract ISuperfluidPool,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 17447:1843:123
- **Details**: [function_distribute_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256_bytes.md](./function_distribute_contract_ISuperfluidToken_address_contract_ISuperfluidPool_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function distribute(ISuperfluidToken token, address from, ISuperfluidPool pool, uint256 requestedAmount, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)

- **Signature**: `distributeFlow(contract ISuperfluidToken,address,contract ISuperfluidPool,int96,bytes)`
- **Visibility**: external
- **Source Range**: 19856:4615:123
- **Details**: [function_distributeFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96_bytes.md](./function_distributeFlow_contract_ISuperfluidToken_address_contract_ISuperfluidPool_int96_bytes.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function distributeFlow(ISuperfluidToken token, address from, ISuperfluidPool pool, int96 requestedFlowRate, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### isPatricianPeriodNow(contract ISuperfluidToken,address)

- **Signature**: `isPatricianPeriodNow(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 29536:330:123
- **Details**: [function_isPatricianPeriodNow_contract_ISuperfluidToken_address.md](./function_isPatricianPeriodNow_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
function isPatricianPeriodNow(ISuperfluidToken token, address account) override external view returns (bool isCurrentlyPatricianPeriod, uint256 timestamp);
```

### isPatricianPeriod(contract ISuperfluidToken,address,uint256)

- **Signature**: `isPatricianPeriod(contract ISuperfluidToken,address,uint256)`
- **Visibility**: public
- **Source Range**: 29872:697:123
- **Details**: [function_isPatricianPeriod_contract_ISuperfluidToken_address_uint256.md](./function_isPatricianPeriod_contract_ISuperfluidToken_address_uint256.md)

**Signature:**
```solidity
function isPatricianPeriod(ISuperfluidToken token, address account, uint256 timestamp) override public view returns (bool);
```

### getPoolAdjustmentFlowInfo(contract ISuperfluidPool)

- **Signature**: `getPoolAdjustmentFlowInfo(contract ISuperfluidPool)`
- **Visibility**: external
- **Source Range**: 37539:274:123
- **Details**: [function_getPoolAdjustmentFlowInfo_contract_ISuperfluidPool.md](./function_getPoolAdjustmentFlowInfo_contract_ISuperfluidPool.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function getPoolAdjustmentFlowInfo(ISuperfluidPool pool) override external view returns (address recipient, bytes32 flowHash, int96 flowRate);
```

### getPoolAdjustmentFlowRate(address)

- **Signature**: `getPoolAdjustmentFlowRate(address)`
- **Visibility**: external
- **Source Range**: 38644:267:123
- **Details**: [function_getPoolAdjustmentFlowRate_address.md](./function_getPoolAdjustmentFlowRate_address.md)

**Signature:**
```solidity
function getPoolAdjustmentFlowRate(address pool) override external view returns (int96);
```

### isPool(contract ISuperfluidToken,address)

- **Signature**: `isPool(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 39837:142:123
- **Details**: [function_isPool_contract_ISuperfluidToken_address.md](./function_isPool_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function isPool(ISuperfluidToken token, address account) override external view returns (bool);
```

### getCodeAddress() (inherited from UUPSProxiable)

- **Signature**: `getCodeAddress()`
- **Visibility**: public
- **Source Range**: 401:122:169
- **Details**: [function_getCodeAddress.md](./function_getCodeAddress.md)

**Signature:**
```solidity
///  @dev Get current implementation code address.
function getCodeAddress() public view returns (address codeAddress);
```

### castrate() (inherited from UUPSProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 694:44:169
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```

### proxiableUUID() (inherited from AgreementBase)

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 555:145:119
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public view returns (bytes32);
```

### updateCode(address) (inherited from AgreementBase)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 706:192:119
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
function updateCode(address newAddress) override external;
```

### agreementType() (inherited from IGeneralDistributionAgreementV1)

- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 3054:168:133
- **Details**: [function_agreementType.md](./function_agreementType.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32);
```
