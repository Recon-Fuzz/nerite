# Function: getApproxHint(uint256,uint256,uint256,uint256)

**Contract**: [src/HintHelpers.sol/contract_HintHelpers.md]

## Metadata

- **Contract**: HintHelpers
- **Signature**: `getApproxHint(uint256,uint256,uint256,uint256)`
- **Visibility**: external
- **Source Range**: 1102:1595:67

## Implementation

```solidity
function getApproxHint(uint256 _collIndex, uint256 _interestRate, uint256 _numTrials, uint256 _inputRandomSeed) external view returns (uint256 hintId, uint256 diff, uint256 latestRandomSeed) {
    ITroveManager troveManager = collateralRegistry.getTroveManager(_collIndex);
    ISortedTroves sortedTroves = troveManager.sortedTroves();
    uint256 arrayLength = troveManager.getTroveIdsCount();
    if (arrayLength == 0) {
        return (0, 0, _inputRandomSeed);
    }
    hintId = sortedTroves.getLast();
    diff = LiquityMath._getAbsoluteDifference(_interestRate, troveManager.getTroveAnnualInterestRate(hintId));
    latestRandomSeed = _inputRandomSeed;
    for (uint256 i = 1; i < _numTrials; ++i) {
        latestRandomSeed = uint256(keccak256(abi.encodePacked(latestRandomSeed)));
        uint256 arrayIndex = latestRandomSeed % arrayLength;
        uint256 currentId = troveManager.getTroveFromTroveIdsArray(arrayIndex);
        if (!sortedTroves.contains(currentId)) continue;
        uint256 currentInterestRate = troveManager.getTroveAnnualInterestRate(currentId);
        uint256 currentDiff = LiquityMath._getAbsoluteDifference(currentInterestRate, _interestRate);
        if (currentDiff < diff) {
            diff = currentDiff;
            hintId = currentId;
        }
    }
}
```

## Related Implementations

### _getAbsoluteDifference(uint256,uint256)

- **Kind**: internal
- **Source**: 2492:142:64
- **Link**: `src/Dependencies/LiquityMath.sol:LiquityMath:_getAbsoluteDifference(uint256,uint256)`

```solidity
function _getAbsoluteDifference(uint256 _a, uint256 _b) internal pure returns (uint256) {
    return (_a >= _b) ? (_a - _b) : (_b - _a);
}
```

## External Calls

- **ICollateralRegistry::getTroveManager(uint256)**
- **ITroveManager::sortedTroves()**
- **ITroveManager::getTroveIdsCount()**
- **ISortedTroves::getLast()**
- **ITroveManager::getTroveAnnualInterestRate(uint256)**
- **ITroveManager::getTroveFromTroveIdsArray(uint256)**
- **ISortedTroves::contains(uint256)**

## State Variable Reads

- **collateralRegistry** (`contract ICollateralRegistry`) [src/Interfaces/ICollateralRegistry.sol/interface_ICollateralRegistry.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: HintHelpers.getApproxHint(uint256,uint256,uint256,uint256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: LiquityMath._getAbsoluteDifference(uint256,uint256) (NodeID: 1)
  │   💬 Args: [_interestRate, troveManager.getTroveAnnualInterestRate(hintId)]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: LiquityMath._getAbsoluteDifference(uint256,uint256) (NodeID: 2)
      💬 Args: [currentInterestRate, _interestRate]
      👁️  Def: internal
```
