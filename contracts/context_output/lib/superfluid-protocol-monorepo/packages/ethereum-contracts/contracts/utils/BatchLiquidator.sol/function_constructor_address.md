# Function: constructor(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]

## Metadata

- **Contract**: BatchLiquidator
- **Signature**: `constructor(address)`
- **Visibility**: public
- **Source Range**: 941:403:172

## Implementation

```solidity
constructor(address host_) {
    host = host_;
    cfa = address(ISuperfluid(host).getAgreementClass(keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1")));
    gda = address(ISuperfluid(host).getAgreementClass(keccak256("org.superfluid-finance.agreements.GeneralDistributionAgreement.v1")));
}
```

## External Calls

- **ISuperfluid::getAgreementClass(bytes32)**

## State Variable Reads

- **host** (`address`)

## State Variable Writes

- **host** (`address`)
- **cfa** (`address`)
- **gda** (`address`)

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: BatchLiquidator.constructor(address) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: BatchLiquidator
```
