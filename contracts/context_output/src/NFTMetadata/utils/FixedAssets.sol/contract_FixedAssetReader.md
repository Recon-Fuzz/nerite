# Contract: FixedAssetReader

## Metadata

- **Name**: FixedAssetReader
- **Type**: Contract
- **Path**: src/NFTMetadata/utils/FixedAssets.sol

## State Variables

### pointer

```solidity
address public immutable pointer
```

### assets

```solidity
mapping(bytes4 => Asset) public assets
```

## Structs

### Asset

```solidity
struct Asset {
    uint128 start;
    uint128 end;
}
```

## Public/External Functions

### readAsset(bytes4)

- **Signature**: `readAsset(bytes4)`
- **Visibility**: public
- **Source Range**: 286:177:103
- **Details**: [function_readAsset_bytes4.md](./function_readAsset_bytes4.md)

**Signature:**
```solidity
function readAsset(bytes4 _sig) public view returns (string memory);
```

### constructor(address,bytes4[],struct FixedAssetReader.Asset[])

- **Signature**: `constructor(address,bytes4[],struct FixedAssetReader.Asset[])`
- **Visibility**: public
- **Source Range**: 469:302:103
- **Details**: [function_constructor_address_bytes4[]_struct_FixedAssetReader_Asset[].md](./function_constructor_address_bytes4[]_struct_FixedAssetReader_Asset[].md)

**Signature:**
```solidity
constructor(address _pointer, bytes4[] memory _sigs, Asset[] memory _assets);
```
