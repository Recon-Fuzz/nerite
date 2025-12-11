# Contract: SuperTokenV1Library

## Metadata

- **Name**: SuperTokenV1Library
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/apps/SuperTokenV1Library.sol
- **Documentation**:  @title Library for Token Centric Interface
   @author Superfluid
   @dev Set `using for ISuperToken` in including file, and call any of these functions on an instance
   of ISuperToken.
   The architecture of the Superfluid framework and its initial API were heavily influenced by the
   gas economics on Ethereum at the time, leading to compromises in terms of API ergonomics.
   This library mitigates that by providing a more convenient Solidity API for SuperTokens.
   While most methods are just wrappers around equivalent methods in a Superfluid agreement,
   some implement higher level abstractions.
   Note using the library in foundry tests can lead to counter-intuitive behaviour.
   E.g. "prank" won't set the expected msg.sender for calls done using the library.
   Also, reverts caused by the library itself won't be recognized by foundry, because
   it expects them to happen in the context of an external call.
   This is not specific to this library, but a general limitation of foundry when using libraries in tests.

## State Variables

### _HOST_SLOT

```solidity
/// PRIVATE HELPERS ************************************* 
bytes32 private constant _HOST_SLOT = 0x65599bf746e17a00ea62e3610586992d88101b78eec3cf380706621fb97ea837
```

### _CFA_SLOT

```solidity
bytes32 private constant _CFA_SLOT = 0xb969d79d88acd02d04ed7ee7d43b949e7daf093d363abcfbbc43dfdfd1ce969a
```

### _GDA_SLOT

```solidity
bytes32 private constant _GDA_SLOT = 0xc36f6c05164a669ecb6da53e218d77ae44d51cfc99f91e5a125a18de0949bee4
```
