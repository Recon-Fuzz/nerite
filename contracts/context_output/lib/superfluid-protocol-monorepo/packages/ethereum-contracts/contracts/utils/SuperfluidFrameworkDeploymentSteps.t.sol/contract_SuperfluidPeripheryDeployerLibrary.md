# Contract: SuperfluidPeripheryDeployerLibrary

## Metadata

- **Name**: SuperfluidPeripheryDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol

## Public/External Functions

### deployTestResolver(address)

- **Signature**: `deployTestResolver(address)`
- **Visibility**: external
- **Source Range**: 18955:142:181
- **Details**: [function_deployTestResolver_address.md](./function_deployTestResolver_address.md)

**Signature:**
```solidity
function deployTestResolver(address additionalAdmin) external returns (TestResolver);
```

### deploySuperfluidLoader(contract IResolver)

- **Signature**: `deploySuperfluidLoader(contract IResolver)`
- **Visibility**: external
- **Source Range**: 19103:142:181
- **Details**: [function_deploySuperfluidLoader_contract_IResolver.md](./function_deploySuperfluidLoader_contract_IResolver.md)

**Signature:**
```solidity
function deploySuperfluidLoader(IResolver resolver) external returns (SuperfluidLoader);
```

### deployBatchLiquidator(contract ISuperfluid)

- **Signature**: `deployBatchLiquidator(contract ISuperfluid)`
- **Visibility**: external
- **Source Range**: 19251:142:181
- **Details**: [function_deployBatchLiquidator_contract_ISuperfluid.md](./function_deployBatchLiquidator_contract_ISuperfluid.md)

**Signature:**
```solidity
function deployBatchLiquidator(ISuperfluid host) external returns (BatchLiquidator);
```

### deployTOGA(contract ISuperfluid,uint256)

- **Signature**: `deployTOGA(contract ISuperfluid,uint256)`
- **Visibility**: external
- **Source Range**: 19399:142:181
- **Details**: [function_deployTOGA_contract_ISuperfluid_uint256.md](./function_deployTOGA_contract_ISuperfluid_uint256.md)

**Signature:**
```solidity
function deployTOGA(ISuperfluid host, uint256 minBondDuration) external returns (TOGA);
```
