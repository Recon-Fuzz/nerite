# Function: operationUpgrade(address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `operationUpgrade(address,uint256)`
- **Visibility**: external
- **Source Range**: 29094:185:161

## Implementation

```solidity
function operationUpgrade(address account, uint256 amount) virtual override external onlyHost() {
    _upgrade(msg.sender, account, account, amount, "", "");
}
```

## Related Implementations

### _upgrade(address,address,address,uint256,bytes,bytes)

- **Kind**: internal
- **Source**: 24219:1080:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_upgrade(address,address,address,uint256,bytes,bytes)`

```solidity
function _upgrade(address operator, address account, address to, uint256 amount, bytes memory userData, bytes memory operatorData) internal {
    if (address(_underlyingToken) == address(0)) revert SUPER_TOKEN_NO_UNDERLYING_TOKEN();
    (uint256 underlyingAmount, uint256 adjustedAmount) = _toUnderlyingAmount(amount);
    uint256 amountBefore = _underlyingToken.balanceOf(address(this));
    _underlyingToken.safeTransferFrom(account, address(this), underlyingAmount);
    uint256 amountAfter = _underlyingToken.balanceOf(address(this));
    uint256 actualUpgradedAmount = amountAfter - amountBefore;
    if (underlyingAmount != actualUpgradedAmount) revert SUPER_TOKEN_INFLATIONARY_DEFLATIONARY_NOT_SUPPORTED();
    _mint(operator, to, adjustedAmount, userData.length != 0, userData.length != 0, userData, operatorData);
    emit TokenUpgraded(to, adjustedAmount);
}
```

### _toUnderlyingAmount(uint256)

- **Kind**: internal
- **Source**: 26558:964:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_toUnderlyingAmount(uint256)`

```solidity
///  @dev Handle decimal differences between underlying token and super token
function _toUnderlyingAmount(uint256 amount) private view returns (uint256 underlyingAmount, uint256 adjustedAmount) {
    uint256 factor;
    if (_underlyingDecimals < _STANDARD_DECIMALS) {
        factor = 10 ** (_STANDARD_DECIMALS - _underlyingDecimals);
        underlyingAmount = amount / factor;
        adjustedAmount = underlyingAmount * factor;
    } else if (_underlyingDecimals > _STANDARD_DECIMALS) {
        factor = 10 ** (_underlyingDecimals - _STANDARD_DECIMALS);
        underlyingAmount = amount * factor;
        adjustedAmount = amount;
    } else {
        underlyingAmount = adjustedAmount = amount;
    }
}
```

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

### onlyHost()

- **Kind**: modifier
- **Source**: 13353:133:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:onlyHost()`

```solidity
modifier onlyHost() {
    if (address(_host) != msg.sender) {
        revert SF_TOKEN_ONLY_HOST();
    }
    _;
}
```

## External Calls

- **IERC20::balanceOf(address)**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**
- **IERC1820Registry::getInterfaceImplementer(address,bytes32)**
- **IERC777Recipient::tokensReceived(address,address,address,uint256,bytes,bytes)**
- **address::isContract(address)**

## State Variable Reads

- **_underlyingToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_underlyingDecimals** (`uint8`)
- **_STANDARD_DECIMALS** (`uint8`)
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.operationUpgrade(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._upgrade(address,address,address,uint256,bytes,bytes) (NodeID: 1)
  │   💬 Args: [msg.sender, account, account, amount, "", ""]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperToken._toUnderlyingAmount(uint256) (NodeID: 2)
  │ │   💬 Args: [amount]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SuperToken._mint(address,address,uint256,bool,bool,bytes,bytes) (NodeID: 3)
  │     💬 Args: [operator, to, adjustedAmount, userData.length != 0, userData.length != 0, userData, operatorData]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperfluidToken._mint(address,uint256) (NodeID: 4)
  │   │   💬 Args: [account, amount]
  │   │   👁️  Def: internal
  │   │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 5)
  │   │     💬 Args: [amount]
  │   │     👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SuperToken._callTokensReceived(address,address,address,uint256,bytes,bytes,bool) (NodeID: 6)
  │       💬 Args: [operator, address(0), account, amount, userData, operatorData, requireReceptionAck]
  │       👁️  Def: private
  └─ [1] 🔒 MODIFIER: SuperfluidToken.onlyHost() (NodeID: 7)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Upgrade ERC20 to SuperToken by host contract.
 @param account The account to be changed.
 @param amount Number of tokens to be upgraded (in 18 decimals)
 @custom:modifiers
  - onlyHost
