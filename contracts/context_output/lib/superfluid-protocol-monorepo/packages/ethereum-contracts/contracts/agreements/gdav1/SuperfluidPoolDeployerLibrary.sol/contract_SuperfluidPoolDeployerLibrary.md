# Contract: SuperfluidPoolDeployerLibrary

## Metadata

- **Name**: SuperfluidPoolDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPoolDeployerLibrary.sol

## Public/External Functions

### deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)

- **Signature**: `deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)`
- **Visibility**: external
- **Source Range**: 449:799:128
- **Details**: [function_deploy_address_address_contract_ISuperfluidToken_struct_PoolConfig_struct_PoolERC20Metadata.md](./function_deploy_address_address_contract_ISuperfluidToken_struct_PoolConfig_struct_PoolERC20Metadata.md)

**Signature:**
```solidity
function deploy(address beacon, address admin, ISuperfluidToken token, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) external returns (SuperfluidPool pool);
```
