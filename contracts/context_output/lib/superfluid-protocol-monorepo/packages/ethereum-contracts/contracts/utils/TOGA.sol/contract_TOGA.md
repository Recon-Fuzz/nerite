# Contract: TOGA

## Metadata

- **Name**: TOGA
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol

## Implements Interfaces

- **IERC777Recipient** [lib/openzeppelin-contracts/contracts/token/ERC777/IERC777Recipient.sol/interface_IERC777Recipient.md]
- **ITOGAv3** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/interface_ITOGAv3.md]
- **ITOGAv1** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/interface_ITOGAv1.md]

## State Variables

### _currentPICs

```solidity
mapping(ISuperToken => LockablePIC) internal _currentPICs
```

**ISuperToken**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

### _host

```solidity
ISuperfluid internal immutable _host
```

**ISuperfluid**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

### _cfa

```solidity
IConstantFlowAgreementV1 internal immutable _cfa
```

**IConstantFlowAgreementV1**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

### minBondDuration

```solidity
uint256 public immutable minBondDuration
```

### _ERC1820_REG

```solidity
IERC1820Registry internal constant _ERC1820_REG = IERC1820Registry(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24)
```

**IERC1820Registry**: [lib/openzeppelin-contracts/contracts/utils/introspection/IERC1820Registry.sol/interface_IERC1820Registry.md]

## Structs

### LockablePIC

```solidity
struct LockablePIC {
    address addr;
    bool lock;
}
```

## Events

### NewPIC (inherited from ITOGAv1)

```solidity
///  @dev Emitted on a successful bid designating a PIC
///  @param token The Super token the new PIC bid for
///  @param pic The address of the new PIC
///  @param bond The size (amount) of the bond staked by the PIC
///  @param exitRate The flowrate at which the bond and accrued rewards will be streamed to the PIC
///  The exitRate must be greater or equal zero and respect the upper bound defined by getMaxExitRateFor()
event NewPIC(ISuperToken indexed token, address pic, uint256 bond, int96 exitRate);
```

### ExitRateChanged (inherited from ITOGAv1)

```solidity
///  @dev Emitted if a PIC changes the exit rate
///  @param token The Super token for which the exit rate was changed
///  @param exitRate The new flowrate of the given token from the contract to the PIC
event ExitRateChanged(ISuperToken indexed token, int96 exitRate);
```

### BondIncreased (inherited from ITOGAv3)

```solidity
///  @dev Emitted if a PIC increases its bond
///  @param additionalBond The additional amount added to the bond
event BondIncreased(ISuperToken indexed token, uint256 additionalBond);
```

## Public/External Functions

### constructor(contract ISuperfluid,uint256)

- **Signature**: `constructor(contract ISuperfluid,uint256)`
- **Visibility**: public
- **Source Range**: 6560:691:183
- **Details**: [function_constructor_contract_ISuperfluid_uint256.md](./function_constructor_contract_ISuperfluid_uint256.md)

**Signature:**
```solidity
constructor(ISuperfluid host_, uint256 minBondDuration_);
```

### getCurrentPIC(contract ISuperToken)

- **Signature**: `getCurrentPIC(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 7257:134:183
- **Details**: [function_getCurrentPIC_contract_ISuperToken.md](./function_getCurrentPIC_contract_ISuperToken.md)

**Signature:**
```solidity
function getCurrentPIC(ISuperToken token) override external view returns (address pic);
```

### getCurrentPICInfo(contract ISuperToken)

- **Signature**: `getCurrentPICInfo(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 7397:360:183
- **Details**: [function_getCurrentPICInfo_contract_ISuperToken.md](./function_getCurrentPICInfo_contract_ISuperToken.md)

**Signature:**
```solidity
function getCurrentPICInfo(ISuperToken token) override external view returns (address pic, uint256 bond, int96 exitRate);
```

### getDefaultExitRateFor(contract ISuperToken,uint256)

- **Signature**: `getDefaultExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: public
- **Source Range**: 7912:222:183
- **Details**: [function_getDefaultExitRateFor_contract_ISuperToken_uint256.md](./function_getDefaultExitRateFor_contract_ISuperToken_uint256.md)

**Signature:**
```solidity
function getDefaultExitRateFor(ISuperToken, uint256 bondAmount) override public view returns (int96 exitRate);
```

### getMaxExitRateFor(contract ISuperToken,uint256)

- **Signature**: `getMaxExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: external
- **Source Range**: 8140:214:183
- **Details**: [function_getMaxExitRateFor_contract_ISuperToken_uint256.md](./function_getMaxExitRateFor_contract_ISuperToken_uint256.md)

**Signature:**
```solidity
function getMaxExitRateFor(ISuperToken, uint256 bondAmount) override external view returns (int96 exitRate);
```

### changeExitRate(contract ISuperToken,int96)

- **Signature**: `changeExitRate(contract ISuperToken,int96)`
- **Visibility**: external
- **Source Range**: 8360:2029:183
- **Details**: [function_changeExitRate_contract_ISuperToken_int96.md](./function_changeExitRate_contract_ISuperToken_int96.md)

**Signature:**
```solidity
function changeExitRate(ISuperToken token, int96 newExitRate) override external;
```

### tokensReceived(address,address,address,uint256,bytes,bytes)

- **Signature**: `tokensReceived(address,address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 13305:732:183
- **Details**: [function_tokensReceived_address_address_address_uint256_bytes_bytes.md](./function_tokensReceived_address_address_address_uint256_bytes_bytes.md)

**Signature:**
```solidity
function tokensReceived(address, address from, address, uint256 amount, bytes calldata userData, bytes calldata) override external;
```
