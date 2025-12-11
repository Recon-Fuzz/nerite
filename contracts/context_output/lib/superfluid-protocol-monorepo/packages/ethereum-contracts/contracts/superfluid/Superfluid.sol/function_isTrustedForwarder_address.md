# Function: isTrustedForwarder(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `isTrustedForwarder(address)`
- **Visibility**: public
- **Source Range**: 35887:305:163

## Implementation

```solidity
/// @dev BaseRelayRecipient.isTrustedForwarder implementation
function isTrustedForwarder(address forwarder) override public view returns (bool) {
    return _gov.getConfigAsUint256(this, ISuperfluidToken(address(0)), SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(forwarder)) != 0;
}
```

## Related Implementations

### getTrustedForwarderConfigKey(address)

- **Kind**: internal
- **Source**: 11067:224:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:SuperfluidGovernanceConfigs:getTrustedForwarderConfigKey(address)`

```solidity
function getTrustedForwarderConfigKey(address forwarder) internal pure returns (bytes32) {
    return keccak256(abi.encode("org.superfluid-finance.superfluid.trustedForwarder", forwarder));
}
```

## External Calls

- **ISuperfluidGovernance::getConfigAsUint256(contract ISuperfluid,contract ISuperfluidToken,bytes32)**

## State Variable Reads

- **_gov** (`contract ISuperfluidGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluidGovernance.sol/interface_ISuperfluidGovernance.md]

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.isTrustedForwarder(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperfluidGovernanceConfigs.getTrustedForwarderConfigKey(address) (NodeID: 1)
      💬 Args: [forwarder]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev BaseRelayRecipient.isTrustedForwarder implementation

### Interface Documentation

 @notice Returns if the forwarder is trusted to forward relayed transactions to us.
 @dev the forwarder is required to verify the sender's signature, and verify
      the call is not a replay.
