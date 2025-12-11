# Function: updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes)`
- **Visibility**: external
- **Source Range**: 13084:482:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function updateMemberUnits(ISuperfluidPool pool, address memberAddress, uint128 newUnits, bytes calldata ctx) override external returns (bytes memory newCtx) {
    if (AgreementLibrary.authorizeTokenAccess(pool.superToken(), ctx).msgSender != pool.admin()) {
        revert GDA_NOT_POOL_ADMIN();
    }
    newCtx = ctx;
    pool.updateMemberUnits(memberAddress, newUnits);
}
```

## Related Implementations

### authorizeTokenAccess(contract ISuperfluidToken,bytes)

- **Kind**: internal
- **Source**: 963:468:120
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/AgreementLibrary.sol:AgreementLibrary:authorizeTokenAccess(contract ISuperfluidToken,bytes)`

```solidity
///  @dev Authorize the msg.sender to access token agreement storage
///  NOTE:
///  - msg.sender must be the expected host contract.
///  - it should revert on unauthorized access.
function authorizeTokenAccess(ISuperfluidToken token, bytes memory ctx) internal view returns (ISuperfluid.Context memory) {
    require(token.getHost() == msg.sender, "unauthorized host");
    require(ISuperfluid(msg.sender).isCtxValid(ctx), "invalid ctx");
    return ISuperfluid(msg.sender).decodeCtx(ctx);
}
```

## External Calls

- **ISuperfluidPool::superToken()**
- **ISuperfluidPool::admin()**
- **ISuperfluidPool::updateMemberUnits(address,uint128)**
- **ISuperfluidToken::getHost()**
- **ISuperfluid::isCtxValid(bytes)**
- **ISuperfluid::decodeCtx(bytes)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.updateMemberUnits(contract ISuperfluidPool,address,uint128,bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: AgreementLibrary.authorizeTokenAccess(contract ISuperfluidToken,bytes) (NodeID: 1)
      💬 Args: [pool.superToken(), ctx]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
