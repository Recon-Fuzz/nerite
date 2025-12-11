# Function: deploy(contract ISuperfluid)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_GDAv1ForwarderDeployerLibrary.md]

## Metadata

- **Contract**: GDAv1ForwarderDeployerLibrary
- **Signature**: `deploy(contract ISuperfluid)`
- **Visibility**: external
- **Source Range**: 16554:118:181

## Implementation

```solidity
function deploy(ISuperfluid _host) external returns (GDAv1Forwarder) {
    return new GDAv1Forwarder(_host);
}
```

## Call Tree

```
No call tree available
```
