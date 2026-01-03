# Interface: ISETHCustom

## Metadata

- **Name**: ISETHCustom
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/tokens/ISETH.sol
- **Documentation**:  @title Super ETH (SETH) custom token interface
   @author Superfluid

## Public/External Functions

### upgradeByETH()

- **Signature**: `upgradeByETH()`
- **Visibility**: external
- **Source Range**: 257:41:48

**Signature:**
```solidity
function upgradeByETH() external payable;;
```

### upgradeByETHTo(address)

- **Signature**: `upgradeByETHTo(address)`
- **Visibility**: external
- **Source Range**: 303:53:48

**Signature:**
```solidity
function upgradeByETHTo(address to) external payable;;
```

### downgradeToETH(uint256)

- **Signature**: `downgradeToETH(uint256)`
- **Visibility**: external
- **Source Range**: 361:43:48

**Signature:**
```solidity
function downgradeToETH(uint wad) external;;
```
