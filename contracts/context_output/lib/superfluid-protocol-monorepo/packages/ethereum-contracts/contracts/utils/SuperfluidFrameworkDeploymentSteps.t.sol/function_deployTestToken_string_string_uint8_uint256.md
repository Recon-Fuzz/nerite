# Function: deployTestToken(string,string,uint8,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol/contract_TokenDeployerLibrary.md]

## Metadata

- **Contract**: TokenDeployerLibrary
- **Signature**: `deployTestToken(string,string,uint8,uint256)`
- **Visibility**: external
- **Source Range**: 17881:293:181

## Implementation

```solidity
function deployTestToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit) external returns (TestToken) {
    return new TestToken(_underlyingName, _underlyingSymbol, _decimals, _mintLimit);
}
```

## Call Tree

```
No call tree available
```
