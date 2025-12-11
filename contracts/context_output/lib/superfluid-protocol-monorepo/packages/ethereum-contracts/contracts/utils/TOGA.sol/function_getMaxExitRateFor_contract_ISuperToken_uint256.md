# Function: getMaxExitRateFor(contract ISuperToken,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `getMaxExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: external
- **Source Range**: 8140:214:183

## Implementation

```solidity
function getMaxExitRateFor(ISuperToken, uint256 bondAmount) override external view returns (int96 exitRate) {
    return capToInt96((bondAmount / minBondDuration).toInt256());
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
┌─ [0] ⚙️ FUNCTION: TOGA.getMaxExitRateFor(contract ISuperToken,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TOGA.capToInt96(int256) (NodeID: 1)
      💬 Args: [(bondAmount / minBondDuration).toInt256()]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 2)
        💬 Args: [(bondAmount / minBondDuration)]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Get the max exit which can be set for the given token and bond amount
 @param token The token for which to get info
 @param bondAmount The bond amount for which to calculate the max exit rate
 @return exitRate The max exit rate which can be set for the given bond amount and token
 This limit is enforced only at the time of setting or updating the flow from the contract to the PIC.
