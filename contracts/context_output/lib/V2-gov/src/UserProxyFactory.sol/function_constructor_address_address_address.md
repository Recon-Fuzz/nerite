# Function: constructor(address,address,address)

**Contract**: [lib/V2-gov/src/UserProxyFactory.sol/contract_UserProxyFactory.md]

## Metadata

- **Contract**: UserProxyFactory
- **Signature**: `constructor(address,address,address)`
- **Visibility**: public
- **Source Range**: 382:153:25

## Implementation

```solidity
constructor(address _lqty, address _lusd, address _stakingV1) {
    userProxyImplementation = address(new UserProxy(_lqty, _lusd, _stakingV1));
}
```

## State Variable Writes

- **userProxyImplementation** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: UserProxyFactory.constructor(address,address,address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: UserProxyFactory
```
