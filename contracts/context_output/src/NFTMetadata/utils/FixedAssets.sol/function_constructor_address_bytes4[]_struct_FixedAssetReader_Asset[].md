# Function: constructor(address,bytes4[],struct FixedAssetReader.Asset[])

**Contract**: [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Metadata

- **Contract**: FixedAssetReader
- **Signature**: `constructor(address,bytes4[],struct FixedAssetReader.Asset[])`
- **Visibility**: public
- **Source Range**: 469:302:254

## Implementation

```solidity
constructor(address _pointer, bytes4[] memory _sigs, Asset[] memory _assets) {
    pointer = _pointer;
    require(_sigs.length == _assets.length, "FixedAssetReader: Invalid input");
    for (uint256 i = 0; i < _sigs.length; i++) {
        assets[_sigs[i]] = _assets[i];
    }
}
```

## State Variable Writes

- **pointer** (`address`)
- **assets** (`mapping(bytes4 => struct FixedAssetReader.Asset)`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: FixedAssetReader.constructor(address,bytes4[],struct FixedAssetReader.Asset[]) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: FixedAssetReader
```
