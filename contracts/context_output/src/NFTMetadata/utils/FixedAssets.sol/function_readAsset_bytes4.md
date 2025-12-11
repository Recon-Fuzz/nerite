# Function: readAsset(bytes4)

**Contract**: [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Metadata

- **Contract**: FixedAssetReader
- **Signature**: `readAsset(bytes4)`
- **Visibility**: public
- **Source Range**: 286:177:254

## Implementation

```solidity
function readAsset(bytes4 _sig) public view returns (string memory) {
    return string(SSTORE2.read(pointer, uint256(assets[_sig].start), uint256(assets[_sig].end)));
}
```

## Related Implementations

### read(address,uint256,uint256)

- **Kind**: internal
- **Source**: 11649:912:2
- **Link**: `lib/Solady/src/utils/SSTORE2.sol:SSTORE2:read(address,uint256,uint256)`

```solidity
/// @dev Returns a slice of the data on `pointer` from `start` to `end`.
///  `start` and `end` will be clamped to the range `[0, args.length]`.
///  The `pointer` MUST be deployed via the SSTORE2 write functions.
///  Otherwise, the behavior is undefined.
///  Out-of-gas reverts if `pointer` does not have any code.
function read(address pointer, uint256 start, uint256 end) internal view returns (bytes memory data) {
    /// @solidity memory-safe-assembly
    assembly {
        data := mload(0x40)
        if iszero(lt(end, 0xffff)) {
            end := 0xffff
        }
        let d := mul(sub(end, start), lt(start, end))
        extcodecopy(pointer, add(data, 0x1f), start, add(d, 0x01))
        if iszero(and(0xff, mload(add(data, d)))) {
            let n := sub(extcodesize(pointer), 0x01)
            returndatacopy(returndatasize(), returndatasize(), shr(64, n))
            d := mul(gt(n, start), sub(d, mul(gt(end, n), sub(end, n))))
        }
        mstore(data, d)
        mstore(add(add(data, 0x20), d), 0)
        mstore(0x40, add(add(data, 0x40), d))
    }
}
```

## State Variable Reads

- **pointer** (`address`)
- **assets** (`mapping(bytes4 => struct FixedAssetReader.Asset)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: FixedAssetReader.readAsset(bytes4) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SSTORE2.read(address,uint256,uint256) (NodeID: 1)
      💬 Args: [pointer, uint256(assets[_sig].start), uint256(assets[_sig].end)]
      👁️  Def: internal
```
