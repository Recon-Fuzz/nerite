# Function: selfMint(address,uint256,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `selfMint(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 21242:333:161

## Implementation

```solidity
function selfMint(address account, uint256 amount, bytes memory userData) virtual override external onlySelf() {
    _mint(msg.sender, account, amount, userData.length != 0, userData.length != 0, userData, new bytes(0));
}
```

## Related Implementations

### _mint(address,address,uint256,bool,bool,bytes,bytes)

- **Kind**: internal
- **Source**: 11832:679:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_mint(address,address,uint256,bool,bool,bytes,bytes)`

```solidity
///  @dev Creates `amount` tokens and assigns them to `account`, increasing
///  the total supply.
///  If invokeHook is true and a send hook is registered for `account`,
///  the corresponding function will be called with `operator`, `userData` and `operatorData`.
///  See {IERC777Sender} and {IERC777Recipient}.
///  Emits {Minted} and {IERC20.Transfer} events.
///  Requirements
///  - `account` cannot be the zero address.
///  - if `invokeHook` and `requireReceptionAck` are set and `account` is a contract,
///    it must implement the {IERC777Recipient}
///  interface.
function _mint(address operator, address account, uint256 amount, bool invokeHook, bool requireReceptionAck, bytes memory userData, bytes memory operatorData) internal {
    if (account == address(0)) {
        revert SUPER_TOKEN_MINT_TO_ZERO_ADDRESS();
    }
    SuperfluidToken._mint(account, amount);
    if (invokeHook) {
        _callTokensReceived(operator, address(0), account, amount, userData, operatorData, requireReceptionAck);
    }
    emit Minted(operator, account, amount, userData, operatorData);
    emit Transfer(address(0), account, amount);
}
```

### _mint(address,uint256)

- **Kind**: internal
- **Source**: 5688:239:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:_mint(address,uint256)`

```solidity
function _mint(address account, uint256 amount) internal {
    _sharedSettledBalances[account] = _sharedSettledBalances[account] + amount.toInt256();
    _totalSupply = _totalSupply + amount;
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

### _callTokensReceived(address,address,address,uint256,bytes,bytes,bool)

- **Kind**: internal
- **Source**: 15949:690:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_callTokensReceived(address,address,address,uint256,bytes,bytes,bool)`

```solidity
///  @dev Call to.tokensReceived() if the interface is registered. Reverts if the recipient is a contract but
///  tokensReceived() was not registered for the recipient
///  @param operator address operator requesting the transfer
///  @param from address token holder address
///  @param to address recipient address
///  @param amount uint256 amount of tokens to transfer
///  @param userData bytes extra information provided by the token holder (if any)
///  @param operatorData bytes extra information provided by the operator (if any)
///  @param requireReceptionAck if true, contract recipients are required to implement ERC777TokensRecipient
function _callTokensReceived(address operator, address from, address to, uint256 amount, bytes memory userData, bytes memory operatorData, bool requireReceptionAck) private {
    address implementer = ERC777Helper._ERC1820_REGISTRY.getInterfaceImplementer(to, ERC777Helper._TOKENS_RECIPIENT_INTERFACE_HASH);
    if (implementer != address(0)) {
        IERC777Recipient(implementer).tokensReceived(operator, from, to, amount, userData, operatorData);
    } else if (requireReceptionAck) {
        if (to.isContract()) revert SUPER_TOKEN_NOT_ERC777_TOKENS_RECIPIENT();
    }
}
```

### onlySelf()

- **Kind**: modifier
- **Source**: 30060:111:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:onlySelf()`

```solidity
modifier onlySelf() {
    if (msg.sender != address(this)) revert SUPER_TOKEN_ONLY_SELF();
    _;
}
```

## External Calls

- **IERC1820Registry::getInterfaceImplementer(address,bytes32)**
- **IERC777Recipient::tokensReceived(address,address,address,uint256,bytes,bytes)**
- **address::isContract(address)**

## State Variable Reads

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.selfMint(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._mint(address,address,uint256,bool,bool,bytes,bytes) (NodeID: 1)
  │   💬 Args: [msg.sender, account, amount, userData.length != 0, userData.length != 0, userData, new bytes(0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperfluidToken._mint(address,uint256) (NodeID: 2)
  │ │   💬 Args: [account, amount]
  │ │   👁️  Def: internal
  │ │ └─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 3)
  │ │     💬 Args: [amount]
  │ │     👁️  Def: internal
  │ └─ [2] ⚙️ FUNCTION: SuperToken._callTokensReceived(address,address,address,uint256,bytes,bytes,bool) (NodeID: 4)
  │     💬 Args: [operator, address(0), account, amount, userData, operatorData, requireReceptionAck]
  │     👁️  Def: private
  └─ [1] 🔒 MODIFIER: SuperToken.onlySelf() (NodeID: 5)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Mint new tokens for the account
 If `userData` is not empty, the `tokensReceived` hook is invoked according to ERC777 semantics.
 @custom:modifiers
  - onlySelf
