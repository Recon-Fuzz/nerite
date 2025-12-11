# Contract: TokenDeployerLibrary

## Metadata

- **Name**: TokenDeployerLibrary
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol

## Public/External Functions

### deployTestToken(string,string,uint8,uint256)

- **Signature**: `deployTestToken(string,string,uint8,uint256)`
- **Visibility**: external
- **Source Range**: 17881:293:181
- **Details**: [function_deployTestToken_string_string_uint8_uint256.md](./function_deployTestToken_string_string_uint8_uint256.md)

**Signature:**
```solidity
function deployTestToken(string calldata _underlyingName, string calldata _underlyingSymbol, uint8 _decimals, uint256 _mintLimit) external returns (TestToken);
```

### deploySETHProxy()

- **Signature**: `deploySETHProxy()`
- **Visibility**: external
- **Source Range**: 18180:95:181
- **Details**: [function_deploySETHProxy.md](./function_deploySETHProxy.md)

**Signature:**
```solidity
function deploySETHProxy() external returns (SETHProxy);
```

### deployPureSuperToken()

- **Signature**: `deployPureSuperToken()`
- **Visibility**: external
- **Source Range**: 18281:110:181
- **Details**: [function_deployPureSuperToken.md](./function_deployPureSuperToken.md)

**Signature:**
```solidity
function deployPureSuperToken() external returns (PureSuperToken);
```
