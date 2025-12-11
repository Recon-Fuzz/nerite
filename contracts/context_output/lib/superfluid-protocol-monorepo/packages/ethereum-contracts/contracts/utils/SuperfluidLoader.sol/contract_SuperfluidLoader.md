# Contract: SuperfluidLoader

## Metadata

- **Name**: SuperfluidLoader
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol
- **Documentation**:  @title Superfluid loader contract
   @author Superfluid
   @dev A on-chain utility contract for loading framework objects in one view function.
   NOTE:
   Q: Why don't we just use https://www.npmjs.com/package/ethereum-multicall?
   A: Well, no strong reason other than also allowing on-chain one view function loading.

## State Variables

### _resolver

```solidity
IResolver private immutable _resolver
```

**IResolver**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IResolver.sol/interface_IResolver.md]

## Structs

### Framework

```solidity
struct Framework {
    ISuperfluid superfluid;
    ISuperTokenFactory superTokenFactory;
    ISuperAgreement agreementCFAv1;
    ISuperAgreement agreementIDAv1;
    ISuperAgreement agreementGDAv1;
}
```

## Public/External Functions

### constructor(contract IResolver)

- **Signature**: `constructor(contract IResolver)`
- **Visibility**: public
- **Source Range**: 884:69:182
- **Details**: [function_constructor_contract_IResolver.md](./function_constructor_contract_IResolver.md)

**Signature:**
```solidity
constructor(IResolver resolver);
```

### loadFramework(string)

- **Signature**: `loadFramework(string)`
- **Visibility**: external
- **Source Range**: 1082:878:182
- **Details**: [function_loadFramework_string.md](./function_loadFramework_string.md)

**Signature:**
```solidity
///  @dev Load framework objects
///  @param releaseVersion Protocol release version of the deployment
function loadFramework(string calldata releaseVersion) external view returns (Framework memory result);
```
