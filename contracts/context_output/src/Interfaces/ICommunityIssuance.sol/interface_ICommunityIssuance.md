# Interface: ICommunityIssuance

## Metadata

- **Name**: ICommunityIssuance
- **Type**: Interface
- **Path**: src/Interfaces/ICommunityIssuance.sol

## Public/External Functions

### setAddresses(address,address)

- **Signature**: `setAddresses(address,address)`
- **Visibility**: external
- **Source Range**: 93:89:227

**Signature:**
```solidity
function setAddresses(address _lqtyTokenAddress, address _stabilityPoolAddress) external;;
```

### issueLQTY()

- **Signature**: `issueLQTY()`
- **Visibility**: external
- **Source Range**: 188:48:227

**Signature:**
```solidity
function issueLQTY() external returns (uint256);;
```

### sendLQTY(address,uint256)

- **Signature**: `sendLQTY(address,uint256)`
- **Visibility**: external
- **Source Range**: 242:66:227

**Signature:**
```solidity
function sendLQTY(address _account, uint256 _LQTYamount) external;;
```
