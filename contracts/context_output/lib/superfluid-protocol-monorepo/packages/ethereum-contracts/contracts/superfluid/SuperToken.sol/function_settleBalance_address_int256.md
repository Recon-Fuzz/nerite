# Function: settleBalance(address,int256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `settleBalance(address,int256)`
- **Visibility**: external
- **Source Range**: 10173:226:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.settleBalance implementation
function settleBalance(address account, int256 delta) virtual override external onlyAgreement() {
    _sharedSettledBalances[account] = _sharedSettledBalances[account] + delta;
}
```

## Related Implementations

### onlyAgreement()

- **Kind**: modifier
- **Source**: 13167:180:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:onlyAgreement()`

```solidity
modifier onlyAgreement() {
    if (!_host.isAgreementClassListed(ISuperAgreement(msg.sender))) {
        revert SF_TOKEN_ONLY_LISTED_AGREEMENT();
    }
    _;
}
```

## External Calls

- **ISuperfluid::isAgreementClassListed(contract ISuperAgreement)**

## State Variable Reads

- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.settleBalance(address,int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] 🔒 MODIFIER: SuperfluidToken.onlyAgreement() (NodeID: 1)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.settleBalance implementation

### Interface Documentation

 @notice Settle balance from an account by the agreement
 @dev The agreement needs to make sure that the balance delta is balanced afterwards
 @param account Account to query.
 @param delta Amount of balance delta to be settled
 @custom:modifiers 
  - onlyAgreement
