# Function: isPool(contract ISuperfluidToken,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `isPool(contract ISuperfluidToken,address)`
- **Visibility**: external
- **Source Range**: 39837:142:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function isPool(ISuperfluidToken token, address account) override external view returns (bool) {
    return _isPool(token, account);
}
```

## Related Implementations

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
}
```

## External Calls

- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**

## State Variable Reads

- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.isPool(contract ISuperfluidToken,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 1)
      💬 Args: [token, account]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
