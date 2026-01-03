# Interface: ISETH

## Metadata

- **Name**: ISETH
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/tokens/ISETH.sol
- **Documentation**:  @title Super ETH (SETH) full interface
   @author Superfluid

## Implements Interfaces

- **ISuperToken** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **IERC777** [lib/openzeppelin-contracts/contracts/token/ERC777/IERC777.sol/interface_IERC777.md]
- **IERC20Metadata** [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **IERC20** [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **ISuperfluidToken** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidToken.sol/interface_ISuperfluidToken.md]
- **ISETHCustom** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/tokens/ISETH.sol/interface_ISETHCustom.md]

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

### upgradeByETH() (inherited from ISETHCustom)

- **Signature**: `upgradeByETH()`
- **Visibility**: external
- **Source Range**: 257:41:48

**Signature:**
```solidity
function upgradeByETH() external payable;;
```

### upgradeByETHTo(address) (inherited from ISETHCustom)

- **Signature**: `upgradeByETHTo(address)`
- **Visibility**: external
- **Source Range**: 303:53:48

**Signature:**
```solidity
function upgradeByETHTo(address to) external payable;;
```

### downgradeToETH(uint256) (inherited from ISETHCustom)

- **Signature**: `downgradeToETH(uint256)`
- **Visibility**: external
- **Source Range**: 361:43:48

**Signature:**
```solidity
function downgradeToETH(uint wad) external;;
```

### getHost() (inherited from ISuperfluidToken)

- **Signature**: `getHost()`
- **Visibility**: external
- **Source Range**: 1017:55:47

**Signature:**
```solidity
///  @dev Get superfluid host contract address
function getHost() external view returns (address host);;
```

### realtimeBalanceOf(address,uint256) (inherited from ISuperfluidToken)

- **Signature**: `realtimeBalanceOf(address,uint256)`
- **Visibility**: external
- **Source Range**: 2078:222:47

**Signature:**
```solidity
///  @dev Calculate the real balance of a user, taking in consideration all agreements of the account
///  @param account for the query
///  @param timestamp Time of balance
///  @return availableBalance Real-time balance
///  @return deposit Account deposit
///  @return owedDeposit Account owed Deposit
function realtimeBalanceOf(address account, uint256 timestamp) external view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit);;
```

### realtimeBalanceOfNow(address) (inherited from ISuperfluidToken)

- **Signature**: `realtimeBalanceOfNow(address)`
- **Visibility**: external
- **Source Range**: 2650:230:47

**Signature:**
```solidity
///  @notice Calculate the realtime balance given the current host.getNow() value
///  @dev realtimeBalanceOf with timestamp equals to block timestamp
///  @param account for the query
///  @return availableBalance Real-time balance
///  @return deposit Account deposit
///  @return owedDeposit Account owed Deposit
function realtimeBalanceOfNow(address account) external view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit, uint256 timestamp);;
```

### isAccountCritical(address,uint256) (inherited from ISuperfluidToken)

- **Signature**: `isAccountCritical(address,uint256)`
- **Visibility**: external
- **Source Range**: 3200:140:47

**Signature:**
```solidity
///  @notice Check if account is critical
///  @dev A critical account is when availableBalance < 0
///  @param account The account to check
///  @param timestamp The time we'd like to check if the account is critical (should use future)
///  @return isCritical Whether the account is critical
function isAccountCritical(address account, uint256 timestamp) external view returns (bool isCritical);;
```

### isAccountCriticalNow(address) (inherited from ISuperfluidToken)

- **Signature**: `isAccountCriticalNow(address)`
- **Visibility**: external
- **Source Range**: 3590:116:47

**Signature:**
```solidity
///  @notice Check if account is critical now (current host.getNow())
///  @dev A critical account is when availableBalance < 0
///  @param account The account to check
///  @return isCritical Whether the account is critical
function isAccountCriticalNow(address account) external view returns (bool isCritical);;
```

### isAccountSolvent(address,uint256) (inherited from ISuperfluidToken)

- **Signature**: `isAccountSolvent(address,uint256)`
- **Visibility**: external
- **Source Range**: 4100:138:47

**Signature:**
```solidity
///  @notice Check if account is solvent
///  @dev An account is insolvent when the sum of deposits for a token can't cover the negative availableBalance
///  @param account The account to check
///  @param timestamp The time we'd like to check if the account is solvent (should use future)
///  @return isSolvent True if the account is solvent, false otherwise
function isAccountSolvent(address account, uint256 timestamp) external view returns (bool isSolvent);;
```

### isAccountSolventNow(address) (inherited from ISuperfluidToken)

- **Signature**: `isAccountSolventNow(address)`
- **Visibility**: external
- **Source Range**: 4538:114:47

**Signature:**
```solidity
///  @notice Check if account is solvent now
///  @dev An account is insolvent when the sum of deposits for a token can't cover the negative availableBalance
///  @param account The account to check
///  @return isSolvent True if the account is solvent, false otherwise
function isAccountSolventNow(address account) external view returns (bool isSolvent);;
```

### getAccountActiveAgreements(address) (inherited from ISuperfluidToken)

- **Signature**: `getAccountActiveAgreements(address)`
- **Visibility**: external
- **Source Range**: 4940:132:47

**Signature:**
```solidity
///  @notice Get a list of agreements that is active for the account
///  @dev An active agreement is one that has state for the account
///  @param account Account to query
///  @return activeAgreements List of accounts that have non-zero states for the account
function getAccountActiveAgreements(address account) external view returns (ISuperAgreement[] memory activeAgreements);;
```

### createAgreement(bytes32,bytes32[]) (inherited from ISuperfluidToken)

- **Signature**: `createAgreement(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 5393:101:47

**Signature:**
```solidity
///  @dev Create a new agreement
///  @param id Agreement ID
///  @param data Agreement data
function createAgreement(bytes32 id, bytes32[] calldata data) external;;
```

### getAgreementData(address,bytes32,uint256) (inherited from ISuperfluidToken)

- **Signature**: `getAgreementData(address,bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 5986:170:47

**Signature:**
```solidity
///  @dev Get data of the agreement
///  @param agreementClass Contract address of the agreement
///  @param id Agreement ID
///  @return data Data of the agreement
function getAgreementData(address agreementClass, bytes32 id, uint dataLength) external view returns (bytes32[] memory data);;
```

### updateAgreementData(bytes32,bytes32[]) (inherited from ISuperfluidToken)

- **Signature**: `updateAgreementData(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 6277:105:47

**Signature:**
```solidity
///  @dev Create a new agreement
///  @param id Agreement ID
///  @param data Agreement data
function updateAgreementData(bytes32 id, bytes32[] calldata data) external;;
```

### terminateAgreement(bytes32,uint256) (inherited from ISuperfluidToken)

- **Signature**: `terminateAgreement(bytes32,uint256)`
- **Visibility**: external
- **Source Range**: 6763:96:47

**Signature:**
```solidity
///  @dev Close the agreement
///  @param id Agreement ID
function terminateAgreement(bytes32 id, uint dataLength) external;;
```

### updateAgreementStateSlot(address,uint256,bytes32[]) (inherited from ISuperfluidToken)

- **Signature**: `updateAgreementStateSlot(address,uint256,bytes32[])`
- **Visibility**: external
- **Source Range**: 7314:143:47

**Signature:**
```solidity
///  @dev Update agreement state slot
///  @param account Account to be updated
///  @custom:note 
///  - To clear the storage out, provide zero-ed array of intended length
function updateAgreementStateSlot(address account, uint256 slotId, bytes32[] calldata slotData) external;;
```

### getAgreementStateSlot(address,address,uint256,uint256) (inherited from ISuperfluidToken)

- **Signature**: `getAgreementStateSlot(address,address,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 8090:209:47

**Signature:**
```solidity
///  @dev Get data of the slot of the state of an agreement
///  @param agreementClass Contract address of the agreement
///  @param account Account to query
///  @param slotId slot id of the state
///  @param dataLength length of the state data
function getAgreementStateSlot(address agreementClass, address account, uint256 slotId, uint dataLength) external view returns (bytes32[] memory slotData);;
```

### settleBalance(address,int256) (inherited from ISuperfluidToken)

- **Signature**: `settleBalance(address,int256)`
- **Visibility**: external
- **Source Range**: 8630:93:47

**Signature:**
```solidity
///  @notice Settle balance from an account by the agreement
///  @dev The agreement needs to make sure that the balance delta is balanced afterwards
///  @param account Account to query.
///  @param delta Amount of balance delta to be settled
///  @custom:modifiers 
///   - onlyAgreement
function settleBalance(address account, int256 delta) external;;
```

### makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256) (inherited from ISuperfluidToken)

- **Signature**: `makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)`
- **Visibility**: external
- **Source Range**: 9888:292:47

**Signature:**
```solidity
///  @dev Make liquidation payouts (v2)
///  @param id Agreement ID
///  @param liquidationTypeData Data regarding the version of the liquidation schema and the type
///  @param liquidatorAccount Address of the executor of the liquidation
///  @param useDefaultRewardAccount Whether or not the default reward account receives the rewardAmount
///  @param targetAccount Account to be liquidated
///  @param rewardAmount The amount the rewarded account will receive
///  @param targetAccountBalanceDelta The delta amount the target account balance should change by
///  @custom:note 
///  - If a bailout is required (bailoutAmount > 0)
///    - the actual reward (single deposit) goes to the executor,
///    - while the reward account becomes the bailout account
///    - total bailout include: bailout amount + reward amount
///    - the targetAccount will be bailed out
///  - If a bailout is not required
///    - the targetAccount will pay the rewardAmount
///    - the liquidator (reward account in PIC period) will receive the rewardAmount
///  @custom:modifiers 
///   - onlyAgreement
function makeLiquidationPayoutsV2(bytes32 id, bytes memory liquidationTypeData, address liquidatorAccount, bool useDefaultRewardAccount, address targetAccount, uint256 rewardAmount, int256 targetAccountBalanceDelta) external;;
```

### totalSupply() (inherited from IERC20)

- **Signature**: `totalSupply()`
- **Visibility**: external
- **Source Range**: 774:55:8

**Signature:**
```solidity
///  @dev Returns the amount of tokens in existence.
function totalSupply() external view returns (uint256);;
```

### balanceOf(address) (inherited from IERC20)

- **Signature**: `balanceOf(address)`
- **Visibility**: external
- **Source Range**: 912:68:8

**Signature:**
```solidity
///  @dev Returns the amount of tokens owned by `account`.
function balanceOf(address account) external view returns (uint256);;
```

### transfer(address,uint256) (inherited from IERC20)

- **Signature**: `transfer(address,uint256)`
- **Visibility**: external
- **Source Range**: 1193:70:8

**Signature:**
```solidity
///  @dev Moves `amount` tokens from the caller's account to `to`.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transfer(address to, uint256 amount) external returns (bool);;
```

### allowance(address,address) (inherited from IERC20)

- **Signature**: `allowance(address,address)`
- **Visibility**: external
- **Source Range**: 1538:83:8

**Signature:**
```solidity
///  @dev Returns the remaining number of tokens that `spender` will be
///  allowed to spend on behalf of `owner` through {transferFrom}. This is
///  zero by default.
///  This value changes when {approve} or {transferFrom} are called.
function allowance(address owner, address spender) external view returns (uint256);;
```

### approve(address,uint256) (inherited from IERC20)

- **Signature**: `approve(address,uint256)`
- **Visibility**: external
- **Source Range**: 2274:74:8

**Signature:**
```solidity
///  @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
///  Returns a boolean value indicating whether the operation succeeded.
///  IMPORTANT: Beware that changing an allowance with this method brings the risk
///  that someone may use both the old and the new allowance by unfortunate
///  transaction ordering. One possible solution to mitigate this race
///  condition is to first reduce the spender's allowance to 0 and set the
///  desired value afterwards:
///  https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
///  Emits an {Approval} event.
function approve(address spender, uint256 amount) external returns (bool);;
```

### transferFrom(address,address,uint256) (inherited from IERC20)

- **Signature**: `transferFrom(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 2646:88:8

**Signature:**
```solidity
///  @dev Moves `amount` tokens from `from` to `to` using the
///  allowance mechanism. `amount` is then deducted from the caller's
///  allowance.
///  Returns a boolean value indicating whether the operation succeeded.
///  Emits a {Transfer} event.
function transferFrom(address from, address to, uint256 amount) external returns (bool);;
```

### name() (inherited from IERC20Metadata)

- **Signature**: `name()`
- **Visibility**: external
- **Source Range**: 377:54:11

**Signature:**
```solidity
///  @dev Returns the name of the token.
function name() external view returns (string memory);;
```

### symbol() (inherited from IERC20Metadata)

- **Signature**: `symbol()`
- **Visibility**: external
- **Source Range**: 498:56:11

**Signature:**
```solidity
///  @dev Returns the symbol of the token.
function symbol() external view returns (string memory);;
```

### decimals() (inherited from IERC20Metadata)

- **Signature**: `decimals()`
- **Visibility**: external
- **Source Range**: 630:50:11

**Signature:**
```solidity
///  @dev Returns the decimals places of the token.
function decimals() external view returns (uint8);;
```

### granularity() (inherited from IERC777)

- **Signature**: `granularity()`
- **Visibility**: external
- **Source Range**: 2093:55:18

**Signature:**
```solidity
///  @dev Returns the smallest part of the token that is not divisible. This
///  means all token operations (creation, movement and destruction) must have
///  amounts that are a multiple of this number.
///  For most token contracts, this value will equal 1.
function granularity() external view returns (uint256);;
```

### send(address,uint256,bytes) (inherited from IERC777)

- **Signature**: `send(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 3036:79:18

**Signature:**
```solidity
///  @dev Moves `amount` tokens from the caller's account to `recipient`.
///  If send or receive hooks are registered for the caller and `recipient`,
///  the corresponding functions will be called with `data` and empty
///  `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
///  Emits a {Sent} event.
///  Requirements
///  - the caller must have at least `amount` tokens.
///  - `recipient` cannot be the zero address.
///  - if `recipient` is a contract, it must implement the {IERC777Recipient}
///  interface.
function send(address recipient, uint256 amount, bytes calldata data) external;;
```

### burn(uint256,bytes) (inherited from IERC777)

- **Signature**: `burn(uint256,bytes)`
- **Visibility**: external
- **Source Range**: 3530:60:18

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from the caller's account, reducing the
///  total supply.
///  If a send hook is registered for the caller, the corresponding function
///  will be called with `data` and empty `operatorData`. See {IERC777Sender}.
///  Emits a {Burned} event.
///  Requirements
///  - the caller must have at least `amount` tokens.
function burn(uint256 amount, bytes calldata data) external;;
```

### isOperatorFor(address,address) (inherited from IERC777)

- **Signature**: `isOperatorFor(address,address)`
- **Visibility**: external
- **Source Range**: 3850:91:18

**Signature:**
```solidity
///  @dev Returns true if an account is an operator of `tokenHolder`.
///  Operators can send and burn tokens on behalf of their owners. All
///  accounts are their own operator.
///  See {operatorSend} and {operatorBurn}.
function isOperatorFor(address operator, address tokenHolder) external view returns (bool);;
```

### authorizeOperator(address) (inherited from IERC777)

- **Signature**: `authorizeOperator(address)`
- **Visibility**: external
- **Source Range**: 4185:54:18

**Signature:**
```solidity
///  @dev Make an account an operator of the caller.
///  See {isOperatorFor}.
///  Emits an {AuthorizedOperator} event.
///  Requirements
///  - `operator` cannot be calling address.
function authorizeOperator(address operator) external;;
```

### revokeOperator(address) (inherited from IERC777)

- **Signature**: `revokeOperator(address)`
- **Visibility**: external
- **Source Range**: 4511:51:18

**Signature:**
```solidity
///  @dev Revoke an account's operator status for the caller.
///  See {isOperatorFor} and {defaultOperators}.
///  Emits a {RevokedOperator} event.
///  Requirements
///  - `operator` cannot be calling address.
function revokeOperator(address operator) external;;
```

### defaultOperators() (inherited from IERC777)

- **Signature**: `defaultOperators()`
- **Visibility**: external
- **Source Range**: 4911:69:18

**Signature:**
```solidity
///  @dev Returns the list of default operators. These accounts are operators
///  for all token holders, even if {authorizeOperator} was never called on
///  them.
///  This list is immutable, but individual holders may revoke these via
///  {revokeOperator}, in which case {isOperatorFor} will return false.
function defaultOperators() external view returns (address[] memory);;
```

### operatorSend(address,address,uint256,bytes,bytes) (inherited from IERC777)

- **Signature**: `operatorSend(address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 5705:178:18

**Signature:**
```solidity
///  @dev Moves `amount` tokens from `sender` to `recipient`. The caller must
///  be an operator of `sender`.
///  If send or receive hooks are registered for `sender` and `recipient`,
///  the corresponding functions will be called with `data` and
///  `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
///  Emits a {Sent} event.
///  Requirements
///  - `sender` cannot be the zero address.
///  - `sender` must have at least `amount` tokens.
///  - the caller must be an operator for `sender`.
///  - `recipient` cannot be the zero address.
///  - if `recipient` is a contract, it must implement the {IERC777Recipient}
///  interface.
function operatorSend(address sender, address recipient, uint256 amount, bytes calldata data, bytes calldata operatorData) external;;
```

### operatorBurn(address,uint256,bytes,bytes) (inherited from IERC777)

- **Signature**: `operatorBurn(address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 6426:114:18

**Signature:**
```solidity
///  @dev Destroys `amount` tokens from `account`, reducing the total supply.
///  The caller must be an operator of `account`.
///  If a send hook is registered for `account`, the corresponding function
///  will be called with `data` and `operatorData`. See {IERC777Sender}.
///  Emits a {Burned} event.
///  Requirements
///  - `account` cannot be the zero address.
///  - `account` must have at least `amount` tokens.
///  - the caller must be an operator for `account`.
function operatorBurn(address account, uint256 amount, bytes calldata data, bytes calldata operatorData) external;;
```

### initialize(contract IERC20,uint8,string,string) (inherited from ISuperToken)

- **Signature**: `initialize(contract IERC20,uint8,string,string)`
- **Visibility**: external
- **Source Range**: 1953:155:43

**Signature:**
```solidity
///  @dev Initialize the contract
function initialize(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s) external;;
```

### initializeWithAdmin(contract IERC20,uint8,string,string,address) (inherited from ISuperToken)

- **Signature**: `initializeWithAdmin(contract IERC20,uint8,string,string,address)`
- **Visibility**: external
- **Source Range**: 2180:187:43

**Signature:**
```solidity
///  @dev Initialize the contract with an admin
function initializeWithAdmin(IERC20 underlyingToken, uint8 underlyingDecimals, string calldata n, string calldata s, address admin) external;;
```

### changeAdmin(address) (inherited from ISuperToken)

- **Signature**: `changeAdmin(address)`
- **Visibility**: external
- **Source Range**: 2605:48:43

**Signature:**
```solidity
///  @notice Changes the admin for the SuperToken
///  @dev Only the current admin can call this function
///  if admin is address(0), it is implicitly the host address
///  @param newAdmin New admin address
function changeAdmin(address newAdmin) external;;
```

### getAdmin() (inherited from ISuperToken)

- **Signature**: `getAdmin()`
- **Visibility**: external
- **Source Range**: 2809:58:43

**Signature:**
```solidity
///  @dev Returns the admin address for the SuperToken
function getAdmin() external view returns (address admin);;
```

### POOL_ADMIN_NFT() (inherited from ISuperToken)

- **Signature**: `POOL_ADMIN_NFT()`
- **Visibility**: external
- **Source Range**: 3112:64:43

**Signature:**
```solidity
function POOL_ADMIN_NFT() external view returns (IPoolAdminNFT);;
```

### POOL_MEMBER_NFT() (inherited from ISuperToken)

- **Signature**: `POOL_MEMBER_NFT()`
- **Visibility**: external
- **Source Range**: 3234:66:43

**Signature:**
```solidity
function POOL_MEMBER_NFT() external view returns (IPoolMemberNFT);;
```

### increaseAllowance(address,uint256) (inherited from ISuperToken)

- **Signature**: `increaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 7661:88:43

**Signature:**
```solidity
///  @dev Atomically increases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  @custom:emits an {Approval} event indicating the updated allowance.
///  @custom:requirements
///  - `spender` cannot be the zero address.
function increaseAllowance(address spender, uint256 addedValue) external returns (bool);;
```

### decreaseAllowance(address,uint256) (inherited from ISuperToken)

- **Signature**: `decreaseAllowance(address,uint256)`
- **Visibility**: external
- **Source Range**: 8245:93:43

**Signature:**
```solidity
///  @dev Atomically decreases the allowance granted to `spender` by the caller.
///  This is an alternative to {approve} that can be used as a mitigation for
///  problems described in {IERC20-approve}.
///  @custom:emits an {Approval} event indicating the updated allowance.
///  @custom:requirements
///  - `spender` cannot be the zero address.
///  - `spender` must have allowance for the caller of at least
///  `subtractedValue`.
function decreaseAllowance(address spender, uint256 subtractedValue) external returns (bool);;
```

### selfMint(address,uint256,bytes) (inherited from ISuperToken)

- **Signature**: `selfMint(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 13774:113:43

**Signature:**
```solidity
///  @dev Mint new tokens for the account
///  If `userData` is not empty, the `tokensReceived` hook is invoked according to ERC777 semantics.
///  @custom:modifiers
///   - onlySelf
function selfMint(address account, uint256 amount, bytes memory userData) external;;
```

### selfBurn(address,uint256,bytes) (inherited from ISuperToken)

- **Signature**: `selfBurn(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 14102:109:43

**Signature:**
```solidity
///  @dev Burn existing tokens for the account
///  If `userData` is not empty, the `tokensToSend` hook is invoked according to ERC777 semantics.
///  @custom:modifiers
///   - onlySelf
function selfBurn(address account, uint256 amount, bytes memory userData) external;;
```

### selfTransferFrom(address,address,address,uint256) (inherited from ISuperToken)

- **Signature**: `selfTransferFrom(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 14464:140:43

**Signature:**
```solidity
///  @dev Transfer `amount` tokens from the `sender` to `recipient`.
///  If `spender` isn't the same as `sender`, checks if `spender` has allowance to
///  spend tokens of `sender`.
///  @custom:modifiers
///   - onlySelf
function selfTransferFrom(address sender, address spender, address recipient, uint256 amount) external;;
```

### selfApproveFor(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `selfApproveFor(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 14757:112:43

**Signature:**
```solidity
///  @dev Give `spender`, `amount` allowance to spend the tokens of
///  `account`.
///  @custom:modifiers
///   - onlySelf
function selfApproveFor(address account, address spender, uint256 amount) external;;
```

### transferAll(address) (inherited from ISuperToken)

- **Signature**: `transferAll(address)`
- **Visibility**: external
- **Source Range**: 15162:49:43

**Signature:**
```solidity
///  @dev Transfer all available balance from `msg.sender` to `recipient`
function transferAll(address recipient) external;;
```

### getUnderlyingToken() (inherited from ISuperToken)

- **Signature**: `getUnderlyingToken()`
- **Visibility**: external
- **Source Range**: 15515:71:43

**Signature:**
```solidity
///  @dev Return the underlying token contract
///  @return tokenAddr Underlying token address
function getUnderlyingToken() external view returns (address tokenAddr);;
```

### getUnderlyingDecimals() (inherited from ISuperToken)

- **Signature**: `getUnderlyingDecimals()`
- **Visibility**: external
- **Source Range**: 15717:82:43

**Signature:**
```solidity
///  @dev Return the underlying token decimals
///  @return underlyingDecimals Underlying token decimals
function getUnderlyingDecimals() external view returns (uint8 underlyingDecimals);;
```

### toUnderlyingAmount(uint256) (inherited from ISuperToken)

- **Signature**: `toUnderlyingAmount(uint256)`
- **Visibility**: external
- **Source Range**: 16088:141:43

**Signature:**
```solidity
///  @dev Return the underlying token conversion rate
///  @param amount Number of tokens to be upgraded (in 18 decimals)
///  @return underlyingAmount The underlying token amount after scaling
///  @return adjustedAmount The super token amount after scaling
function toUnderlyingAmount(uint256 amount) external view returns (uint256 underlyingAmount, uint256 adjustedAmount);;
```

### upgrade(uint256) (inherited from ISuperToken)

- **Signature**: `upgrade(uint256)`
- **Visibility**: external
- **Source Range**: 16502:42:43

**Signature:**
```solidity
///  @dev Upgrade ERC20 to SuperToken.
///  @param amount Number of tokens to be upgraded (in 18 decimals)
///  @custom:note It will use `transferFrom` to get tokens. Before calling this
///  function you should `approve` this contract
function upgrade(uint256 amount) external;;
```

### upgradeTo(address,uint256,bytes) (inherited from ISuperToken)

- **Signature**: `upgradeTo(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 17249:81:43

**Signature:**
```solidity
///  @dev Upgrade ERC20 to SuperToken and transfer immediately
///  @param to The account to receive upgraded tokens
///  @param amount Number of tokens to be upgraded (in 18 decimals)
///  @param userData User data for the TokensRecipient callback
///  @custom:note It will use `transferFrom` to get tokens. Before calling this
///  function you should `approve` this contract
///  @custom:warning
///  - there is potential of reentrancy IF the "to" account is a registered ERC777 recipient.
///  @custom:requirements
///  - if `userData` is NOT empty AND `to` is a contract, it MUST be a registered ERC777 recipient
///    otherwise it reverts.
function upgradeTo(address to, uint256 amount, bytes calldata userData) external;;
```

### downgrade(uint256) (inherited from ISuperToken)

- **Signature**: `downgrade(uint256)`
- **Visibility**: external
- **Source Range**: 17759:44:43

**Signature:**
```solidity
///  @dev Downgrade SuperToken to ERC20.
///  @dev It will call transfer to send tokens
///  @param amount Number of tokens to be downgraded
function downgrade(uint256 amount) external;;
```

### downgradeTo(address,uint256) (inherited from ISuperToken)

- **Signature**: `downgradeTo(address,uint256)`
- **Visibility**: external
- **Source Range**: 18022:58:43

**Signature:**
```solidity
///  @dev Downgrade SuperToken to ERC20 and transfer immediately
///  @param to The account to receive downgraded tokens
///  @param amount Number of tokens to be downgraded (in 18 decimals)
function downgradeTo(address to, uint256 amount) external;;
```

### operationApprove(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationApprove(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 18798:115:43

**Signature:**
```solidity
///  @dev Perform ERC20 approve by host contract.
///  @param account The account owner to be approved.
///  @param spender The spender of account owner's funds.
///  @param amount Number of tokens to be approved.
///  @custom:modifiers
///   - onlyHost
function operationApprove(address account, address spender, uint256 amount) external;;
```

### operationIncreaseAllowance(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationIncreaseAllowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 18919:129:43

**Signature:**
```solidity
function operationIncreaseAllowance(address account, address spender, uint256 addedValue) external;;
```

### operationDecreaseAllowance(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationDecreaseAllowance(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 19054:134:43

**Signature:**
```solidity
function operationDecreaseAllowance(address account, address spender, uint256 subtractedValue) external;;
```

### operationTransferFrom(address,address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationTransferFrom(address,address,address,uint256)`
- **Visibility**: external
- **Source Range**: 19541:147:43

**Signature:**
```solidity
///  @dev Perform ERC20 transferFrom by host contract.
///  @param account The account to spend sender's funds.
///  @param spender The account where the funds is sent from.
///  @param recipient The recipient of the funds.
///  @param amount Number of tokens to be transferred.
///  @custom:modifiers
///   - onlyHost
function operationTransferFrom(address account, address spender, address recipient, uint256 amount) external;;
```

### operationSend(address,address,uint256,bytes) (inherited from ISuperToken)

- **Signature**: `operationSend(address,address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 20027:145:43

**Signature:**
```solidity
///  @dev Perform ERC777 send by host contract.
///  @param spender The account where the funds is sent from.
///  @param recipient The recipient of the funds.
///  @param amount Number of tokens to be transferred.
///  @param userData Arbitrary user inputted data
///  @custom:modifiers
///   - onlyHost
function operationSend(address spender, address recipient, uint256 amount, bytes memory userData) external;;
```

### operationUpgrade(address,uint256) (inherited from ISuperToken)

- **Signature**: `operationUpgrade(address,uint256)`
- **Visibility**: external
- **Source Range**: 20415:68:43

**Signature:**
```solidity
///  @dev Upgrade ERC20 to SuperToken by host contract.
///  @param account The account to be changed.
///  @param amount Number of tokens to be upgraded (in 18 decimals)
///  @custom:modifiers
///   - onlyHost
function operationUpgrade(address account, uint256 amount) external;;
```

### operationDowngrade(address,uint256) (inherited from ISuperToken)

- **Signature**: `operationDowngrade(address,uint256)`
- **Visibility**: external
- **Source Range**: 20730:70:43

**Signature:**
```solidity
///  @dev Downgrade ERC20 to SuperToken by host contract.
///  @param account The account to be changed.
///  @param amount Number of tokens to be downgraded (in 18 decimals)
///  @custom:modifiers
///   - onlyHost
function operationDowngrade(address account, uint256 amount) external;;
```

### operationUpgradeTo(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationUpgradeTo(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 21123:82:43

**Signature:**
```solidity
///  @dev Upgrade ERC20 to SuperToken by host contract and transfer immediately.
///  @param account The account to be changed.
///  @param to The account to receive upgraded tokens
///  @param amount Number of tokens to be upgraded (in 18 decimals)
///  @custom:modifiers
///   - onlyHost
function operationUpgradeTo(address account, address to, uint256 amount) external;;
```

### operationDowngradeTo(address,address,uint256) (inherited from ISuperToken)

- **Signature**: `operationDowngradeTo(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 21534:84:43

**Signature:**
```solidity
///  @dev Downgrade ERC20 to SuperToken by host contract and transfer immediately.
///  @param account The account to be changed.
///  @param to The account to receive downgraded tokens
///  @param amount Number of tokens to be downgraded (in 18 decimals)
///  @custom:modifiers
///   - onlyHost
function operationDowngradeTo(address account, address to, uint256 amount) external;;
```
