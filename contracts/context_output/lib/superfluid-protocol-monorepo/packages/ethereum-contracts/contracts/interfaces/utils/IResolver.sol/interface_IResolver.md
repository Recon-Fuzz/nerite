# Interface: IResolver

## Metadata

- **Name**: IResolver
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IResolver.sol
- **Documentation**:  @title Abstraction for an address resolver contract
   @author Superfluid

## Events

### Set

```solidity
event Set(string indexed name, address target);
```

## Public/External Functions

### set(string,address)

- **Signature**: `set(string,address)`
- **Visibility**: external
- **Source Range**: 279:60:150

**Signature:**
```solidity
///  @dev Set resolver address name
function set(string calldata name, address target) external;;
```

### get(string)

- **Signature**: `get(string)`
- **Visibility**: external
- **Source Range**: 393:67:150

**Signature:**
```solidity
///  @dev Get address by name
function get(string calldata name) external view returns (address);;
```
