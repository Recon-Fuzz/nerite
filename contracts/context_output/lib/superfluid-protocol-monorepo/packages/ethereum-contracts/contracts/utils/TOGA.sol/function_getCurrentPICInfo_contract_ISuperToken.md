# Function: getCurrentPICInfo(contract ISuperToken)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `getCurrentPICInfo(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 7397:360:183

## Implementation

```solidity
function getCurrentPICInfo(ISuperToken token) override external view returns (address pic, uint256 bond, int96 exitRate) {
    (, exitRate, , ) = _cfa.getFlow(token, address(this), _currentPICs[token].addr);
    return (_currentPICs[token].addr, _getCurrentPICBond(token), exitRate);
}
```

## Related Implementations

### _getCurrentPICBond(contract ISuperToken)

- **Kind**: internal
- **Source**: 10438:356:183
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol:TOGA:_getCurrentPICBond(contract ISuperToken)`

```solidity
function _getCurrentPICBond(ISuperToken token) internal view returns (uint256 bond) {
    (int256 availBal, uint256 deposit, , ) = token.realtimeBalanceOfNow(address(this));
    return ((availBal + int256(deposit)) > 0) ? uint256(availBal + int256(deposit)) : 0;
}
```

## External Calls

- **IConstantFlowAgreementV1::getFlow(contract ISuperfluidToken,address,address)**
- **ISuperToken::realtimeBalanceOfNow(address)**

## State Variable Reads

- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_currentPICs** (`mapping(contract ISuperToken => struct TOGA.LockablePIC)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TOGA.getCurrentPICInfo(contract ISuperToken) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TOGA._getCurrentPICBond(contract ISuperToken) (NodeID: 1)
      💬 Args: [token]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev get info about the state - most importantly the bond amount - of the current PIC for the given token.
 @param token The token for which to get PIC info
 Notes:
 The bond changes dynamically and can both grow or shrink between 2 blocks.
 Even the PIC itself could change anytime, this being a continuous auction.
 @return pic Address of the current PIC. Returns the ZERO address if not set
 @return bond The current bond amount. Can shrink or grow over time, depending on exitRate and rewards accrued
 @return exitRate The current flowrate of given tokens from the contract to the PIC
