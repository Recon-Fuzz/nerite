# Contract: InstantDistributionAgreementV1

## Metadata

- **Name**: InstantDistributionAgreementV1
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol
- **Documentation**:  @title [DEPRECATED] InstantDistributionAgreementV1 contract
   @custom:deprecated Use GeneralDistributionAgreementV1 instead
   @author Superfluid
   @dev Please read IInstantDistributionAgreementV1 for implementation notes.
   @dev For more technical notes, please visit protocol-monorepo wiki area.
   Storage Layout Notes
   Agreement State
   NOTE The Agreement State slot is computed with the following function:
   keccak256(abi.encode("AgreementState", msg.sender, account, slotId))
   Publisher Deposit State Slot
   slotId           = _PUBLISHER_DEPOSIT_STATE_SLOT_ID or 1 << 32 or 4294967296
   msg.sender       = address of IDAv1
   account          = context.msgSender
   Publisher Deposit State stores deposit state for a publisher, this is the pending value.
   Subscriber Subscription Data Slot Id Start
   slotId           = _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START or 1 << 128 or 340282366920938463463374607431768211456
   msg.sender       = address of IDAv1
   account          = context.msgSender
   Subscriber Subscription Data Slot Id Start indicates the starting slot for where we begin to store the indexes a
   subscriber is a part of.
   Slots Bitmap Data Slot
   slotId           = _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID or 0
   msg.sender       = address of IDAv1
   account          = context.msgSender
   Slots Bitmap Data Slot stores the bitmap of the slots that are "enabled" for a subscriber.
   This is used as an optimization to only get the data (index id's) for the slots that are "enabled".
   Agreement Data
   NOTE The Agreement Data slot is calculated with the following function:
   keccak256(abi.encode("AgreementData", agreementClass, agreementId))
   agreementClass   = address of IDAv1
   agreementId      = PublisherId | SubscriptionId
   PublisherId      = keccak256(abi.encode("publisher", publisher, indexId))
   publisher        = "owner" of the index
   indexId          = arbitrary value for allowing multiple indexes by the same token-publisher pair
   PublisherId stores IndexData for an Index.
   SubscriptionId   = keccak256(abi.encode("subscriber", subscriber, iId))
   iId              = PublisherId, the index this particular subscriber is subscribed to
   SubscriptionId stores SubscriptionData for a subscriber to an Index.

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

### MAX_NUM_SUBSCRIPTIONS

```solidity
/// @dev Maximum number of subscriptions a subscriber can have
uint32 public constant MAX_NUM_SUBSCRIPTIONS = SlotsBitmapLibrary._MAX_NUM_SLOTS
```

### _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID

```solidity
/// @dev Subscriber state slot id for storing subs bitmap
uint256 private constant _SUBSCRIBER_SUBS_BITMAP_STATE_SLOT_ID = 0
```

### _PUBLISHER_DEPOSIT_STATE_SLOT_ID

```solidity
/// @dev Publisher state slot id for storing its deposit amount
uint256 private constant _PUBLISHER_DEPOSIT_STATE_SLOT_ID = 1 << 32
```

### _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START

```solidity
/// @dev Subscriber state slot id starting ptoint for subscription data
uint256 private constant _SUBSCRIBER_SUB_DATA_STATE_SLOT_ID_START = 1 << 128
```

### _UNALLOCATED_SUB_ID

```solidity
/// @dev A special id that indicating the subscription is not approved yet
uint32 private constant _UNALLOCATED_SUB_ID = type(uint32).max
```

## Structs

### IndexData

```solidity
/// @dev Agreement data for the index
struct IndexData {
    uint128 indexValue;
    uint128 totalUnitsApproved;
    uint128 totalUnitsPending;
}
```

### SubscriptionData

```solidity
/// @dev Agreement data for the subscription
struct SubscriptionData {
    uint32 subId;
    address publisher;
    uint32 indexId;
    uint128 indexValue;
    uint128 units;
}
```

### _SubscriptionOperationVars

```solidity
struct _SubscriptionOperationVars {
    bytes32 iId;
    bool subscriptionExists;
    bytes32 sId;
    IndexData idata;
    SubscriptionData sdata;
    bytes cbdata;
}
```

## Errors

### AGREEMENT_BASE_ONLY_HOST (inherited from AgreementBase)

```solidity
error AGREEMENT_BASE_ONLY_HOST();
```

### IDA_INDEX_SHOULD_GROW (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_INDEX_SHOULD_GROW();
```

### IDA_OPERATION_NOT_ALLOWED (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_OPERATION_NOT_ALLOWED();
```

### IDA_INDEX_ALREADY_EXISTS (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_INDEX_ALREADY_EXISTS();
```

### IDA_INDEX_DOES_NOT_EXIST (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_INDEX_DOES_NOT_EXIST();
```

### IDA_SUBSCRIPTION_DOES_NOT_EXIST (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_SUBSCRIPTION_DOES_NOT_EXIST();
```

### IDA_SUBSCRIPTION_ALREADY_APPROVED (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_SUBSCRIPTION_ALREADY_APPROVED();
```

### IDA_SUBSCRIPTION_IS_NOT_APPROVED (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_SUBSCRIPTION_IS_NOT_APPROVED();
```

### IDA_INSUFFICIENT_BALANCE (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_INSUFFICIENT_BALANCE();
```

### IDA_ZERO_ADDRESS_SUBSCRIBER (inherited from IInstantDistributionAgreementV1)

```solidity
error IDA_ZERO_ADDRESS_SUBSCRIBER();
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

### IndexCreated (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index created event
///  @param token Super token address
///  @param publisher Index creator and publisher
///  @param indexId The specified indexId of the newly created index
///  @param userData The user provided data
event IndexCreated(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, bytes userData);
```

### IndexUpdated (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index updated event
///  @param token Super token address
///  @param publisher Index updater and publisher
///  @param indexId The specified indexId of the updated index
///  @param oldIndexValue The previous index value
///  @param newIndexValue The updated index value
///  @param totalUnitsPending The total units pending when the indexValue was updated
///  @param totalUnitsApproved The total units approved when the indexValue was updated
///  @param userData The user provided data
event IndexUpdated(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, uint128 oldIndexValue, uint128 newIndexValue, uint128 totalUnitsPending, uint128 totalUnitsApproved, bytes userData);
```

### IndexSubscribed (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index subscribed event
///  @param token Super token address
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param subscriber The approved subscriber
///  @param userData The user provided data
event IndexSubscribed(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, address subscriber, bytes userData);
```

### SubscriptionApproved (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Subscription approved event
///  @param token Super token address
///  @param subscriber The approved subscriber
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param userData The user provided data
event SubscriptionApproved(ISuperfluidToken indexed token, address indexed subscriber, address publisher, uint32 indexId, bytes userData);
```

### IndexUnsubscribed (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index unsubscribed event
///  @param token Super token address
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param subscriber The unsubscribed subscriber
///  @param userData The user provided data
event IndexUnsubscribed(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, address subscriber, bytes userData);
```

### SubscriptionRevoked (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Subscription approved event
///  @param token Super token address
///  @param subscriber The approved subscriber
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param userData The user provided data
event SubscriptionRevoked(ISuperfluidToken indexed token, address indexed subscriber, address publisher, uint32 indexId, bytes userData);
```

### IndexUnitsUpdated (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index units updated event
///  @param token Super token address
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param subscriber The subscriber units updated
///  @param units The new units amount
///  @param userData The user provided data
event IndexUnitsUpdated(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, address subscriber, uint128 units, bytes userData);
```

### SubscriptionUnitsUpdated (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Subscription units updated event
///  @param token Super token address
///  @param subscriber The subscriber units updated
///  @param indexId The specified indexId
///  @param publisher Index publisher
///  @param units The new units amount
///  @param userData The user provided data
event SubscriptionUnitsUpdated(ISuperfluidToken indexed token, address indexed subscriber, address publisher, uint32 indexId, uint128 units, bytes userData);
```

### IndexDistributionClaimed (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Index distribution claimed event
///  @param token Super token address
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param subscriber The subscriber units updated
///  @param amount The pending amount claimed
event IndexDistributionClaimed(ISuperfluidToken indexed token, address indexed publisher, uint32 indexed indexId, address subscriber, uint256 amount);
```

### SubscriptionDistributionClaimed (inherited from IInstantDistributionAgreementV1)

```solidity
///  @dev Subscription distribution claimed event
///  @param token Super token address
///  @param subscriber The subscriber units updated
///  @param publisher Index publisher
///  @param indexId The specified indexId
///  @param amount The pending amount claimed
event SubscriptionDistributionClaimed(ISuperfluidToken indexed token, address indexed subscriber, address publisher, uint32 indexId, uint256 amount);
```

## Public/External Functions

### constructor(contract ISuperfluid)

- **Signature**: `constructor(contract ISuperfluid)`
- **Visibility**: public
- **Source Range**: 3876:61:122
- **Details**: [function_constructor_contract_ISuperfluid.md](./function_constructor_contract_ISuperfluid.md)

**Signature:**
```solidity
constructor(ISuperfluid host) AgreementBase(address(host));
```

### realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: external
- **Source Range**: 4580:1711:122
- **Details**: [function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md](./function_realtimeBalanceOf_contract_ISuperfluidToken_address_uint256.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.realtimeBalanceOf implementation
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256) override external view returns (int256 dynamicBalance, uint256 deposit, uint256 owedDeposit);
```

### createIndex(contract ISuperfluidToken,uint32,bytes)

- **Signature**: `createIndex(contract ISuperfluidToken,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 6554:697:122
- **Details**: [function_createIndex_contract_ISuperfluidToken_uint32_bytes.md](./function_createIndex_contract_ISuperfluidToken_uint32_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.createIndex implementation
function createIndex(ISuperfluidToken token, uint32 indexId, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### getIndex(contract ISuperfluidToken,address,uint32)

- **Signature**: `getIndex(contract ISuperfluidToken,address,uint32)`
- **Visibility**: external
- **Source Range**: 7326:635:122
- **Details**: [function_getIndex_contract_ISuperfluidToken_address_uint32.md](./function_getIndex_contract_ISuperfluidToken_address_uint32.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.getIndex implementation
function getIndex(ISuperfluidToken token, address publisher, uint32 indexId) override external view returns (bool exist, uint128 indexValue, uint128 totalUnitsApproved, uint128 totalUnitsPending);
```

### calculateDistribution(contract ISuperfluidToken,address,uint32,uint256)

- **Signature**: `calculateDistribution(contract ISuperfluidToken,address,uint32,uint256)`
- **Visibility**: external
- **Source Range**: 8049:727:122
- **Details**: [function_calculateDistribution_contract_ISuperfluidToken_address_uint32_uint256.md](./function_calculateDistribution_contract_ISuperfluidToken_address_uint32_uint256.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.calculateDistribution implementation
function calculateDistribution(ISuperfluidToken token, address publisher, uint32 indexId, uint256 amount) override external view returns (uint256 actualAmount, uint128 newIndexValue);
```

### updateIndex(contract ISuperfluidToken,uint32,uint128,bytes)

- **Signature**: `updateIndex(contract ISuperfluidToken,uint32,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 8854:678:122
- **Details**: [function_updateIndex_contract_ISuperfluidToken_uint32_uint128_bytes.md](./function_updateIndex_contract_ISuperfluidToken_uint32_uint128_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.updateIndex implementation
function updateIndex(ISuperfluidToken token, uint32 indexId, uint128 indexValue, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### distribute(contract ISuperfluidToken,uint32,uint256,bytes)

- **Signature**: `distribute(contract ISuperfluidToken,uint32,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 9609:818:122
- **Details**: [function_distribute_contract_ISuperfluidToken_uint32_uint256_bytes.md](./function_distribute_contract_ISuperfluidToken_uint32_uint256_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.distribute implementation
function distribute(ISuperfluidToken token, uint32 indexId, uint256 amount, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### approveSubscription(contract ISuperfluidToken,address,uint32,bytes)

- **Signature**: `approveSubscription(contract ISuperfluidToken,address,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 13015:3696:122
- **Details**: [function_approveSubscription_contract_ISuperfluidToken_address_uint32_bytes.md](./function_approveSubscription_contract_ISuperfluidToken_address_uint32_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.approveSubscription implementation
function approveSubscription(ISuperfluidToken token, address publisher, uint32 indexId, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### revokeSubscription(contract ISuperfluidToken,address,uint32,bytes)

- **Signature**: `revokeSubscription(contract ISuperfluidToken,address,uint32,bytes)`
- **Visibility**: external
- **Source Range**: 16796:2655:122
- **Details**: [function_revokeSubscription_contract_ISuperfluidToken_address_uint32_bytes.md](./function_revokeSubscription_contract_ISuperfluidToken_address_uint32_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.revokeSubscription implementation
function revokeSubscription(ISuperfluidToken token, address publisher, uint32 indexId, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### updateSubscription(contract ISuperfluidToken,uint32,address,uint128,bytes)

- **Signature**: `updateSubscription(contract ISuperfluidToken,uint32,address,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 19536:4738:122
- **Details**: [function_updateSubscription_contract_ISuperfluidToken_uint32_address_uint128_bytes.md](./function_updateSubscription_contract_ISuperfluidToken_uint32_address_uint128_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.updateSubscription implementation
function updateSubscription(ISuperfluidToken token, uint32 indexId, address subscriber, uint128 units, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### getSubscription(contract ISuperfluidToken,address,uint32,address)

- **Signature**: `getSubscription(contract ISuperfluidToken,address,uint32,address)`
- **Visibility**: external
- **Source Range**: 24356:864:122
- **Details**: [function_getSubscription_contract_ISuperfluidToken_address_uint32_address.md](./function_getSubscription_contract_ISuperfluidToken_address_uint32_address.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.getSubscription implementation
function getSubscription(ISuperfluidToken token, address publisher, uint32 indexId, address subscriber) override external view returns (bool exist, bool approved, uint128 units, uint256 pendingDistribution);
```

### getSubscriptionByID(contract ISuperfluidToken,bytes32)

- **Signature**: `getSubscriptionByID(contract ISuperfluidToken,bytes32)`
- **Visibility**: external
- **Source Range**: 25306:982:122
- **Details**: [function_getSubscriptionByID_contract_ISuperfluidToken_bytes32.md](./function_getSubscriptionByID_contract_ISuperfluidToken_bytes32.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.getSubscriptionByID implementation
function getSubscriptionByID(ISuperfluidToken token, bytes32 agreementId) override external view returns (address publisher, uint32 indexId, bool approved, uint128 units, uint256 pendingDistribution);
```

### listSubscriptions(contract ISuperfluidToken,address)

- **Signature**: `listSubscriptions(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 26372:1018:122
- **Details**: [function_listSubscriptions_contract_ISuperfluidToken_address.md](./function_listSubscriptions_contract_ISuperfluidToken_address.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.listSubscriptions implementation
function listSubscriptions(ISuperfluidToken token, address subscriber) override external view returns (address[] memory publishers, uint32[] memory indexIds, uint128[] memory unitsList);
```

### deleteSubscription(contract ISuperfluidToken,address,uint32,address,bytes)

- **Signature**: `deleteSubscription(contract ISuperfluidToken,address,uint32,address,bytes)`
- **Visibility**: external
- **Source Range**: 27475:3261:122
- **Details**: [function_deleteSubscription_contract_ISuperfluidToken_address_uint32_address_bytes.md](./function_deleteSubscription_contract_ISuperfluidToken_address_uint32_address_bytes.md)

**Signature:**
```solidity
/// @dev IInstantDistributionAgreementV1.deleteSubscription implementation
function deleteSubscription(ISuperfluidToken token, address publisher, uint32 indexId, address subscriber, bytes calldata ctx) override external returns (bytes memory newCtx);
```

### claim(contract ISuperfluidToken,address,uint32,address,bytes)

- **Signature**: `claim(contract ISuperfluidToken,address,uint32,address,bytes)`
- **Visibility**: external
- **Source Range**: 30742:2337:122
- **Details**: [function_claim_contract_ISuperfluidToken_address_uint32_address_bytes.md](./function_claim_contract_ISuperfluidToken_address_uint32_address_bytes.md)

**Signature:**
```solidity
function claim(ISuperfluidToken token, address publisher, uint32 indexId, address subscriber, bytes calldata ctx) override external returns (bytes memory newCtx);
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

### agreementType() (inherited from IInstantDistributionAgreementV1)

- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 2717:168:132
- **Details**: [function_agreementType.md](./function_agreementType.md)

**Signature:**
```solidity
/// @dev ISuperAgreement.agreementType implementation
function agreementType() override external pure returns (bytes32);
```
