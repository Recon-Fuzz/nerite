# Function: constructor(contract ISuperfluid,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `constructor(contract ISuperfluid,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: public
- **Source Range**: 3890:753:161

## Implementation

```solidity
constructor(ISuperfluid host, IConstantOutflowNFT constantOutflowNFT, IConstantInflowNFT constantInflowNFT, IPoolAdminNFT poolAdminNFT, IPoolMemberNFT poolMemberNFT) SuperfluidToken(host) {
    CONSTANT_OUTFLOW_NFT = constantOutflowNFT;
    CONSTANT_INFLOW_NFT = constantInflowNFT;
    POOL_ADMIN_NFT = poolAdminNFT;
    POOL_MEMBER_NFT = poolMemberNFT;
    emit PoolAdminNFTCreated(poolAdminNFT);
    emit PoolMemberNFTCreated(poolMemberNFT);
}
```

## Related Implementations

### (contract ISuperfluid)

- **Kind**: internal
- **Source**: 1579:73:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:constructor(contract ISuperfluid)`

```solidity
constructor(ISuperfluid host) {
    _host = host;
}
```

## State Variable Writes

- **CONSTANT_OUTFLOW_NFT** (`contract IConstantOutflowNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantOutflowNFT.md]
- **CONSTANT_INFLOW_NFT** (`contract IConstantInflowNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantInflowNFT.md]
- **POOL_ADMIN_NFT** (`contract IPoolAdminNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]
- **POOL_MEMBER_NFT** (`contract IPoolMemberNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolMemberNFT.sol/interface_IPoolMemberNFT.md]
- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperToken.constructor(contract ISuperfluid,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperToken
  └─ [1] 🏗️ CONSTRUCTOR: SuperfluidToken.constructor(contract ISuperfluid) (NodeID: 1)
      💬 Args: [host]
      🏗️  Contract: SuperfluidToken
```
