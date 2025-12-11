# Contract: BatchLiquidator

## Metadata

- **Name**: BatchLiquidator
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol
- **Documentation**:  @title Batch liquidator contract
   @author Superfluid
   @dev This contract allows to delete multiple flows in a single transaction.
   @notice Reduces calldata by having host and cfa hardcoded, this can make a significant difference in tx fees on L2s

## State Variables

### host

```solidity
address public immutable host
```

### cfa

```solidity
address public immutable cfa
```

### gda

```solidity
address public immutable gda
```

## Structs

### FlowLiquidationData

```solidity
struct FlowLiquidationData {
    FlowType agreementOperation;
    address sender;
    address receiver;
}
```

## Enums

### FlowType

```solidity
enum FlowType {
    ConstantFlowAgreement,
    GeneralDistributionAgreement
}
```

## Public/External Functions

### constructor(address)

- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 941:403:172
- **Details**: [function_constructor_address.md](./function_constructor_address.md)

**Signature:**
```solidity
constructor(address host_);
```

### deleteFlows(address,struct BatchLiquidator.FlowLiquidationData[])

- **Signature**: `deleteFlows(address,struct BatchLiquidator.FlowLiquidationData[])`
- **Visibility**: external
- **Source Range**: 1523:930:172
- **Details**: [function_deleteFlows_address_struct_BatchLiquidator_FlowLiquidationData[].md](./function_deleteFlows_address_struct_BatchLiquidator_FlowLiquidationData[].md)

**Signature:**
```solidity
///  @dev Delete flows in batch
///  @param superToken - The super token the flows belong to.
///  @param data - The array of flow data to be deleted.
function deleteFlows(address superToken, FlowLiquidationData[] memory data) external;
```

### deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)

- **Signature**: `deleteFlow(address,struct BatchLiquidator.FlowLiquidationData)`
- **Visibility**: external
- **Source Range**: 2622:925:172
- **Details**: [function_deleteFlow_address_struct_BatchLiquidator_FlowLiquidationData.md](./function_deleteFlow_address_struct_BatchLiquidator_FlowLiquidationData.md)

**Signature:**
```solidity
///  @dev Delete a single flow
///  @param superToken - The super token the flow belongs to.
///  @param data - The flow data to be deleted.
function deleteFlow(address superToken, FlowLiquidationData memory data) external;
```
