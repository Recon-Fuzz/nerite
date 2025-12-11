# Contract: SuperfluidPoolNFTLogicDeployerLibrary

## Metadata

- **Name**: SuperfluidPoolNFTLogicDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol

## Public/External Functions

### deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Signature**: `deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: external
- **Source Range**: 17138:186:181
- **Details**: [function_deployPoolAdminNFT_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md](./function_deployPoolAdminNFT_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md)

**Signature:**
```solidity
function deployPoolAdminNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolAdminNFT);
```

### deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Signature**: `deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`
- **Visibility**: external
- **Source Range**: 17330:189:181
- **Details**: [function_deployPoolMemberNFT_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md](./function_deployPoolMemberNFT_contract_ISuperfluid_contract_IGeneralDistributionAgreementV1.md)

**Signature:**
```solidity
function deployPoolMemberNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolMemberNFT);
```
