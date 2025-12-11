# Contract: SuperToken

## Metadata

- **Name**: SuperToken
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol
- **Documentation**:  @title Superfluid's super token implementation
   @author Superfluid

## Implements Interfaces

- **ISuperToken** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **IERC777** [lib/openzeppelin-contracts/contracts/token/ERC777/IERC777.sol/interface_IERC777.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **ISuperfluidToken** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]

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

### _REWARD_ADDRESS_CONFIG_KEY (inherited from SuperfluidToken)

```solidity
bytes32 private constant _REWARD_ADDRESS_CONFIG_KEY = keccak256("org.superfluid-finance.superfluid.rewardAddress")
```

### _host (inherited from SuperfluidToken)

```solidity
/// @dev Superfluid contract
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### _inactiveAgreementBitmap (inherited from SuperfluidToken)

```solidity
/// @dev Active agreement bitmap
mapping(address => uint256) internal _inactiveAgreementBitmap
```

### _sharedSettledBalances (inherited from SuperfluidToken)

```solidity
/// @dev Shared Settled balance for the account
mapping(address => int256) internal _sharedSettledBalances
```

### _totalSupply (inherited from SuperfluidToken)

```solidity
/// @dev Total supply
uint256 internal _totalSupply
```

### _reserve4 (inherited from SuperfluidToken)

```solidity
uint256 internal _reserve4
```

### _reserve5 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve5
```

### _reserve6 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve6
```

### _reserve7 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve7
```

### _reserve8 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve8
```

### _reserve9 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve9
```

### _reserve10 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve10
```

### _reserve11 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve11
```

### _reserve12 (inherited from SuperfluidToken)

```solidity
uint256 private _reserve12
```

### _reserve13 (inherited from SuperfluidToken)

```solidity
uint256 internal _reserve13
```

### _ADMIN_SLOT

```solidity
bytes32 private constant _ADMIN_SLOT = 0xb53127684a568b3173ae13b9f8a6016e243e63b6e8ee1178d6a717850b5d6103
```

### _STANDARD_DECIMALS

```solidity
uint8 private constant _STANDARD_DECIMALS = 18
```

### CONSTANT_OUTFLOW_NFT

```solidity
IConstantOutflowNFT public immutable CONSTANT_OUTFLOW_NFT
```

**IConstantOutflowNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantOutflowNFT.md]

### CONSTANT_INFLOW_NFT

```solidity
IConstantInflowNFT public immutable CONSTANT_INFLOW_NFT
```

**IConstantInflowNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantInflowNFT.md]

### POOL_MEMBER_NFT

```solidity
IPoolMemberNFT public immutable POOL_MEMBER_NFT
```

**IPoolMemberNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolMemberNFT.sol/interface_IPoolMemberNFT.md]

### POOL_ADMIN_NFT

```solidity
IPoolAdminNFT public immutable POOL_ADMIN_NFT
```

**IPoolAdminNFT**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]

### _underlyingToken

```solidity
/// @dev The underlying ERC20 token
IERC20 internal _underlyingToken
```

**IERC20**: [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

### _underlyingDecimals

```solidity
/// @dev Decimals of the underlying token
uint8 internal _underlyingDecimals
```

### _name

```solidity
/// @dev IERC20Metadata Name property
string internal _name
```

### _symbol

```solidity
/// @dev IERC20Metadata Symbol property
string internal _symbol
```

### _allowances

```solidity
/// @dev ERC20 Allowances Storage
mapping(address => mapping(address => uint256)) internal _allowances
```

### _operators

```solidity
/// @dev ERC777 operators support data
ERC777Helper.Operators internal _operators
```

### _reserve22

```solidity
uint256 internal _reserve22
```

### _reserve23

```solidity
uint256 private _reserve23
```

### _reserve24

```solidity
uint256 private _reserve24
```

### _reserve25

```solidity
uint256 private _reserve25
```

### _reserve26

```solidity
uint256 private _reserve26
```

### _reserve27

```solidity
uint256 private _reserve27
```

### _reserve28

```solidity
uint256 private _reserve28
```

### _reserve29

```solidity
uint256 private _reserve29
```

### _reserve30

```solidity
uint256 private _reserve30
```

### _reserve31

```solidity
uint256 internal _reserve31
```

## Structs

### LiquidationTypeData (inherited from ISuperfluidToken)

```solidity
///  @dev Encoded liquidation type data mainly used for handling stack to deep errors
///  @custom:note 
///  - version: 1
///  - liquidationType key:
///     - 0 = reward account receives reward (PIC period)
///     - 1 = liquidator account receives reward (Pleb period)
///     - 2 = liquidator account receives reward (Pirate period/bailout)
struct LiquidationTypeData {
    uint256 version;
    uint8 liquidationType;
}
```

## Errors

### SF_TOKEN_AGREEMENT_ALREADY_EXISTS (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_AGREEMENT_ALREADY_EXISTS();
```

### SF_TOKEN_AGREEMENT_DOES_NOT_EXIST (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_AGREEMENT_DOES_NOT_EXIST();
```

### SF_TOKEN_BURN_INSUFFICIENT_BALANCE (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_BURN_INSUFFICIENT_BALANCE();
```

### SF_TOKEN_MOVE_INSUFFICIENT_BALANCE (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_MOVE_INSUFFICIENT_BALANCE();
```

### SF_TOKEN_ONLY_LISTED_AGREEMENT (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_ONLY_LISTED_AGREEMENT();
```

### SF_TOKEN_ONLY_HOST (inherited from ISuperfluidToken)

```solidity
error SF_TOKEN_ONLY_HOST();
```

### SUPER_TOKEN_CALLER_IS_NOT_OPERATOR_FOR_HOLDER (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_CALLER_IS_NOT_OPERATOR_FOR_HOLDER();
```

### SUPER_TOKEN_NOT_ERC777_TOKENS_RECIPIENT (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_NOT_ERC777_TOKENS_RECIPIENT();
```

### SUPER_TOKEN_INFLATIONARY_DEFLATIONARY_NOT_SUPPORTED (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_INFLATIONARY_DEFLATIONARY_NOT_SUPPORTED();
```

### SUPER_TOKEN_NO_UNDERLYING_TOKEN (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_NO_UNDERLYING_TOKEN();
```

### SUPER_TOKEN_ONLY_SELF (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_ONLY_SELF();
```

### SUPER_TOKEN_ONLY_ADMIN (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_ONLY_ADMIN();
```

### SUPER_TOKEN_ONLY_GOV_OWNER (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_ONLY_GOV_OWNER();
```

### SUPER_TOKEN_APPROVE_FROM_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_APPROVE_FROM_ZERO_ADDRESS();
```

### SUPER_TOKEN_APPROVE_TO_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_APPROVE_TO_ZERO_ADDRESS();
```

### SUPER_TOKEN_BURN_FROM_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_BURN_FROM_ZERO_ADDRESS();
```

### SUPER_TOKEN_MINT_TO_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_MINT_TO_ZERO_ADDRESS();
```

### SUPER_TOKEN_TRANSFER_FROM_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_TRANSFER_FROM_ZERO_ADDRESS();
```

### SUPER_TOKEN_TRANSFER_TO_ZERO_ADDRESS (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_TRANSFER_TO_ZERO_ADDRESS();
```

### SUPER_TOKEN_NFT_PROXY_ADDRESS_CHANGED (inherited from ISuperToken)

```solidity
error SUPER_TOKEN_NFT_PROXY_ADDRESS_CHANGED();
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

### AgreementCreated (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement created event
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @param data Agreement data
event AgreementCreated(address indexed agreementClass, bytes32 id, bytes32[] data);
```

### AgreementUpdated (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement updated event
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @param data Agreement data
event AgreementUpdated(address indexed agreementClass, bytes32 id, bytes32[] data);
```

### AgreementTerminated (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement terminated event
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
event AgreementTerminated(address indexed agreementClass, bytes32 id);
```

### AgreementStateUpdated (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement account state updated event
///  @param agreementClass Contract address of the agreement
///  @param account Account updated
///  @param slotId slot id of the agreement state
event AgreementStateUpdated(address indexed agreementClass, address indexed account, uint256 slotId);
```

### AgreementLiquidatedV2 (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement liquidation event v2 (including agent account)
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @param liquidatorAccount Address of the executor of the liquidation
///  @param targetAccount Account of the stream sender
///  @param rewardAmountReceiver Account that collects the reward or bails out insolvent accounts
///  @param rewardAmount The amount the reward recipient account balance should change by
///  @param targetAccountBalanceDelta The amount the sender account balance should change by
///  @param liquidationTypeData The encoded liquidation type data including the version (how to decode)
///  @custom:note 
///  Reward account rule:
///  - if the agreement is liquidated during the PIC period
///    - the rewardAmountReceiver will get the rewardAmount (remaining deposit), regardless of the liquidatorAccount
///    - the targetAccount will pay for the rewardAmount
///  - if the agreement is liquidated after the PIC period AND the targetAccount is solvent
///    - the rewardAmountReceiver will get the rewardAmount (remaining deposit)
///    - the targetAccount will pay for the rewardAmount
///  - if the targetAccount is insolvent
///    - the liquidatorAccount will get the rewardAmount (single deposit)
///    - the default reward account (governance) will pay for both the rewardAmount and bailoutAmount
///    - the targetAccount will receive the bailoutAmount
event AgreementLiquidatedV2(address indexed agreementClass, bytes32 id, address indexed liquidatorAccount, address indexed targetAccount, address rewardAmountReceiver, uint256 rewardAmount, int256 targetAccountBalanceDelta, bytes liquidationTypeData);
```

### AgreementLiquidated (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement liquidation event (DEPRECATED BY AgreementLiquidatedBy)
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @param penaltyAccount Account of the agreement to be penalized
///  @param rewardAccount Account that collect the reward
///  @param rewardAmount Amount of liquidation reward
///  @custom:deprecated Use AgreementLiquidatedV2 instead
event AgreementLiquidated(address indexed agreementClass, bytes32 id, address indexed penaltyAccount, address indexed rewardAccount, uint256 rewardAmount);
```

### Bailout (inherited from ISuperfluidToken)

```solidity
///  @dev System bailout occurred (DEPRECATED BY AgreementLiquidatedBy)
///  @param bailoutAccount Account that bailout the penalty account
///  @param bailoutAmount Amount of account bailout
///  @custom:deprecated Use AgreementLiquidatedV2 instead
event Bailout(address indexed bailoutAccount, uint256 bailoutAmount);
```

### AgreementLiquidatedBy (inherited from ISuperfluidToken)

```solidity
///  @dev Agreement liquidation event (DEPRECATED BY AgreementLiquidatedV2)
///  @param liquidatorAccount Account of the agent that performed the liquidation.
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @param penaltyAccount Account of the agreement to be penalized
///  @param bondAccount Account that collect the reward or bailout accounts
///  @param rewardAmount Amount of liquidation reward
///  @param bailoutAmount Amount of liquidation bailouot
///  @custom:deprecated Use AgreementLiquidatedV2 instead
///  @custom:note 
///  Reward account rule:
///  - if bailout is equal to 0, then
///    - the bondAccount will get the rewardAmount,
///    - the penaltyAccount will pay for the rewardAmount.
///  - if bailout is larger than 0, then
///    - the liquidatorAccount will get the rewardAmouont,
///    - the bondAccount will pay for both the rewardAmount and bailoutAmount,
///    - the penaltyAccount will pay for the rewardAmount while get the bailoutAmount.
event AgreementLiquidatedBy(address liquidatorAccount, address indexed agreementClass, bytes32 id, address indexed penaltyAccount, address indexed bondAccount, uint256 rewardAmount, uint256 bailoutAmount);
```

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

### Minted (inherited from IERC777)

```solidity
///  @dev Emitted when `amount` tokens are created by `operator` and assigned to `to`.
///  Note that some additional user `data` and `operatorData` can be logged in the event.
event Minted(address indexed operator, address indexed to, uint256 amount, bytes data, bytes operatorData);
```

### Burned (inherited from IERC777)

```solidity
///  @dev Emitted when `operator` destroys `amount` tokens from `account`.
///  Note that some additional user `data` and `operatorData` can be logged in the event.
event Burned(address indexed operator, address indexed from, uint256 amount, bytes data, bytes operatorData);
```

### AuthorizedOperator (inherited from IERC777)

```solidity
///  @dev Emitted when `operator` is made operator for `tokenHolder`.
event AuthorizedOperator(address indexed operator, address indexed tokenHolder);
```

### RevokedOperator (inherited from IERC777)

```solidity
///  @dev Emitted when `operator` is revoked its operator status for `tokenHolder`.
event RevokedOperator(address indexed operator, address indexed tokenHolder);
```

### Sent (inherited from IERC777)

```solidity
event Sent(address indexed operator, address indexed from, address indexed to, uint256 amount, bytes data, bytes operatorData);
```

### AdminChanged (inherited from ISuperToken)

```solidity
event AdminChanged(address indexed oldAdmin, address indexed newAdmin);
```

### TokenUpgraded (inherited from ISuperToken)

```solidity
///  @dev Token upgrade event
///  @param account Account where tokens are upgraded to
///  @param amount Amount of tokens upgraded (in 18 decimals)
event TokenUpgraded(address indexed account, uint256 amount);
```

### TokenDowngraded (inherited from ISuperToken)

```solidity
///  @dev Token downgrade event
///  @param account Account whose tokens are downgraded
///  @param amount Amount of tokens downgraded
event TokenDowngraded(address indexed account, uint256 amount);
```

### PoolAdminNFTCreated (inherited from ISuperToken)

```solidity
///  @dev Pool Admin NFT proxy created event
///  @param poolAdminNFT pool admin nft address
event PoolAdminNFTCreated(IPoolAdminNFT indexed poolAdminNFT);
```

### PoolMemberNFTCreated (inherited from ISuperToken)

```solidity
///  @dev Pool Member NFT proxy created event
///  @param poolMemberNFT pool member nft address
event PoolMemberNFTCreated(IPoolMemberNFT indexed poolMemberNFT);
```

## Public/External Functions

### constructor(contract ISuperfluid,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)

- **Signature**: `constructor(contract ISuperfluid,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: public
- **Source Range**: 3890:753:161
- **Details**: [function_constructor_contract_ISuperfluid_contract_IConstantOutflowNFT_contract_IConstantInflowNFT_contract_IPoolAdminNFT_contract_IPoolMemberNFT.md](./function_constructor_contract_ISuperfluid_contract_IConstantOutflowNFT_contract_IConstantInflowNFT_contract_IPoolAdminNFT_contract_IPoolMemberNFT.md)

**Signature:**
```solidity
constructor(ISuperfluid host, IConstantOutflowNFT constantOutflowNFT, IConstantInflowNFT constantInflowNFT, IPoolAdminNFT poolAdminNFT, IPoolMemberNFT poolMemberNFT) SuperfluidToken(host);
```

### initialize(contract IERC20,uint8,string,string)

- **Signature**: `initialize(contract IERC20,uint8,string,string)`
- **Visibility**: external
- **Source Range**: 4695:484:161
- **Details**: [function_initialize_contract_IERC20_uint8_string_string.md](./function_initialize_contract_IERC20_uint8_string_string.md)

**Signature:**
```solidity
/// @dev Initialize the Super Token proxy
function initialize(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s) virtual override external initializer();
```

### initializeWithAdmin(contract IERC20,uint8,string,string,address)

- **Signature**: `initializeWithAdmin(contract IERC20,uint8,string,string,address)`
- **Visibility**: external
- **Source Range**: 5245:511:161
- **Details**: [function_initializeWithAdmin_contract_IERC20_uint8_string_string_address.md](./function_initializeWithAdmin_contract_IERC20_uint8_string_string_address.md)

**Signature:**
```solidity
/// @dev Initialize the Super Token proxy with an admin
function initializeWithAdmin(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s, address admin) virtual override external initializer();
```

### proxiableUUID()

- **Signature**: `proxiableUUID()`
- **Visibility**: public
- **Source Range**: 5762:167:161
- **Details**: [function_proxiableUUID.md](./function_proxiableUUID.md)

**Signature:**
```solidity
function proxiableUUID() virtual override public pure returns (bytes32);
```

### updateCode(address)

- **Signature**: `updateCode(address)`
- **Visibility**: external
- **Source Range**: 6157:137:161
- **Details**: [function_updateCode_address.md](./function_updateCode_address.md)

**Signature:**
```solidity
///  @notice Updates the logic contract the proxy is pointing at
///  @dev Only the admin can call this function (host if admin == address(0))
///  @param newAddress Address of the new logic contract
function updateCode(address newAddress) virtual override external onlyAdmin();
```

### changeAdmin(address)

- **Signature**: `changeAdmin(address)`
- **Visibility**: external
- **Source Range**: 6300:191:161
- **Details**: [function_changeAdmin_address.md](./function_changeAdmin_address.md)

**Signature:**
```solidity
function changeAdmin(address newAdmin) override external onlyAdmin();
```

### getAdmin()

- **Signature**: `getAdmin()`
- **Visibility**: external
- **Source Range**: 6497:96:161
- **Details**: [function_getAdmin.md](./function_getAdmin.md)

**Signature:**
```solidity
function getAdmin() override external view returns (address);
```

### name()

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 7126:100:161
- **Details**: [function_name.md](./function_name.md)

**Signature:**
```solidity
function name() virtual override external view returns (string memory);
```

### symbol()

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 7232:104:161
- **Details**: [function_symbol.md](./function_symbol.md)

**Signature:**
```solidity
function symbol() virtual override external view returns (string memory);
```

### decimals()

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 7342:109:161
- **Details**: [function_decimals.md](./function_decimals.md)

**Signature:**
```solidity
function decimals() virtual override external pure returns (uint8);
```

### totalSupply()

- **Signature**: `totalSupply()`
- **Visibility**: public
- **Source Range**: 16835:118:161
- **Details**: [function_totalSupply.md](./function_totalSupply.md)

**Signature:**
```solidity
function totalSupply() virtual override public view returns (uint256);
```

### balanceOf(address)

- **Signature**: `balanceOf(address)`
- **Visibility**: public
- **Source Range**: 16959:356:161
- **Details**: [function_balanceOf_address.md](./function_balanceOf_address.md)

**Signature:**
```solidity
function balanceOf(address account) virtual override public view returns (uint256 balance);
```

### transfer(address,uint256)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: public
- **Source Range**: 17321:184:161
- **Details**: [function_transfer_address_uint256.md](./function_transfer_address_uint256.md)

**Signature:**
```solidity
function transfer(address recipient, uint256 amount) virtual override public returns (bool);
```

### allowance(address,address)

- **Signature**: `allowance(address,address)`
- **Visibility**: public
- **Source Range**: 17511:165:161
- **Details**: [function_allowance_address_address.md](./function_allowance_address_address.md)

**Signature:**
```solidity
function allowance(address account, address spender) virtual override public view returns (uint256);
```

### approve(address,uint256)

- **Signature**: `approve(address,uint256)`
- **Visibility**: public
- **Source Range**: 17682:184:161
- **Details**: [function_approve_address_uint256.md](./function_approve_address_uint256.md)

**Signature:**
```solidity
function approve(address spender, uint256 amount) virtual override public returns (bool);
```

### transferFrom(address,address,uint256)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: public
- **Source Range**: 17872:200:161
- **Details**: [function_transferFrom_address_address_uint256.md](./function_transferFrom_address_address_uint256.md)

**Signature:**
```solidity
function transferFrom(address holder, address recipient, uint256 amount) virtual override public returns (bool);
```

### increaseAllowance(address,uint256)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 18078:225:161
- **Details**: [function_increaseAllowance_address_uint256.md](./function_increaseAllowance_address_uint256.md)

**Signature:**
```solidity
function increaseAllowance(address spender, uint256 addedValue) virtual override public returns (bool);
```

### decreaseAllowance(address,uint256)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: public
- **Source Range**: 18309:296:161
- **Details**: [function_decreaseAllowance_address_uint256.md](./function_decreaseAllowance_address_uint256.md)

**Signature:**
```solidity
function decreaseAllowance(address spender, uint256 subtractedValue) virtual override public returns (bool);
```

### granularity()

- **Signature**: `granularity()`
- **Visibility**: external
- **Source Range**: 18797:85:161
- **Details**: [function_granularity.md](./function_granularity.md)

**Signature:**
```solidity
function granularity() virtual override external pure returns (uint256);
```

### send(address,uint256,bytes)

- **Signature**: `send(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 18888:185:161
- **Details**: [function_send_address_uint256_bytes.md](./function_send_address_uint256_bytes.md)

**Signature:**
```solidity
function send(address recipient, uint256 amount, bytes calldata userData) virtual override external;
```

### burn(uint256,bytes)

- **Signature**: `burn(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 19079:166:161
- **Details**: [function_burn_uint256_bytes.md](./function_burn_uint256_bytes.md)

**Signature:**
```solidity
function burn(uint256 amount, bytes calldata userData) virtual override external;
```

### isOperatorFor(address,address)

- **Signature**: `isOperatorFor(address,address)`
- **Visibility**: external
- **Source Range**: 19251:179:161
- **Details**: [function_isOperatorFor_address_address.md](./function_isOperatorFor_address_address.md)

**Signature:**
```solidity
function isOperatorFor(address operator, address tokenHolder) virtual override external view returns (bool);
```

### authorizeOperator(address)

- **Signature**: `authorizeOperator(address)`
- **Visibility**: external
- **Source Range**: 19436:222:161
- **Details**: [function_authorizeOperator_address.md](./function_authorizeOperator_address.md)

**Signature:**
```solidity
function authorizeOperator(address operator) virtual override external;
```

### revokeOperator(address)

- **Signature**: `revokeOperator(address)`
- **Visibility**: external
- **Source Range**: 19664:213:161
- **Details**: [function_revokeOperator_address.md](./function_revokeOperator_address.md)

**Signature:**
```solidity
function revokeOperator(address operator) virtual override external;
```

### defaultOperators()

- **Signature**: `defaultOperators()`
- **Visibility**: external
- **Source Range**: 19883:151:161
- **Details**: [function_defaultOperators.md](./function_defaultOperators.md)

**Signature:**
```solidity
function defaultOperators() virtual override external view returns (address[] memory);
```

### operatorSend(address,address,uint256,bytes,bytes)

- **Signature**: `operatorSend(address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 20040:440:161
- **Details**: [function_operatorSend_address_address_uint256_bytes_bytes.md](./function_operatorSend_address_address_uint256_bytes_bytes.md)

**Signature:**
```solidity
function operatorSend(address sender, address recipient, uint256 amount, bytes calldata userData, bytes calldata operatorData) virtual override external;
```

### operatorBurn(address,uint256,bytes,bytes)

- **Signature**: `operatorBurn(address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 20486:413:161
- **Details**: [function_operatorBurn_address_uint256_bytes_bytes.md](./function_operatorBurn_address_uint256_bytes_bytes.md)

**Signature:**
```solidity
function operatorBurn(address account, uint256 amount, bytes calldata userData, bytes calldata operatorData) virtual override external;
```

### selfMint(address,uint256,bytes)

- **Signature**: `selfMint(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 21242:333:161
- **Details**: [function_selfMint_address_uint256_bytes.md](./function_selfMint_address_uint256_bytes.md)

**Signature:**
```solidity
function selfMint(address account, uint256 amount, bytes memory userData) virtual override external onlySelf();
```

### selfBurn(address,uint256,bytes)

- **Signature**: `selfBurn(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 21581:267:161
- **Details**: [function_selfBurn_address_uint256_bytes.md](./function_selfBurn_address_uint256_bytes.md)

**Signature:**
```solidity
function selfBurn(address account, uint256 amount, bytes memory userData) virtual override external onlySelf();
```

### selfApproveFor(address,address,uint256)

- **Signature**: `selfApproveFor(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 21854:210:161
- **Details**: [function_selfApproveFor_address_address_uint256.md](./function_selfApproveFor_address_address_uint256.md)

**Signature:**
```solidity
function selfApproveFor(address account, address spender, uint256 amount) virtual override external onlySelf();
```

### selfTransferFrom(address,address,address,uint256)

- **Signature**: `selfTransferFrom(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 22070:253:161
- **Details**: [function_selfTransferFrom_address_address_address_uint256.md](./function_selfTransferFrom_address_address_address_uint256.md)

**Signature:**
```solidity
function selfTransferFrom(address holder, address spender, address recipient, uint256 amount) virtual override external onlySelf();
```

### transferAll(address)

- **Signature**: `transferAll(address)`
- **Visibility**: external
- **Source Range**: 22524:166:161
- **Details**: [function_transferAll_address.md](./function_transferAll_address.md)

**Signature:**
```solidity
function transferAll(address recipient) virtual override external;
```

### getUnderlyingToken()

- **Signature**: `getUnderlyingToken()`
- **Visibility**: external
- **Source Range**: 22911:127:161
- **Details**: [function_getUnderlyingToken.md](./function_getUnderlyingToken.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function getUnderlyingToken() virtual override external view returns (address);
```

### getUnderlyingDecimals()

- **Signature**: `getUnderlyingDecimals()`
- **Visibility**: external
- **Source Range**: 23076:123:161
- **Details**: [function_getUnderlyingDecimals.md](./function_getUnderlyingDecimals.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function getUnderlyingDecimals() virtual override external view returns (uint8);
```

### toUnderlyingAmount(uint256)

- **Signature**: `toUnderlyingAmount(uint256)`
- **Visibility**: external
- **Source Range**: 23237:229:161
- **Details**: [function_toUnderlyingAmount_uint256.md](./function_toUnderlyingAmount_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function toUnderlyingAmount(uint256 amount) virtual override external view returns (uint256 underlyingAmount, uint256 adjustedAmount);
```

### upgrade(uint256)

- **Signature**: `upgrade(uint256)`
- **Visibility**: external
- **Source Range**: 23504:136:161
- **Details**: [function_upgrade_uint256.md](./function_upgrade_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function upgrade(uint256 amount) virtual override external;
```

### upgradeTo(address,uint256,bytes)

- **Signature**: `upgradeTo(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 23678:173:161
- **Details**: [function_upgradeTo_address_uint256_bytes.md](./function_upgradeTo_address_uint256_bytes.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function upgradeTo(address to, uint256 amount, bytes calldata userData) virtual override external;
```

### downgrade(uint256)

- **Signature**: `downgrade(uint256)`
- **Visibility**: external
- **Source Range**: 23889:140:161
- **Details**: [function_downgrade_uint256.md](./function_downgrade_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function downgrade(uint256 amount) virtual override external;
```

### downgradeTo(address,uint256)

- **Signature**: `downgradeTo(address,uint256)`
- **Visibility**: external
- **Source Range**: 24067:146:161
- **Details**: [function_downgradeTo_address_uint256.md](./function_downgradeTo_address_uint256.md)

**Signature:**
```solidity
/// @inheritdoc ISuperToken
function downgradeTo(address to, uint256 amount) virtual override external;
```

### operationApprove(address,address,uint256)

- **Signature**: `operationApprove(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 27724:212:161
- **Details**: [function_operationApprove_address_address_uint256.md](./function_operationApprove_address_address_uint256.md)

**Signature:**
```solidity
function operationApprove(address account, address spender, uint256 amount) virtual override external onlyHost();
```

### operationIncreaseAllowance(address,address,uint256)

- **Signature**: `operationIncreaseAllowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 27942:262:161
- **Details**: [function_operationIncreaseAllowance_address_address_uint256.md](./function_operationIncreaseAllowance_address_address_uint256.md)

**Signature:**
```solidity
function operationIncreaseAllowance(address account, address spender, uint256 addedValue) virtual override external onlyHost();
```

### operationDecreaseAllowance(address,address,uint256)

- **Signature**: `operationDecreaseAllowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 28210:333:161
- **Details**: [function_operationDecreaseAllowance_address_address_uint256.md](./function_operationDecreaseAllowance_address_address_uint256.md)

**Signature:**
```solidity
function operationDecreaseAllowance(address account, address spender, uint256 subtractedValue) virtual override external onlyHost();
```

### operationTransferFrom(address,address,address,uint256)

- **Signature**: `operationTransferFrom(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 28549:260:161
- **Details**: [function_operationTransferFrom_address_address_address_uint256.md](./function_operationTransferFrom_address_address_address_uint256.md)

**Signature:**
```solidity
function operationTransferFrom(address account, address spender, address recipient, uint256 amount) virtual override external onlyHost();
```

### operationSend(address,address,uint256,bytes)

- **Signature**: `operationSend(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 28815:273:161
- **Details**: [function_operationSend_address_address_uint256_bytes.md](./function_operationSend_address_address_uint256_bytes.md)

**Signature:**
```solidity
function operationSend(address spender, address recipient, uint256 amount, bytes memory userData) virtual override external onlyHost();
```

### operationUpgrade(address,uint256)

- **Signature**: `operationUpgrade(address,uint256)`
- **Visibility**: external
- **Source Range**: 29094:185:161
- **Details**: [function_operationUpgrade_address_uint256.md](./function_operationUpgrade_address_uint256.md)

**Signature:**
```solidity
function operationUpgrade(address account, uint256 amount) virtual override external onlyHost();
```

### operationDowngrade(address,uint256)

- **Signature**: `operationDowngrade(address,uint256)`
- **Visibility**: external
- **Source Range**: 29285:189:161
- **Details**: [function_operationDowngrade_address_uint256.md](./function_operationDowngrade_address_uint256.md)

**Signature:**
```solidity
function operationDowngrade(address account, uint256 amount) virtual override external onlyHost();
```

### operationUpgradeTo(address,address,uint256)

- **Signature**: `operationUpgradeTo(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 29480:194:161
- **Details**: [function_operationUpgradeTo_address_address_uint256.md](./function_operationUpgradeTo_address_address_uint256.md)

**Signature:**
```solidity
function operationUpgradeTo(address account, address to, uint256 amount) virtual override external onlyHost();
```

### operationDowngradeTo(address,address,uint256)

- **Signature**: `operationDowngradeTo(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 29680:198:161
- **Details**: [function_operationDowngradeTo_address_address_uint256.md](./function_operationDowngradeTo_address_address_uint256.md)

**Signature:**
```solidity
function operationDowngradeTo(address account, address to, uint256 amount) virtual override external onlyHost();
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

### getHost() (inherited from SuperfluidToken)

- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 1711:144:164
- **Details**: [function_getHost.md](./function_getHost.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.getHost implementation
function getHost() override(ISuperfluidToken) external view returns (address host);
```

### realtimeBalanceOf(address,uint256) (inherited from SuperfluidToken)

- **Signature**: `realtimeBalanceOf(address,uint256)`
- **Visibility**: public
- **Source Range**: 2120:1334:164
- **Details**: [function_realtimeBalanceOf_address_uint256.md](./function_realtimeBalanceOf_address_uint256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.realtimeBalanceOf implementation
function realtimeBalanceOf(address account, uint256 timestamp) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit);
```

### realtimeBalanceOfNow(address) (inherited from SuperfluidToken)

- **Signature**: `realtimeBalanceOfNow(address)`
- **Visibility**: public
- **Source Range**: 3526:428:164
- **Details**: [function_realtimeBalanceOfNow_address.md](./function_realtimeBalanceOfNow_address.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.realtimeBalanceOfNow implementation
function realtimeBalanceOfNow(address account) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit, uint256 timestamp);
```

### isAccountCritical(address,uint256) (inherited from SuperfluidToken)

- **Signature**: `isAccountCritical(address,uint256)`
- **Visibility**: public
- **Source Range**: 3960:280:164
- **Details**: [function_isAccountCritical_address_uint256.md](./function_isAccountCritical_address_uint256.md)

**Signature:**
```solidity
function isAccountCritical(address account, uint256 timestamp) virtual override public view returns (bool isCritical);
```

### isAccountCriticalNow(address) (inherited from SuperfluidToken)

- **Signature**: `isAccountCriticalNow(address)`
- **Visibility**: external
- **Source Range**: 4246:201:164
- **Details**: [function_isAccountCriticalNow_address.md](./function_isAccountCriticalNow_address.md)

**Signature:**
```solidity
function isAccountCriticalNow(address account) virtual override external view returns (bool isCritical);
```

### isAccountSolvent(address,uint256) (inherited from SuperfluidToken)

- **Signature**: `isAccountSolvent(address,uint256)`
- **Visibility**: public
- **Source Range**: 4453:533:164
- **Details**: [function_isAccountSolvent_address_uint256.md](./function_isAccountSolvent_address_uint256.md)

**Signature:**
```solidity
function isAccountSolvent(address account, uint256 timestamp) virtual override public view returns (bool isSolvent);
```

### isAccountSolventNow(address) (inherited from SuperfluidToken)

- **Signature**: `isAccountSolventNow(address)`
- **Visibility**: external
- **Source Range**: 4992:197:164
- **Details**: [function_isAccountSolventNow_address.md](./function_isAccountSolventNow_address.md)

**Signature:**
```solidity
function isAccountSolventNow(address account) virtual override external view returns (bool isSolvent);
```

### getAccountActiveAgreements(address) (inherited from SuperfluidToken)

- **Signature**: `getAccountActiveAgreements(address)`
- **Visibility**: public
- **Source Range**: 5267:218:164
- **Details**: [function_getAccountActiveAgreements_address.md](./function_getAccountActiveAgreements_address.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.getAccountActiveAgreements implementation
function getAccountActiveAgreements(address account) virtual override public view returns (ISuperAgreement[] memory);
```

### createAgreement(bytes32,bytes32[]) (inherited from SuperfluidToken)

- **Signature**: `createAgreement(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 7337:481:164
- **Details**: [function_createAgreement_bytes32_bytes32[].md](./function_createAgreement_bytes32_bytes32[].md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.createAgreement implementation
function createAgreement(bytes32 id, bytes32[] calldata data) virtual override external;
```

### getAgreementData(address,bytes32,uint256) (inherited from SuperfluidToken)

- **Signature**: `getAgreementData(address,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 7886:338:164
- **Details**: [function_getAgreementData_address_bytes32_uint256.md](./function_getAgreementData_address_bytes32_uint256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.getAgreementData implementation
function getAgreementData(address agreementClass, bytes32 id, uint dataLength) virtual override external view returns (bytes32[] memory data);
```

### updateAgreementData(bytes32,bytes32[]) (inherited from SuperfluidToken)

- **Signature**: `updateAgreementData(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 8295:359:164
- **Details**: [function_updateAgreementData_bytes32_bytes32[].md](./function_updateAgreementData_bytes32_bytes32[].md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.updateAgreementData implementation
function updateAgreementData(bytes32 id, bytes32[] calldata data) virtual override external;
```

### terminateAgreement(bytes32,uint256) (inherited from SuperfluidToken)

- **Signature**: `terminateAgreement(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 8724:474:164
- **Details**: [function_terminateAgreement_bytes32_uint256.md](./function_terminateAgreement_bytes32_uint256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.terminateAgreement implementation
function terminateAgreement(bytes32 id, uint dataLength) virtual override external;
```

### updateAgreementStateSlot(address,uint256,bytes32[]) (inherited from SuperfluidToken)

- **Signature**: `updateAgreementStateSlot(address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 9270:378:164
- **Details**: [function_updateAgreementStateSlot_address_uint256_bytes32[].md](./function_updateAgreementStateSlot_address_uint256_bytes32[].md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.updateAgreementState implementation
function updateAgreementStateSlot(address account, uint256 slotId, bytes32[] calldata slotData) virtual override external;
```

### getAgreementStateSlot(address,address,uint256,uint256) (inherited from SuperfluidToken)

- **Signature**: `getAgreementStateSlot(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 9717:391:164
- **Details**: [function_getAgreementStateSlot_address_address_uint256_uint256.md](./function_getAgreementStateSlot_address_address_uint256_uint256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.getAgreementState implementation
function getAgreementStateSlot(address agreementClass, address account, uint256 slotId, uint dataLength) virtual override external view returns (bytes32[] memory slotData);
```

### settleBalance(address,int256) (inherited from SuperfluidToken)

- **Signature**: `settleBalance(address,int256)`
- **Visibility**: external
- **Source Range**: 10173:226:164
- **Details**: [function_settleBalance_address_int256.md](./function_settleBalance_address_int256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.settleBalance implementation
function settleBalance(address account, int256 delta) virtual override external onlyAgreement();
```

### makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256) (inherited from SuperfluidToken)

- **Signature**: `makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)`
- **Visibility**: external
- **Source Range**: 10475:2510:164
- **Details**: [function_makeLiquidationPayoutsV2_bytes32_bytes_address_bool_address_uint256_int256.md](./function_makeLiquidationPayoutsV2_bytes32_bytes_address_bool_address_uint256_int256.md)

**Signature:**
```solidity
/// @dev ISuperfluidToken.makeLiquidationPayoutsV2 implementation
function makeLiquidationPayoutsV2(bytes32 id, bytes memory liquidationTypeData, address liquidatorAccount, bool useDefaultRewardAccount, address targetAccount, uint256 rewardAmount, int256 targetAccountBalanceDelta) virtual override external onlyAgreement();
```
