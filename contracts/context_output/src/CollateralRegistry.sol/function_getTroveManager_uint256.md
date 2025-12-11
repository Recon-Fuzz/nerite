# Function: getTroveManager(uint256)

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `getTroveManager(uint256)`
- **Visibility**: public
- **Source Range**: 12588:637:207

## Implementation

```solidity
function getTroveManager(uint256 _index) public view returns (ITroveManager) {
    if (_index == 0) return troveManager0; else if (_index == 1) return troveManager1; else if (_index == 2) return troveManager2; else if (_index == 3) return troveManager3; else if (_index == 4) return troveManager4; else if (_index == 5) return troveManager5; else if (_index == 6) return troveManager6; else if (_index == 7) return troveManager7; else if (_index == 8) return troveManager8; else if (_index == 9) return troveManager9; else revert("Invalid index");
}
```

## State Variable Reads

- **troveManager0** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager1** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager2** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager3** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager4** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager5** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager6** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager7** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager8** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]
- **troveManager9** (`contract ITroveManager`) [src/Interfaces/ITroveManager.sol/interface_ITroveManager.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: CollateralRegistry.getTroveManager(uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```
