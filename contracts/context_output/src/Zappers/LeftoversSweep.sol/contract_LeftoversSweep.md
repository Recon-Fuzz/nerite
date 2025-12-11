# Contract: LeftoversSweep

## Metadata

- **Name**: LeftoversSweep
- **Type**: Contract
- **Path**: src/Zappers/LeftoversSweep.sol

## Structs

### InitialBalances

```solidity
struct InitialBalances {
    IERC20[4] tokens;
    uint256[4] balances;
    address receiver;
}
```
