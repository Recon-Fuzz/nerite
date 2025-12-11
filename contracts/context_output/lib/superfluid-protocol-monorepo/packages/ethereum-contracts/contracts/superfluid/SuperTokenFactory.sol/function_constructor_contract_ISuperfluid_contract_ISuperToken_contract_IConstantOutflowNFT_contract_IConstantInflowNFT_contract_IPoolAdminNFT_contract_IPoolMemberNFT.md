# Function: constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]

## Metadata

- **Contract**: SuperTokenFactory
- **Signature**: `constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)`
- **Visibility**: public
- **Source Range**: 15074:547:162

## Implementation

```solidity
constructor(ISuperfluid host, ISuperToken superTokenLogic, IConstantOutflowNFT constantOutflowNFTLogic, IConstantInflowNFT constantInflowNFTLogic, IPoolAdminNFT poolAdminNFTLogic, IPoolMemberNFT poolMemberNFTLogic) SuperTokenFactoryBase(host,superTokenLogic,constantOutflowNFTLogic,constantInflowNFTLogic,poolAdminNFTLogic,poolMemberNFTLogic) {}
```

## Related Implementations

### (contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)

- **Kind**: internal
- **Source**: 3199:1314:162
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol:SuperTokenFactoryBase:constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT)`

```solidity
constructor(ISuperfluid host, ISuperToken superTokenLogic, IConstantOutflowNFT constantOutflowNFTLogic, IConstantInflowNFT constantInflowNFTLogic, IPoolAdminNFT poolAdminNFTLogic, IPoolMemberNFT poolMemberNFTLogic) {
    _host = host;
    _SUPER_TOKEN_LOGIC = superTokenLogic;
    try UUPSProxiable(address(_SUPER_TOKEN_LOGIC)).castrate() {} catch {}
    CONSTANT_OUTFLOW_NFT_LOGIC = constantOutflowNFTLogic;
    CONSTANT_INFLOW_NFT_LOGIC = constantInflowNFTLogic;
    POOL_ADMIN_NFT_LOGIC = poolAdminNFTLogic;
    POOL_MEMBER_NFT_LOGIC = poolMemberNFTLogic;
    emit SuperTokenLogicCreated(_SUPER_TOKEN_LOGIC);
}
```

## External Calls

- **UUPSProxiable::castrate()**

## State Variable Reads

- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]

## State Variable Writes

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_SUPER_TOKEN_LOGIC** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **CONSTANT_OUTFLOW_NFT_LOGIC** (`contract IConstantOutflowNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantOutflowNFT.md]
- **CONSTANT_INFLOW_NFT_LOGIC** (`contract IConstantInflowNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/interface_IConstantInflowNFT.md]
- **POOL_ADMIN_NFT_LOGIC** (`contract IPoolAdminNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolAdminNFT.sol/interface_IPoolAdminNFT.md]
- **POOL_MEMBER_NFT_LOGIC** (`contract IPoolMemberNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/gdav1/IPoolMemberNFT.sol/interface_IPoolMemberNFT.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: SuperTokenFactory.constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: SuperTokenFactory
  └─ [1] 🏗️ CONSTRUCTOR: SuperTokenFactoryBase.constructor(contract ISuperfluid,contract ISuperToken,contract IConstantOutflowNFT,contract IConstantInflowNFT,contract IPoolAdminNFT,contract IPoolMemberNFT) (NodeID: 1)
      💬 Args: [host, superTokenLogic, constantOutflowNFTLogic, constantInflowNFTLogic, poolAdminNFTLogic, poolMemberNFTLogic]
      🏗️  Contract: SuperTokenFactoryBase
```
