# Function: initialize(contract ISuperTokenFactory)

**Contract**: [src/BoldToken.sol/contract_BoldToken.md]

## Metadata

- **Contract**: BoldToken
- **Signature**: `initialize(contract ISuperTokenFactory)`
- **Visibility**: external
- **Source Range**: 3005:614:53

## Implementation

```solidity
function initialize(ISuperTokenFactory factory) external {
    ISuperTokenFactory(factory).initializeCustomSuperToken(address(this));
    ISuperToken(address(this)).initialize(IERC20(address(0)), 18, _NAME, _SYMBOL);
}
```

## External Calls

- **ISuperTokenFactory::initializeCustomSuperToken(address)**
- **ISuperToken::initialize(contract IERC20,uint8,string,string)**

## State Variable Reads

- **_NAME** (`string`)
- **_SYMBOL** (`string`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BoldToken.initialize(contract ISuperTokenFactory) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
