# Function: transferAll(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `transferAll(address)`
- **Visibility**: external
- **Source Range**: 22524:166:161

## Implementation

```solidity
function transferAll(address recipient) virtual override external {
    _transferFrom(msg.sender, msg.sender, recipient, balanceOf(msg.sender));
}
```

## Related Implementations

### _transferFrom(address,address,address,uint256)

- **Kind**: internal
- **Source**: 8877:691:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_transferFrom(address,address,address,uint256)`

```solidity
///  @notice in the original openzeppelin implementation, transfer() and transferFrom()
///  did invoke the send and receive hooks, as required by ERC777.
///  This hooks were removed from super tokens for ERC20 transfers in order to protect
///  interfacing contracts which don't expect invocations of ERC20 transfers to potentially reenter.
///  Interactions relying on ERC777 hooks need to use the ERC777 interface.
///  For more context, see https://github.com/superfluid-finance/protocol-monorepo/wiki/About-ERC-777
function _transferFrom(address spender, address holder, address recipient, uint amount) internal returns (bool) {
    if (holder == address(0)) {
        revert SUPER_TOKEN_TRANSFER_FROM_ZERO_ADDRESS();
    }
    if (recipient == address(0)) {
        revert SUPER_TOKEN_TRANSFER_TO_ZERO_ADDRESS();
    }
    address operator = msg.sender;
    _move(operator, holder, recipient, amount, "", "");
    if (spender != holder) {
        _approve(holder, spender, _allowances[holder][spender].sub(amount, "SuperToken: transfer amount exceeds allowance"));
    }
    return true;
}
```

### balanceOf(address)

- **Kind**: internal
- **Source**: 16959:356:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:balanceOf(address)`

```solidity
function balanceOf(address account) virtual override public view returns (uint256 balance) {
    (int256 availableBalance, , , ) = super.realtimeBalanceOfNow(account);
    return (availableBalance < 0) ? 0 : uint256(availableBalance);
}
```

### realtimeBalanceOfNow(address)

- **Kind**: internal
- **Source**: 3526:428:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:realtimeBalanceOfNow(address)`

```solidity
/// @dev ISuperfluidToken.realtimeBalanceOfNow implementation
function realtimeBalanceOfNow(address account) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit, uint256 timestamp) {
    timestamp = _host.getNow();
    (availableBalance, deposit, owedDeposit) = realtimeBalanceOf(account, timestamp);
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

### _approve(address,address,uint256)

- **Kind**: internal
- **Source**: 13858:406:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_approve(address,address,uint256)`

```solidity
///  @notice Sets `amount` as the allowance of `spender` over the `account`s tokens.
///  This is internal function is equivalent to `approve`, and can be used to
///  e.g. set automatic allowances for certain subsystems, etc.
///  Emits an {Approval} event.
///  Requirements:
///  - `account` cannot be the zero address.
///  - `spender` cannot be the zero address.
function _approve(address account, address spender, uint256 amount) internal {
    if (account == address(0)) {
        revert SUPER_TOKEN_APPROVE_FROM_ZERO_ADDRESS();
    }
    if (spender == address(0)) {
        revert SUPER_TOKEN_APPROVE_TO_ZERO_ADDRESS();
    }
    _allowances[account][spender] = amount;
    emit Approval(account, spender, amount);
}
```

### sub(uint256,uint256,string)

- **Kind**: internal
- **Source**: 4959:201:116
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol:SafeMath:sub(uint256,uint256,string)`

```solidity
///  @dev Returns the subtraction of two unsigned integers, reverting with custom message on
///  overflow (when the result is negative).
///  CAUTION: This function is deprecated because it requires allocating memory for the error
///  message unnecessarily. For custom revert reasons use {trySub}.
///  Counterpart to Solidity's `-` operator.
///  Requirements:
///  - Subtraction cannot overflow.
function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
    unchecked {
        require(b <= a, errorMessage);
        return a - b;
    }
}
```

## External Calls

- **ISuperfluid::getNow()**
- **ISuperAgreement::realtimeBalanceOf(contract ISuperfluidToken,address,uint256)**
- **ISuperfluid::mapAgreementClasses(uint256)**

## State Variable Reads

- **_allowances** (`mapping(address => mapping(address => uint256))`)
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_allowances** (`mapping(address => mapping(address => uint256))`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.transferAll(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: SuperToken._transferFrom(address,address,address,uint256) (NodeID: 1)
      💬 Args: [msg.sender, msg.sender, recipient, balanceOf(msg.sender)]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperToken.balanceOf(address) (NodeID: 10)
    │   💬 Args: [msg.sender]
    │   👁️  Def: public
    │ └─ [3] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOfNow(address) (NodeID: 11)
    │     💬 Args: [account]
    │     👁️  Def: public
    │   └─ [4] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 12)
    │       💬 Args: [account, timestamp]
    │       👁️  Def: public
    │     ├─ [5] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 13)
    │     │   💬 Args: [account]
    │     │   👁️  Def: public
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 14)
    │         💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
    │         👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperToken._move(address,address,address,uint256,bytes,bytes) (NodeID: 2)
    │   💬 Args: [operator, holder, recipient, amount, "", ""]
    │   👁️  Def: private
    │ └─ [3] ⚙️ FUNCTION: SuperfluidToken._move(address,address,int256) (NodeID: 3)
    │     💬 Args: [from, to, amount.toInt256()]
    │     👁️  Def: internal
    │   ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 7)
    │   │   💬 Args: [amount]
    │   │   👁️  Def: internal
    │   └─ [4] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 4)
    │       💬 Args: [from, _host.getNow()]
    │       👁️  Def: public
    │     ├─ [5] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 5)
    │     │   💬 Args: [account]
    │     │   👁️  Def: public
    │     └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 6)
    │         💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
    │         👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SuperToken._approve(address,address,uint256) (NodeID: 8)
        💬 Args: [holder, spender, _allowances[holder][spender].sub(amount, "SuperToken: transfer amount exceeds allowance")]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: SafeMath.sub(uint256,uint256,string) (NodeID: 9)
          💬 Args: [_allowances[holder][spender], amount, "SuperToken: transfer amount exceeds allowance"]
          👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Transfer all available balance from `msg.sender` to `recipient`
