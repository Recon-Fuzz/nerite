# Interface: IMetadataNFT

## Metadata

- **Name**: IMetadataNFT
- **Type**: Interface
- **Path**: src/NFTMetadata/MetadataNFT.sol

## Structs

### TroveData

```solidity
struct TroveData {
    uint256 _tokenId;
    address _owner;
    address _collToken;
    address _boldToken;
    uint256 _collAmount;
    uint256 _debtAmount;
    uint256 _interestRate;
    ITroveManager.Status _status;
}
```

## Public/External Functions

### uri(struct IMetadataNFT.TroveData)

- **Signature**: `uri(struct IMetadataNFT.TroveData)`
- **Visibility**: external
- **Source Range**: 631:80:253

**Signature:**
```solidity
function uri(TroveData memory _troveData) external view returns (string memory);;
```
