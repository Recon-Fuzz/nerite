# Function: selfBurn(address,uint256,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `selfBurn(address,uint256,bytes)`
- **Visibility**: external
- **Source Range**: 21581:267:161

## Implementation

```solidity
function selfBurn(address account, uint256 amount, bytes memory userData) virtual override external onlySelf() {
    _burn(msg.sender, account, amount, userData.length != 0, userData, new bytes(0));
}
```

## Related Implementations

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
- **IERC777Sender::tokensToSend(address,address,address,uint256,bytes,bytes)**
- **ISuperfluid::getNow()**
- **ISuperAgreement::realtimeBalanceOf(contract ISuperfluidToken,address,uint256)**
- **ISuperfluid::mapAgreementClasses(uint256)**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_totalSupply** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperToken.selfBurn(address,uint256,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperToken._burn(address,address,uint256,bool,bytes,bytes) (NodeID: 1)
  │   💬 Args: [msg.sender, account, amount, userData.length != 0, userData, new bytes(0)]
  │   👁️  Def: internal
  │ ├─ [2] ⚙️ FUNCTION: SuperToken._callTokensToSend(address,address,address,uint256,bytes,bytes) (NodeID: 2)
  │ │   💬 Args: [operator, from, address(0), amount, userData, operatorData]
  │ │   👁️  Def: private
  │ └─ [2] ⚙️ FUNCTION: SuperfluidToken._burn(address,uint256) (NodeID: 3)
  │     💬 Args: [from, amount]
  │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 4)
  │   │   💬 Args: [account, _host.getNow()]
  │   │   👁️  Def: public
  │   │ ├─ [4] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 5)
  │   │ │   💬 Args: [account]
  │   │ │   👁️  Def: public
  │   │ └─ [4] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 6)
  │   │     💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
  │   │     👁️  Def: internal
  │   ├─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 7)
  │   │   💬 Args: [amount]
  │   │   👁️  Def: internal
  │   └─ [3] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 8)
  │       💬 Args: [amount]
  │       👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperToken.onlySelf() (NodeID: 9)
      💬 Args: [no args]
```

## Documentation

### Interface Documentation

 @dev Burn existing tokens for the account
 If `userData` is not empty, the `tokensToSend` hook is invoked according to ERC777 semantics.
 @custom:modifiers
  - onlySelf
