# Contract: SETHProxy

## Metadata

- **Name**: SETHProxy
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/tokens/SETH.sol
- **Documentation**:  @dev Super ETH (SETH) custom super token implementation
   @author Superfluid
   It is also called a Native-Asset Super Token.

## Implements Interfaces

- **ISETHCustom** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/tokens/ISETH.sol/interface_ISETHCustom.md]

## State Variables

### _storagePaddings (inherited from CustomSuperTokenBase)

```solidity
uint256[32] internal _storagePaddings
```

## Events

### TokenUpgraded

```solidity
event TokenUpgraded(address indexed account, uint256 amount);
```

### TokenDowngraded

```solidity
event TokenDowngraded(address indexed account, uint256 amount);
```

## Public/External Functions

### receive()

- **Signature**: `receive()`
- **Visibility**: external
- **Source Range**: 765:176:166
- **Details**: [function_receive.md](./function_receive.md)

**Signature:**
```solidity
/// fallback function which mints Super Tokens for received ETH
receive() override external payable;
```

### upgradeByETH()

- **Signature**: `upgradeByETH()`
- **Visibility**: external
- **Source Range**: 947:190:166
- **Details**: [function_upgradeByETH.md](./function_upgradeByETH.md)

**Signature:**
```solidity
function upgradeByETH() override external payable;
```

### upgradeByETHTo(address)

- **Signature**: `upgradeByETHTo(address)`
- **Visibility**: external
- **Source Range**: 1143:186:166
- **Details**: [function_upgradeByETHTo_address.md](./function_upgradeByETHTo_address.md)

**Signature:**
```solidity
function upgradeByETHTo(address to) override external payable;
```

### downgradeToETH(uint256)

- **Signature**: `downgradeToETH(uint256)`
- **Visibility**: external
- **Source Range**: 1335:225:166
- **Details**: [function_downgradeToETH_uint256.md](./function_downgradeToETH_uint256.md)

**Signature:**
```solidity
function downgradeToETH(uint wad) override external;
```

### fallback() (inherited from Proxy)

- **Signature**: `fallback()`
- **Visibility**: external
- **Source Range**: 2629:64:80
- **Details**: [function_fallback.md](./function_fallback.md)

**Signature:**
```solidity
///  @dev Fallback function that delegates calls to the address returned by `_implementation()`. Will run if no other
///  function in the contract matches the call data.
fallback() virtual external payable;
```

### initializeProxy(address) (inherited from UUPSProxy)

- **Signature**: `initializeProxy(address)`
- **Visibility**: external
- **Source Range**: 898:285:170
- **Details**: [function_initializeProxy_address.md](./function_initializeProxy_address.md)

**Signature:**
```solidity
///  @dev Proxy initialization function.
///       This should only be called once and it is permission-less.
///  @param initialAddress Initial logic contract code address to be used.
function initializeProxy(address initialAddress) external;
```
