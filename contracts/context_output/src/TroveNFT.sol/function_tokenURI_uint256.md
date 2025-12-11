# Function: tokenURI(uint256)

**Contract**: [src/TroveNFT.sol/contract_TroveNFT.md]

## Metadata

- **Contract**: TroveNFT
- **Signature**: `tokenURI(uint256)`
- **Visibility**: public
- **Source Range**: 1137:724:276

## Implementation

```solidity
function tokenURI(uint256 _tokenId) override(ERC721, IERC721Metadata) public view returns (string memory) {
    LatestTroveData memory latestTroveData = troveManager.getLatestTroveData(_tokenId);
    IMetadataNFT.TroveData memory troveData = IMetadataNFT.TroveData({_tokenId: _tokenId, _owner: ownerOf(_tokenId), _collToken: address(collToken), _boldToken: address(boldToken), _collAmount: latestTroveData.entireColl, _debtAmount: latestTroveData.entireDebt, _interestRate: latestTroveData.annualInterestRate, _status: troveManager.getTroveStatus(_tokenId)});
    return metadataNFT.uri(troveData);
}
```

## Related Implementations

### ownerOf(uint256)

- **Kind**: internal
- **Source**: 2190:219:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:ownerOf(uint256)`

```solidity
///  @dev See {IERC721-ownerOf}.
function ownerOf(uint256 tokenId) virtual override public view returns (address) {
    address owner = _ownerOf(tokenId);
    require(owner != address(0), "ERC721: invalid token ID");
    return owner;
}
```

### _ownerOf(uint256)

- **Kind**: internal
- **Source**: 6702:115:96
- **Link**: `lib/openzeppelin-contracts/contracts/token/ERC721/ERC721.sol:ERC721:_ownerOf(uint256)`

```solidity
///  @dev Returns the owner of the `tokenId`. Does NOT revert if token doesn't exist
function _ownerOf(uint256 tokenId) virtual internal view returns (address) {
    return _owners[tokenId];
}
```

## External Calls

- **ITroveManager::getLatestTroveData(uint256)**
- **ITroveManager::getTroveStatus(uint256)**
- **IMetadataNFT::uri(struct IMetadataNFT.TroveData)**

## State Variable Reads

- **troveManager** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **collToken** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
- **metadataNFT** (`contract IMetadataNFT`) [src/NFTMetadata/MetadataNFT.sol/interface_IMetadataNFT.md]
- **_owners** (`mapping(uint256 => address)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TroveNFT.tokenURI(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: ERC721.ownerOf(uint256) (NodeID: 1)
      💬 Args: [_tokenId]
      👁️  Def: public
    └─ [2] ⚙️ FUNCTION: ERC721._ownerOf(uint256) (NodeID: 2)
        💬 Args: [tokenId]
        👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev Returns the Uniform Resource Identifier (URI) for `tokenId` token.
