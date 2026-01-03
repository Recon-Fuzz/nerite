# Function: constructor(contract FixedAssetReader)

**Contract**: [src/NFTMetadata/MetadataNFT.sol/contract_MetadataNFT.md]

## Metadata

- **Contract**: MetadataNFT
- **Signature**: `constructor(contract FixedAssetReader)`
- **Visibility**: public
- **Source Range**: 935:86:102

## Implementation

```solidity
constructor(FixedAssetReader _assetReader) {
    assetReader = _assetReader;
}
```

## State Variable Writes

- **assetReader** (`contract FixedAssetReader`) [src/NFTMetadata/utils/FixedAssets.sol/contract_FixedAssetReader.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: MetadataNFT.constructor(contract FixedAssetReader) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: MetadataNFT
```
