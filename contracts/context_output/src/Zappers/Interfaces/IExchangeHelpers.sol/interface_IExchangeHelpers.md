# Interface: IExchangeHelpers

## Metadata

- **Name**: IExchangeHelpers
- **Type**: Interface
- **Path**: src/Zappers/Interfaces/IExchangeHelpers.sol

## Public/External Functions

### getCollFromBold(uint256,contract IERC20,uint256)

- **Signature**: `getCollFromBold(uint256,contract IERC20,uint256)`
- **Visibility**: external
- **Source Range**: 158:156:134

**Signature:**
```solidity
function getCollFromBold(uint256 _boldAmount, IERC20 _collToken, uint256 _desiredCollAmount) external returns (uint256, uint256);;
```
