# Function: getToken(uint256)

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `getToken(uint256)`
- **Visibility**: external
- **Source Range**: 12019:563:56

## Implementation

```solidity
function getToken(uint256 _index) external view returns (IERC20Metadata) {
    if (_index == 0) return token0; else if (_index == 1) return token1; else if (_index == 2) return token2; else if (_index == 3) return token3; else if (_index == 4) return token4; else if (_index == 5) return token5; else if (_index == 6) return token6; else if (_index == 7) return token7; else if (_index == 8) return token8; else if (_index == 9) return token9; else revert("Invalid index");
}
```

## State Variable Reads

- **token0** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token1** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token2** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token3** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token4** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token5** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token6** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token7** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token8** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]
- **token9** (`contract IERC20Metadata`) [lib/openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Metadata.sol/interface_IERC20Metadata.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.getToken(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```
