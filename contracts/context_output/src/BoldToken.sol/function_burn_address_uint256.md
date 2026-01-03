# Function: burn(address,uint256)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `burn(address,uint256)`
- **Visibility**: external
- **Source Range**: 4874:184:53

## Implementation

```solidity
function burn(address _account, uint256 _amount) override external {
    _requireCallerIsCRorBOorTMorSP();
    ISuperToken(address(this)).selfBurn(_account, _amount, "");
}
```

## Related Implementations

### _requireCallerIsCRorBOorTMorSP()

- **Kind**: internal
- **Source**: 6239:377:53
- **Link**: `src/BoldToken.sol:BoldToken:_requireCallerIsCRorBOorTMorSP()`

```solidity
function _requireCallerIsCRorBOorTMorSP() internal view {
    require((((msg.sender == collateralRegistryAddress) || borrowerOperationsAddresses[msg.sender]) || troveManagerAddresses[msg.sender]) || stabilityPoolAddresses[msg.sender], "Bold: Caller is neither CR nor BorrowerOperations nor TroveManager nor StabilityPool");
}
```

## External Calls

- **ISuperToken::selfBurn(address,uint256,bytes)**

## State Variable Reads

- **collateralRegistryAddress** (`address`)
- **borrowerOperationsAddresses** (`mapping(address => bool)`)
- **troveManagerAddresses** (`mapping(address => bool)`)
- **stabilityPoolAddresses** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.burn(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BoldToken._requireCallerIsCRorBOorTMorSP() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
