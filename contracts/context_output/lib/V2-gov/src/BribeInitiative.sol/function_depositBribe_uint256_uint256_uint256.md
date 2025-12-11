# Function: depositBribe(uint256,uint256,uint256)

**Contract**: [lib/V2-gov/src/BribeInitiative.sol/contract_BribeInitiative.md]

## Metadata

- **Contract**: BribeInitiative
- **Signature**: `depositBribe(uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 2647:599:21

## Implementation

```solidity
/// @inheritdoc IBribeInitiative
function depositBribe(uint256 _boldAmount, uint256 _bribeTokenAmount, uint256 _epoch) external {
    uint256 epoch = governance.epoch();
    require(_epoch >= epoch, "BribeInitiative: now-or-future-epochs");
    bribeByEpoch[_epoch].remainingBoldAmount += _boldAmount;
    bribeByEpoch[_epoch].remainingBribeTokenAmount += _bribeTokenAmount;
    emit DepositBribe(msg.sender, _boldAmount, _bribeTokenAmount, _epoch);
    bold.safeTransferFrom(msg.sender, address(this), _boldAmount);
    bribeToken.safeTransferFrom(msg.sender, address(this), _bribeTokenAmount);
}
```

## External Calls

- **IGovernance::epoch()**
- **IERC20::safeTransferFrom(contract IERC20,address,address,uint256)**

## State Variable Reads

- **governance** (`contract IGovernance`) [lib/V2-gov/src/interfaces/IGovernance.sol/interface_IGovernance.md]
- **bold** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]
- **bribeToken** (`contract IERC20`) [lib/V2-gov/lib/openzeppelin-contracts/contracts/token/ERC20/IERC20.sol/interface_IERC20.md]

## State Variable Writes

- **bribeByEpoch** (`mapping(uint256 => struct IBribeInitiative.Bribe)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: BribeInitiative.depositBribe(uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
```

## Documentation

### Function Documentation

@inheritdoc IBribeInitiative

### Interface Documentation

@notice Deposit bribe tokens for a given epoch
 @dev The caller has to approve this contract to spend the BOLD and bribe tokens.
 The caller can only deposit bribes for future epochs
 @param _boldAmount Amount of BOLD tokens to deposit
 @param _bribeTokenAmount Amount of bribe tokens to deposit
 @param _epoch Epoch at which the bribe is deposited
