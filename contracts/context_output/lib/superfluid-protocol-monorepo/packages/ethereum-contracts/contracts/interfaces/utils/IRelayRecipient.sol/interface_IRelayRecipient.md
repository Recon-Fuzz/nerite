# Interface: IRelayRecipient

## Metadata

- **Name**: IRelayRecipient
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/utils/IRelayRecipient.sol
- **Documentation**:  @title Relay recipient interface
   @author Superfluid
   @dev A contract must implement this interface in order to support relayed transactions
   @dev It is better to inherit the BaseRelayRecipient as its implementation

## Public/External Functions

### isTrustedForwarder(address)

- **Signature**: `isTrustedForwarder(address)`
- **Visibility**: external
- **Source Range**: 662:75:149

**Signature:**
```solidity
///  @notice Returns if the forwarder is trusted to forward relayed transactions to us.
///  @dev the forwarder is required to verify the sender's signature, and verify
///       the call is not a replay.
function isTrustedForwarder(address forwarder) external view returns (bool);;
```

### versionRecipient()

- **Signature**: `versionRecipient()`
- **Visibility**: external
- **Source Range**: 951:66:149

**Signature:**
```solidity
///  @dev EIP 2771 version
///  NOTE:
///  - It is not clear if it is actually from the EIP 2771....
///  - https://docs.biconomy.io/guides/enable-gasless-transactions/eip-2771
function versionRecipient() external view returns (string memory);;
```
