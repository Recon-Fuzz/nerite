# Function: operatorSend(address,address,uint256,bytes,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `operatorSend(address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 20040:440:161

## Implementation

```solidity
function operatorSend(address sender, address recipient, uint256 amount, bytes calldata userData, bytes calldata operatorData) virtual override external {
    address operator = msg.sender;
    if (!_operators.isOperatorFor(operator, sender)) revert SUPER_TOKEN_CALLER_IS_NOT_OPERATOR_FOR_HOLDER();
    _send(operator, sender, recipient, amount, userData, operatorData, true);
}
```

## Related Implementations

### isOperatorFor(struct ERC777Helper.Operators,address,address)

- **Kind**: internal
- **Source**: 1150:366:156
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/ERC777Helper.sol:ERC777Helper:isOperatorFor(struct ERC777Helper.Operators,address,address)`

```solidity
function isOperatorFor(Operators storage self, address operator, address tokenHolder) internal view returns (bool) {
    return ((operator == tokenHolder) || (self.defaultOperators[operator] && (!self.revokedDefaultOperators[tokenHolder][operator]))) || self.operators[tokenHolder][operator];
}
```

### _send(address,address,address,uint256,bytes,bytes,bool)

- **Kind**: internal
- **Source**: 10092:698:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_send(address,address,address,uint256,bytes,bytes,bool)`

```solidity
///  @dev Send tokens
///  @param operator address operator address
///  @param from address token holder address
///  @param to address recipient address
///  @param amount uint256 amount of tokens to transfer
///  @param userData bytes extra information provided by the token holder (if any)
///  @param operatorData bytes extra information provided by the operator (if any)
///  @param requireReceptionAck if true, contract recipients are required to implement ERC777TokensRecipient
function _send(address operator, address from, address to, uint256 amount, bytes memory userData, bytes memory operatorData, bool requireReceptionAck) internal {
    if (from == address(0)) {
        revert SUPER_TOKEN_TRANSFER_FROM_ZERO_ADDRESS();
    }
    if (to == address(0)) {
        revert SUPER_TOKEN_TRANSFER_TO_ZERO_ADDRESS();
    }
    _callTokensToSend(operator, from, to, amount, userData, operatorData);
    _move(operator, from, to, amount, userData, operatorData);
    _callTokensReceived(operator, from, to, amount, userData, operatorData, requireReceptionAck);
}
```

### _callTokensToSend(address,address,address,uint256,bytes,bytes)

- **Kind**: internal
- **Source**: 14737:523:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_callTokensToSend(address,address,address,uint256,bytes,bytes)`

```solidity
///  @dev Call from.tokensToSend() if the interface is registered
///  @param operator address operator requesting the transfer
///  @param from address token holder address
///  @param to address recipient address
///  @param amount uint256 amount of tokens to transfer
///  @param userData bytes extra information provided by the token holder (if any)
///  @param operatorData bytes extra information provided by the operator (if any)
function _callTokensToSend(address operator, address from, address to, uint256 amount, bytes memory userData, bytes memory operatorData) private {
    address implementer = ERC777Helper._ERC1820_REGISTRY.getInterfaceImplementer(from, ERC777Helper._TOKENS_SENDER_INTERFACE_HASH);
    if (implementer != address(0)) {
        IERC777Sender(implementer).tokensToSend(operator, from, to, amount, userData, operatorData);
    }
}
```

### _move(address,address,address,uint256,bytes,bytes)

- **Kind**: internal
- **Source**: 10796:379:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_move(address,address,address,uint256,bytes,bytes)`

```solidity
function _move(address operator, address from, address to, uint256 amount, bytes memory userData, bytes memory operatorData) private {
    SuperfluidToken._move(from, to, amount.toInt256());
    emit Sent(operator, from, to, amount, userData, operatorData);
    emit Transfer(from, to, amount);
}
```

### _move(address,address,int256)

- **Kind**: internal
- **Source**: 6379:453:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:_move(address,address,int256)`

```solidity
function _move(address from, address to, int256 amount) internal {
    (int256 availableBalance, , ) = realtimeBalanceOf(from, _host.getNow());
    if (availableBalance < amount) {
        revert SF_TOKEN_MOVE_INSUFFICIENT_BALANCE();
    }
    _sharedSettledBalances[from] = _sharedSettledBalances[from] - amount;
    _sharedSettledBalances[to] = _sharedSettledBalances[to] + amount;
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

### realtimeBalanceOf(address,uint256)

- **Kind**: internal
- **Source**: 2120:1334:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:realtimeBalanceOf(address,uint256)`

```solidity
/// @dev ISuperfluidToken.realtimeBalanceOf implementation
function realtimeBalanceOf(address account, uint256 timestamp) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit) {
    availableBalance = _sharedSettledBalances[account];
    ISuperAgreement[] memory activeAgreements = getAccountActiveAgreements(account);
    for (uint256 i = 0; i < activeAgreements.length; ++i) {
        (int256 agreementDynamicBalance, uint256 agreementDeposit, uint256 agreementOwedDeposit) = activeAgreements[i].realtimeBalanceOf(this, account, timestamp);
        deposit = deposit + agreementDeposit;
        owedDeposit = owedDeposit + agreementOwedDeposit;
        availableBalance = (availableBalance + agreementDynamicBalance) - ((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0).toInt256();
    }
}
```

### getAccountActiveAgreements(address)

- **Kind**: internal
- **Source**: 5267:218:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:getAccountActiveAgreements(address)`

```solidity
/// @dev ISuperfluidToken.getAccountActiveAgreements implementation
function getAccountActiveAgreements(address account) virtual override public view returns (ISuperAgreement[] memory) {
    return _host.mapAgreementClasses(~_inactiveAgreementBitmap[account]);
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

## External Calls

- **IERC1820Registry::getInterfaceImplementer(address,bytes32)**
- **IERC777Sender::tokensToSend(address,address,address,uint256,bytes,bytes)**
- **ISuperfluid::getNow()**
- **ISuperAgreement::realtimeBalanceOf(contract ISuperfluidToken,address,uint256)**
- **ISuperfluid::mapAgreementClasses(uint256)**
- **IERC777Recipient::tokensReceived(address,address,address,uint256,bytes,bytes)**
- **address::isContract(address)**

## State Variable Reads

- **_operators** (`struct ERC777Helper.Operators`)
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.operatorSend(address,address,uint256,bytes,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ERC777Helper.isOperatorFor(struct ERC777Helper.Operators,address,address) (NodeID: 1)
  │   💬 Args: [_operators, operator, sender]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperToken._send(address,address,address,uint256,bytes,bytes,bool) (NodeID: 2)
      💬 Args: [operator, sender, recipient, amount, userData, operatorData, true]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperToken._callTokensToSend(address,address,address,uint256,bytes,bytes) (NodeID: 3)
    │   💬 Args: [operator, from, to, amount, userData, operatorData]
    │   👁️  Def: private
    ├─ [2] ⚙️ FUNCTION: SuperToken._move(address,address,address,uint256,bytes,bytes) (NodeID: 4)
    │   💬 Args: [operator, from, to, amount, userData, operatorData]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: SuperfluidToken._move(address,address,int256) (NodeID: 5)
    │     💬 Args: [from, to, amount.toInt256()]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 9)
    │   │   💬 Args: [amount]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 6)
    │       💬 Args: [from, _host.getNow()]
    │       👁️  Def: public
    │     ├─ [5] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 7)
    │     │   💬 Args: [account]
    │     │   👁️  Def: public
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
    │         💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperToken._callTokensReceived(address,address,address,uint256,bytes,bytes,bool) (NodeID: 10)
        💬 Args: [operator, from, to, amount, userData, operatorData, requireReceptionAck]
        👁️  Def: private
```

## Documentation

### Interface Documentation

 @dev Moves `amount` tokens from `sender` to `recipient`. The caller must
 be an operator of `sender`.
 If send or receive hooks are registered for `sender` and `recipient`,
 the corresponding functions will be called with `userData` and
 `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
 @custom:emits a {Sent} event.
 @custom:requirements
 - `sender` cannot be the zero address.
 - `sender` must have at least `amount` tokens.
 - the caller must be an operator for `sender`.
 - `recipient` cannot be the zero address.
 - if `recipient` is a contract, it must implement the {IERC777Recipient}
 interface.

 @dev Moves `amount` tokens from `sender` to `recipient`. The caller must
 be an operator of `sender`.
 If send or receive hooks are registered for `sender` and `recipient`,
 the corresponding functions will be called with `data` and
 `operatorData`. See {IERC777Sender} and {IERC777Recipient}.
 Emits a {Sent} event.
 Requirements
 - `sender` cannot be the zero address.
 - `sender` must have at least `amount` tokens.
 - the caller must be an operator for `sender`.
 - `recipient` cannot be the zero address.
 - if `recipient` is a contract, it must implement the {IERC777Recipient}
 interface.
