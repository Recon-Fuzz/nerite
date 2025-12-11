# Function: changeExitRate(contract ISuperToken,int96)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `changeExitRate(contract ISuperToken,int96)`
- **Visibility**: external
- **Source Range**: 8360:2029:183

## Implementation

```solidity
function changeExitRate(ISuperToken token, int96 newExitRate) override external {
    address currentPICAddr = _currentPICs[token].addr;
    require(msg.sender == currentPICAddr, "TOGA: only PIC allowed");
    require(newExitRate >= 0, "TOGA: negative exitRate not allowed");
    require((uint256(int256(newExitRate)) * minBondDuration) <= _getCurrentPICBond(token), "TOGA: exitRate too high");
    (, int96 curExitRate, , ) = _cfa.getFlow(token, address(this), currentPICAddr);
    if ((curExitRate > 0) && (newExitRate > 0)) {
        _host.callAgreement(_cfa, abi.encodeCall(_cfa.updateFlow, (token, currentPICAddr, newExitRate, new bytes(0))), "0x");
    } else if ((curExitRate == 0) && (newExitRate > 0)) {
        _host.callAgreement(_cfa, abi.encodeCall(_cfa.createFlow, (token, currentPICAddr, newExitRate, new bytes(0))), "0x");
    } else if ((curExitRate > 0) && (newExitRate == 0)) {
        _host.callAgreement(_cfa, abi.encodeCall(_cfa.deleteFlow, (token, address(this), currentPICAddr, new bytes(0))), "0x");
    }
    emit ExitRateChanged(token, newExitRate);
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
- **ISuperfluid::callAgreement(contract ISuperAgreement,bytes,bytes)**
- **ISuperToken::realtimeBalanceOfNow(address)**

## State Variable Reads

- **_currentPICs** (`mapping(contract ISuperToken => struct TOGA.LockablePIC)`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **minBondDuration** (`uint256`)
- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: TOGA.changeExitRate(contract ISuperToken,int96) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: TOGA._getCurrentPICBond(contract ISuperToken) (NodeID: 1)
      💬 Args: [token]
      👁️  Def: internal
```

## Documentation

### Interface Documentation

 @dev allows the current PIC for the given token to change the exit rate
 @param token The Super Token the exit rate should be changed for
 @param newExitRate The new exit rate. The same constraints as during bidding apply.
 Notes:
 newExitRate can't be higher than the value returned by getMaxExitRateFor() for the given token and bond.
 newExitRate can also be 0, this triggers closing of the flow from the contract to the PIC.
 If newExitRate is > 0 and no flow exists, a flow is created.
