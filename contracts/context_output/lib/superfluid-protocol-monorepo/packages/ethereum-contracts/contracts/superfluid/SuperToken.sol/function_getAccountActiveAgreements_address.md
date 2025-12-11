# Function: getAccountActiveAgreements(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `getAccountActiveAgreements(address)`
- **Visibility**: public
- **Source Range**: 5267:218:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.getAccountActiveAgreements implementation
function getAccountActiveAgreements(address account) virtual override public view returns (ISuperAgreement[] memory) {
    return _host.mapAgreementClasses(~_inactiveAgreementBitmap[account]);
}
```

## External Calls

- **ISuperfluid::mapAgreementClasses(uint256)**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.getAccountActiveAgreements implementation

### Interface Documentation

 @notice Get a list of agreements that is active for the account
 @dev An active agreement is one that has state for the account
 @param account Account to query
 @return activeAgreements List of accounts that have non-zero states for the account
