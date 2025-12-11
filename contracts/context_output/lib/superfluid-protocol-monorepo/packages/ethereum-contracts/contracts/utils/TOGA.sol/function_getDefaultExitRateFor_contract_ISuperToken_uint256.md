# Function: getDefaultExitRateFor(contract ISuperToken,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `getDefaultExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: public
- **Source Range**: 7912:222:183

## Implementation

```solidity
function getDefaultExitRateFor(ISuperToken, uint256 bondAmount) override public view returns (int96 exitRate) {
    return capToInt96((bondAmount / (minBondDuration * 4)).toInt256());
}
```

## Related Implementations

### capToInt96(int256)

- **Kind**: internal
- **Source**: 7763:143:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:capToInt96(int256)`

```solidity
function capToInt96(int256 value) internal pure returns (int96) {
    return (value < type(int96).max) ? int96(value) : type(int96).max;
}
```

### toInt256(uint256)

- **Kind**: internal
- **Source**: 34781:297:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt256(uint256)`

```solidity
///  @dev Converts an unsigned uint256 into a signed int256.
///  Requirements:
///  - input must be less than or equal to maxInt256.
///  _Available since v3.0._
function toInt256(uint256 value) internal pure returns (int256) {
    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
    return int256(value);
}
```

## State Variable Reads

- **minBondDuration** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TOGA.getDefaultExitRateFor(contract ISuperToken,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: TOGA.capToInt96(int256) (NodeID: 1)
      💬 Args: [(bondAmount / (minBondDuration * 4)).toInt256()]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 2)
        💬 Args: [(bondAmount / (minBondDuration * 4))]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Get the exit rate set by default for the given token and bond amount
 @param token The token for which to get info
 @param bondAmount The bond amount for which to make the calculation
 @return exitRate The exit rate set by default for a bid with the given bond amount for the given token
