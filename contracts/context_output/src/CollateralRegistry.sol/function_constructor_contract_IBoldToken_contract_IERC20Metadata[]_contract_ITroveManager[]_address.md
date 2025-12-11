# Function: constructor(contract IBoldToken,contract IERC20Metadata[],contract ITroveManager[],address)

**Contract**: [src/CollateralRegistry.sol/contract_CollateralRegistry.md]

## Metadata

- **Contract**: CollateralRegistry
- **Signature**: `constructor(contract IBoldToken,contract IERC20Metadata[],contract ITroveManager[],address)`
- **Visibility**: public
- **Source Range**: 1856:2069:207

## Implementation

```solidity
constructor(IBoldToken _boldToken, IERC20Metadata[] memory _tokens, ITroveManager[] memory _troveManagers, address _governor) {
    uint256 numTokens = _tokens.length;
    require(numTokens > 0, "Collateral list cannot be empty");
    require(numTokens <= 10, "Collateral list too long");
    totalCollaterals = numTokens;
    boldToken = _boldToken;
    token0 = _tokens[0];
    token1 = (numTokens > 1) ? _tokens[1] : IERC20Metadata(address(0));
    token2 = (numTokens > 2) ? _tokens[2] : IERC20Metadata(address(0));
    token3 = (numTokens > 3) ? _tokens[3] : IERC20Metadata(address(0));
    token4 = (numTokens > 4) ? _tokens[4] : IERC20Metadata(address(0));
    token5 = (numTokens > 5) ? _tokens[5] : IERC20Metadata(address(0));
    token6 = (numTokens > 6) ? _tokens[6] : IERC20Metadata(address(0));
    token7 = (numTokens > 7) ? _tokens[7] : IERC20Metadata(address(0));
    token8 = (numTokens > 8) ? _tokens[8] : IERC20Metadata(address(0));
    token9 = (numTokens > 9) ? _tokens[9] : IERC20Metadata(address(0));
    troveManager0 = _troveManagers[0];
    troveManager1 = (numTokens > 1) ? _troveManagers[1] : ITroveManager(address(0));
    troveManager2 = (numTokens > 2) ? _troveManagers[2] : ITroveManager(address(0));
    troveManager3 = (numTokens > 3) ? _troveManagers[3] : ITroveManager(address(0));
    troveManager4 = (numTokens > 4) ? _troveManagers[4] : ITroveManager(address(0));
    troveManager5 = (numTokens > 5) ? _troveManagers[5] : ITroveManager(address(0));
    troveManager6 = (numTokens > 6) ? _troveManagers[6] : ITroveManager(address(0));
    troveManager7 = (numTokens > 7) ? _troveManagers[7] : ITroveManager(address(0));
    troveManager8 = (numTokens > 8) ? _troveManagers[8] : ITroveManager(address(0));
    troveManager9 = (numTokens > 9) ? _troveManagers[9] : ITroveManager(address(0));
    baseRate = INITIAL_BASE_RATE;
    emit BaseRateUpdated(INITIAL_BASE_RATE);
    governor = _governor;
}
```

## State Variable Writes

- **totalCollaterals** (`uint256`)
- **boldToken** (`contract IBoldToken`) [src/Interfaces/IBoldToken.sol/interface_IBoldToken.md]
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
- **baseRate** (`uint256`)
- **governor** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: CollateralRegistry.constructor(contract IBoldToken,contract IERC20Metadata[],contract ITroveManager[],address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: CollateralRegistry
```
