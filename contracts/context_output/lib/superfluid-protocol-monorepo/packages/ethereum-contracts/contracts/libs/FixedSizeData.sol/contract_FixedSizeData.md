# Contract: FixedSizeData

## Metadata

- **Name**: FixedSizeData
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol
- **Documentation**:  @title Utilities for fixed size data in storage
   @author Superfluid
   When using solidity dynamic array, first word is used to store the length
   of the array. For use cases that the length doesn't change, it is better
   to use a fixed size data premitive.
   To use this library:
   - The pointer to the storage is `slot`, the user could use `keccak256(abi.encode(...))`
     scheme to create collision-free slot ID for locating the data.
   - To load data, or erase data and get all gas refund, data length is always required.
