# Function: mint(address,uint256)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `mint(address,uint256)`
- **Visibility**: external
- **Source Range**: 4692:176:53

## Implementation

```solidity
function mint(address _account, uint256 _amount) override external {
    _requireCallerIsBOorAP();
    ISuperToken(address(this)).selfMint(_account, _amount, "");
}
```

## Related Implementations

### _requireCallerIsBOorAP()

- **Kind**: internal
- **Source**: 6014:219:53
- **Link**: `src/BoldToken.sol:BoldToken:_requireCallerIsBOorAP()`

```solidity
function _requireCallerIsBOorAP() internal view {
    require(borrowerOperationsAddresses[msg.sender] || activePoolAddresses[msg.sender], "BoldToken: Caller is not BO or AP");
}
```

## External Calls

- **ISuperToken::selfMint(address,uint256,bytes)**

## State Variable Reads

- **borrowerOperationsAddresses** (`mapping(address => bool)`)
- **activePoolAddresses** (`mapping(address => bool)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.mint(address,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: BoldToken._requireCallerIsBOorAP() (NodeID: 1)
      💬 Args: [no args]
      👁️  Def: internal
```
