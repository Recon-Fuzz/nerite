# Contract: SuperfluidPool

## Metadata

- **Name**: SuperfluidPool
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPool.sol
- **Documentation**:  @title SuperfluidPool
   @author Superfluid
   @notice A SuperfluidPool which can be used to distribute any SuperToken.
   @dev Because we are using uint128, uint256 doesn't work here.

## Implements Interfaces

- **ISuperfluidPool** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/ISuperfluidPool.sol/interface_ISuperfluidPool.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

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

### _DEFAULT_ERC20_NAME

```solidity
string internal constant _DEFAULT_ERC20_NAME = "Superfluid Pool"
```

### _DEFAULT_ERC20_SYMBOL

```solidity
string internal constant _DEFAULT_ERC20_SYMBOL = "POOL"
```

### GDA

```solidity
GeneralDistributionAgreementV1 public immutable GDA
```

**GeneralDistributionAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

### superToken

```solidity
ISuperfluidToken public superToken
```

**ISuperfluidToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]

### admin

```solidity
address public admin
```

### _index

```solidity
PoolIndexData internal _index
```

### _membersData

```solidity
mapping(address => MemberData) internal _membersData
```

### _disconnectedMembers

```solidity
/// @dev This is a pseudo member, representing all the disconnected members
MemberData internal _disconnectedMembers
```

### _allowances

```solidity
/// @dev owner => (spender => amount)
mapping(address => mapping(address => uint256)) internal _allowances
```

### transferabilityForUnitsOwner

```solidity
/// @inheritdoc ISuperfluidPool
bool public transferabilityForUnitsOwner
```

### distributionFromAnyAddress

```solidity
/// @inheritdoc ISuperfluidPool
bool public distributionFromAnyAddress
```

### _erc20Name

```solidity
string internal _erc20Name
```

### _erc20Symbol

```solidity
string internal _erc20Symbol
```

### _erc20Decimals

```solidity
uint8 internal _erc20Decimals
```

## Structs

### PoolIndexData

```solidity
struct PoolIndexData {
    uint128 totalUnits;
    uint32 wrappedSettledAt;
    int96 wrappedFlowRate;
    int256 wrappedSettledValue;
}
```

### MemberData

```solidity
struct MemberData {
    uint128 ownedUnits;
    uint32 syncedSettledAt;
    int96 syncedFlowRate;
    int256 syncedSettledValue;
    int256 settledValue;
    int256 claimedValue;
}
```

## Errors

### SUPERFLUID_POOL_INVALID_TIME (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_INVALID_TIME();
```

### SUPERFLUID_POOL_NO_POOL_MEMBERS (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_NO_POOL_MEMBERS();
```

### SUPERFLUID_POOL_NO_ZERO_ADDRESS (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_NO_ZERO_ADDRESS();
```

### SUPERFLUID_POOL_NOT_POOL_ADMIN_OR_GDA (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_NOT_POOL_ADMIN_OR_GDA();
```

### SUPERFLUID_POOL_NOT_GDA (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_NOT_GDA();
```

### SUPERFLUID_POOL_TRANSFER_UNITS_NOT_ALLOWED (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_TRANSFER_UNITS_NOT_ALLOWED();
```

### SUPERFLUID_POOL_SELF_TRANSFER_NOT_ALLOWED (inherited from ISuperfluidPool)

```solidity
error SUPERFLUID_POOL_SELF_TRANSFER_NOT_ALLOWED();
```

## Events

### Transfer (inherited from IERC20)

```solidity
///  @dev Emitted when `value` tokens are moved from one account (`from`) to
///  another (`to`).
///  Note that `value` may be zero.
event Transfer(address indexed from, address indexed to, uint256 value);
```

### Approval (inherited from IERC20)

```solidity
///  @dev Emitted when the allowance of a `spender` for an `owner` is set by
///  a call to {approve}. `value` is the new allowance.
event Approval(address indexed owner, address indexed spender, uint256 value);
```

### MemberUnitsUpdated (inherited from ISuperfluidPool)

```solidity
event MemberUnitsUpdated(ISuperfluidToken indexed token, address indexed member, uint128 oldUnits, uint128 newUnits);
```

### DistributionClaimed (inherited from ISuperfluidPool)

```solidity
event DistributionClaimed(ISuperfluidToken indexed token, address indexed member, int256 claimedAmount, int256 totalClaimed);
```

### Initialized (inherited from Initializable)

```solidity
///  @dev Triggered when the contract has been initialized or reinitialized.
event Initialized(uint8 version);
```

## Public/External Functions

### constructor(contract GeneralDistributionAgreementV1)

- **Signature**: `constructor(contract GeneralDistributionAgreementV1)`
- **Visibility**: public
- **Source Range**: 3939:74:127
- **Details**: [function_constructor_contract_GeneralDistributionAgreementV1.md](./function_constructor_contract_GeneralDistributionAgreementV1.md)

**Signature:**
```solidity
constructor(GeneralDistributionAgreementV1 gda);
```

### initialize(address,contract ISuperfluidToken,bool,bool,string,string,uint8)

- **Signature**: `initialize(address,contract ISuperfluidToken,bool,bool,string,string,uint8)`
- **Visibility**: external
- **Source Range**: 4019:607:127
- **Details**: [function_initialize_address_contract_ISuperfluidToken_bool_bool_string_string_uint8.md](./function_initialize_address_contract_ISuperfluidToken_bool_bool_string_string_uint8.md)

**Signature:**
```solidity
function initialize(address admin_, ISuperfluidToken superToken_, bool transferabilityForUnitsOwner_, bool distributionFromAnyAddress_, string memory erc20Name_, string memory erc20Symbol_, uint8 erc20Decimals_) external initializer();
```

### proxiableUUID()

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 4632:163:127
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() override public pure returns (bytes32);
```

### poolOperatorGetIndex()

- **Signature**: `poolOperatorGetIndex()`
- **Visibility**: external
- **Source Range**: 4877:107:127
- **Details**: [function_poolOperatorGetIndex.md](./function_poolOperatorGetIndex.md)

**Signature:**
```solidity
/// @dev This function is only meant to be called by the GDAv1 contract
function poolOperatorGetIndex() external view returns (PoolIndexData memory);
```

### getTotalUnits()

- **Signature**: `getTotalUnits()`
- **Visibility**: external
- **Source Range**: 5026:106:127
- **Details**: [function_getTotalUnits.md](./function_getTotalUnits.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalUnits() override external view returns (uint128);
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 5270:143:127
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function allowance(address owner, address spender) override external view returns (uint256);
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 5446:158:127
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc IERC20
function approve(address spender, uint256 amount) override external returns (bool);
```

### increaseAllowance(address,uint256)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 5646:202:127
- **Details**: [function_increaseAllowance_address_uint256.md](./function_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function increaseAllowance(address spender, uint256 addedValue) external returns (bool);
```

### decreaseAllowance(address,uint256)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 5890:212:127
- **Details**: [function_decreaseAllowance_address_uint256.md](./function_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 6354:151:127
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
/// @dev Transfers `amount` units from `msg.sender` to `to`
function transfer(address to, uint256 amount) override external returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 6569:387:127
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
/// @dev Transfers `amount` units from `from` to `to`
function transferFrom(address from, address to, uint256 amount) override external returns (bool);
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 7634:104:127
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
/// @notice Returns the total number of units for a pool
function totalSupply() override external view returns (uint256);
```

### getTotalConnectedUnits()

- **Signature**: `getTotalConnectedUnits()`
- **Visibility**: external
- **Source Range**: 7780:150:127
- **Details**: [function_getTotalConnectedUnits.md](./function_getTotalConnectedUnits.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalConnectedUnits() override external view returns (uint128);
```

### getTotalDisconnectedUnits()

- **Signature**: `getTotalDisconnectedUnits()`
- **Visibility**: external
- **Source Range**: 7972:133:127
- **Details**: [function_getTotalDisconnectedUnits.md](./function_getTotalDisconnectedUnits.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalDisconnectedUnits() override external view returns (uint128);
```

### getUnits(address)

- **Signature**: `getUnits(address)`
- **Visibility**: external
- **Source Range**: 8147:124:127
- **Details**: [function_getUnits_address.md](./function_getUnits_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getUnits(address memberAddr) override external view returns (uint128);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 8771:128:127
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
/// @notice Returns the total number of units for an account for this pool
///  @dev Although the type is uint256, this can never be greater than type(int128).max
///  because the custom user type Unit is int128 in the SemanticMoney library
///  @param account The account to query
///  @return The total number of owned units of the account
function balanceOf(address account) override external view returns (uint256);
```

### getTotalFlowRate()

- **Signature**: `getTotalFlowRate()`
- **Visibility**: external
- **Source Range**: 8941:110:127
- **Details**: [function_getTotalFlowRate.md](./function_getTotalFlowRate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalFlowRate() override external view returns (int96);
```

### getTotalConnectedFlowRate()

- **Signature**: `getTotalConnectedFlowRate()`
- **Visibility**: external
- **Source Range**: 9256:153:127
- **Details**: [function_getTotalConnectedFlowRate.md](./function_getTotalConnectedFlowRate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalConnectedFlowRate() override external view returns (int96);
```

### getTotalDisconnectedFlowRate()

- **Signature**: `getTotalDisconnectedFlowRate()`
- **Visibility**: external
- **Source Range**: 9842:143:127
- **Details**: [function_getTotalDisconnectedFlowRate.md](./function_getTotalDisconnectedFlowRate.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalDisconnectedFlowRate() override external view returns (int96 flowRate);
```

### getDisconnectedBalance(uint32)

- **Signature**: `getDisconnectedBalance(uint32)`
- **Visibility**: external
- **Source Range**: 10027:362:127
- **Details**: [function_getDisconnectedBalance_uint32.md](./function_getDisconnectedBalance_uint32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getDisconnectedBalance(uint32 time) override external view returns (int256 balance);
```

### getTotalAmountReceivedByMember(address)

- **Signature**: `getTotalAmountReceivedByMember(address)`
- **Visibility**: external
- **Source Range**: 10431:549:127
- **Details**: [function_getTotalAmountReceivedByMember_address.md](./function_getTotalAmountReceivedByMember_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getTotalAmountReceivedByMember(address memberAddr) override external view returns (uint256);
```

### getMemberFlowRate(address)

- **Signature**: `getMemberFlowRate(address)`
- **Visibility**: external
- **Source Range**: 11022:321:127
- **Details**: [function_getMemberFlowRate_address.md](./function_getMemberFlowRate_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getMemberFlowRate(address memberAddr) override external view returns (int96);
```

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 11384:149:127
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
/// @inheritdoc IERC20Metadata
function name() override external view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 11574:144:127
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
/// @inheritdoc IERC20Metadata
function symbol() override external view returns (string memory);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 11759:97:127
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
/// @inheritdoc IERC20Metadata
function decimals() override external view returns (uint8);
```

### getClaimableNow(address)

- **Signature**: `getClaimableNow(address)`
- **Visibility**: external
- **Source Range**: 13823:301:127
- **Details**: [function_getClaimableNow_address.md](./function_getClaimableNow_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getClaimableNow(address memberAddr) override external view returns (int256 claimableBalance, uint256 timestamp);
```

### getClaimable(address,uint32)

- **Signature**: `getClaimable(address,uint32)`
- **Visibility**: public
- **Source Range**: 14166:460:127
- **Details**: [function_getClaimable_address_uint32.md](./function_getClaimable_address_uint32.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function getClaimable(address memberAddr, uint32 time) override public view returns (int256);
```

### updateMemberUnits(address,uint128)

- **Signature**: `updateMemberUnits(address,uint128)`
- **Visibility**: external
- **Source Range**: 14668:280:127
- **Details**: [function_updateMemberUnits_address_uint128.md](./function_updateMemberUnits_address_uint128.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function updateMemberUnits(address memberAddr, uint128 newUnits) external returns (bool);
```

### claimAll()

- **Signature**: `claimAll()`
- **Visibility**: external
- **Source Range**: 19258:88:127
- **Details**: [function_claimAll.md](./function_claimAll.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function claimAll() external returns (bool);
```

### claimAll(address)

- **Signature**: `claimAll(address)`
- **Visibility**: public
- **Source Range**: 19388:450:127
- **Details**: [function_claimAll_address.md](./function_claimAll_address.md)

**Signature:**
```solidity
/// @inheritdoc ISuperfluidPool
function claimAll(address memberAddr) public returns (bool);
```

### operatorSetIndex(struct PDPoolIndex)

- **Signature**: `operatorSetIndex(struct PDPoolIndex)`
- **Visibility**: external
- **Source Range**: 19844:168:127
- **Details**: [function_operatorSetIndex_struct_PDPoolIndex.md](./function_operatorSetIndex_struct_PDPoolIndex.md)

**Signature:**
```solidity
function operatorSetIndex(PDPoolIndex calldata index) external onlyGDA() returns (bool);
```

### operatorConnectMember(address,bool,uint32)

- **Signature**: `operatorConnectMember(address,bool,uint32)`
- **Visibility**: external
- **Source Range**: 20120:516:127
- **Details**: [function_operatorConnectMember_address_bool_uint32.md](./function_operatorConnectMember_address_bool_uint32.md)

**Signature:**
```solidity
function operatorConnectMember(address memberAddr, bool doConnect, uint32 time) external onlyGDA() returns (bool);
```

### castrate() (inherited from BeaconProxiable)

- **Signature**: `castrate()`
- **Visibility**: external
- **Source Range**: 309:44:167
- **Details**: [function_castrate.md](./function_castrate.md)

**Signature:**
```solidity
function castrate() external initializer();
```
