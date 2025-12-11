# Function: constructor(contract IAddressesRegistry)

**Contract**: [src/DefaultPool.sol/contract_DefaultPool.md]

## Metadata

- **Contract**: DefaultPool
- **Signature**: `constructor(contract IAddressesRegistry)`
- **Visibility**: public
- **Source Range**: 1348:558:208

## Implementation

```solidity
constructor(IAddressesRegistry _addressesRegistry) {
    collToken = _addressesRegistry.collToken();
    troveManagerAddress = address(_addressesRegistry.troveManager());
    activePoolAddress = address(_addressesRegistry.activePool());
    emit CollTokenAddressChanged(address(collToken));
    emit TroveManagerAddressChanged(troveManagerAddress);
    emit ActivePoolAddressChanged(activePoolAddress);
    collToken.approve(activePoolAddress, type(uint256).max);
}
```

## External Calls

- **IAddressesRegistry::collToken()**
- **IAddressesRegistry::troveManager()**
- **IAddressesRegistry::activePool()**
- **IERC20::approve(address,uint256)**

## State Variable Reads

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **troveManagerAddress** (`address`)
- **activePoolAddress** (`address`)

## State Variable Writes

- **collToken** (`contract IERC20`) [lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **troveManagerAddress** (`address`)
- **activePoolAddress** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: DefaultPool.constructor(contract IAddressesRegistry) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: DefaultPool
```
