# Function: operationDowngradeTo(address,address,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `operationDowngradeTo(address,address,uint256)`
- **Visibility**: external
- **Source Range**: 29680:198:161

## Implementation

```solidity
function operationDowngradeTo(address account, address to, uint256 amount) virtual override external onlyHost() {
    _downgrade(msg.sender, account, to, amount, "", "");
}
```

## Related Implementations

### _downgrade(address,address,address,uint256,bytes,bytes)

- **Kind**: internal
- **Source**: 25305:1151:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_downgrade(address,address,address,uint256,bytes,bytes)`

```solidity
function _downgrade(address operator, address account, address to, uint256 amount, bytes memory userData, bytes memory operatorData) internal {
    if (address(_underlyingToken) == address(0)) revert SUPER_TOKEN_NO_UNDERLYING_TOKEN();
    (uint256 underlyingAmount, uint256 adjustedAmount) = _toUnderlyingAmount(amount);
    _burn(operator, account, adjustedAmount, userData.length != 0, userData, operatorData);
    uint256 amountBefore = _underlyingToken.balanceOf(address(this));
    _underlyingToken.safeTransfer(to, underlyingAmount);
    uint256 amountAfter = _underlyingToken.balanceOf(address(this));
    uint256 actualDowngradedAmount = amountBefore - amountAfter;
    if (underlyingAmount != actualDowngradedAmount) revert SUPER_TOKEN_INFLATIONARY_DEFLATIONARY_NOT_SUPPORTED();
    emit TokenDowngraded(account, adjustedAmount);
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

### _burn(address,address,uint256,bool,bytes,bytes)

- **Kind**: internal
- **Source**: 12820:606:161
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol:SuperToken:_burn(address,address,uint256,bool,bytes,bytes)`

```solidity
///  @dev Burn tokens
///  @param from address token holder address
///  @param amount uint256 amount of tokens to burn
///  @param userData bytes extra information provided by the token holder
///  @param operatorData bytes extra information provided by the operator (if any)
function _burn(address operator, address from, uint256 amount, bool invokeHook, bytes memory userData, bytes memory operatorData) internal {
    if (from == address(0)) {
        revert SUPER_TOKEN_BURN_FROM_ZERO_ADDRESS();
    }
    if (invokeHook) {
        _callTokensToSend(operator, from, address(0), amount, userData, operatorData);
    }
    SuperfluidToken._burn(from, amount);
    emit Burned(operator, from, amount, userData, operatorData);
    emit Transfer(from, address(0), amount);
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

### _burn(address,uint256)

- **Kind**: internal
- **Source**: 5933:440:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:_burn(address,uint256)`

```solidity
function _burn(address account, uint256 amount) internal {
    (int256 availableBalance, , ) = realtimeBalanceOf(account, _host.getNow());
    if (availableBalance < amount.toInt256()) {
        revert SF_TOKEN_BURN_INSUFFICIENT_BALANCE();
    }
    _sharedSettledBalances[account] = _sharedSettledBalances[account] - amount.toInt256();
    _totalSupply = _totalSupply - amount;
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
- **IERC20::safeTransfer(contract IERC20,address,uint256)**
- **IERC1820Registry::getInterfaceImplementer(address,bytes32)**
- **IERC777Sender::tokensToSend(address,address,address,uint256,bytes,bytes)**
- **ISuperfluid::getNow()**
- **ISuperAgreement::realtimeBalanceOf(contract ISuperfluidToken,address,uint256)**
- **ISuperfluid::mapAgreementClasses(uint256)**

## State Variable Reads

- **_underlyingToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **_underlyingDecimals** (`uint8`)
- **_STANDARD_DECIMALS** (`uint8`)
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.operationDowngradeTo(address,address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._downgrade(address,address,address,uint256,bytes,bytes) (NodeID: 1)
  │   💬 Args: [msg.sender, account, to, amount, "", ""]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperToken._toUnderlyingAmount(uint256) (NodeID: 2)
  │ │   💬 Args: [amount]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SuperToken._burn(address,address,uint256,bool,bytes,bytes) (NodeID: 3)
  │     💬 Args: [operator, account, adjustedAmount, userData.length != 0, userData, operatorData]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperToken._callTokensToSend(address,address,address,uint256,bytes,bytes) (NodeID: 4)
  │   │   💬 Args: [operator, from, address(0), amount, userData, operatorData]
  │   │   👁️  Def: private
  │   └─ [3] ⚙️ FUNCTION: SuperfluidToken._burn(address,uint256) (NodeID: 5)
  │       💬 Args: [from, amount]
  │       👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 6)
  │     │   💬 Args: [account, _host.getNow()]
  │     │   👁️  Def: public
  │     │ ├─ [5] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 7)
  │     │ │   💬 Args: [account]
  │     │ │   👁️  Def: public
  │     │ └─ [5] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
  │     │     💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
  │     │     👁️  Def: internal
  │     ├─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 9)
  │     │   💬 Args: [amount]
  │     │   👁️  Def: internal
  │     └─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 10)
  │         💬 Args: [amount]
  │         👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidToken.onlyHost() (NodeID: 11)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Downgrade ERC20 to SuperToken by host contract and transfer immediately.
 @param account The account to be changed.
 @param to The account to receive downgraded tokens
 @param amount Number of tokens to be downgraded (in 18 decimals)
 @custom:modifiers
  - onlyHost
