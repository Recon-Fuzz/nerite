# Function: constructor(contract ISuperfluid,uint256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## Metadata

- **Contract**: TOGA
- **Signature**: `constructor(contract ISuperfluid,uint256)`
- **Visibility**: public
- **Source Range**: 6560:691:183

## Implementation

```solidity
constructor(ISuperfluid host_, uint256 minBondDuration_) {
    _host = ISuperfluid(host_);
    minBondDuration = minBondDuration_;
    _cfa = IConstantFlowAgreementV1(address(host_.getAgreementClass(keccak256("org.superfluid-finance.agreements.ConstantFlowAgreement.v1"))));
    bytes32 erc777TokensRecipientHash = keccak256("ERC777TokensRecipient");
    _ERC1820_REG.setInterfaceImplementer(address(this), erc777TokensRecipientHash, address(this));
    _ERC1820_REG.setInterfaceImplementer(address(this), keccak256("TOGAv1"), address(this));
    _ERC1820_REG.setInterfaceImplementer(address(this), keccak256("TOGAv2"), address(this));
}
```

## External Calls

- **ISuperfluid::getAgreementClass(bytes32)**
- **IERC1820Registry::setInterfaceImplementer(address,bytes32,address)**

## State Variable Reads

- **_ERC1820_REG** (`contract IERC1820Registry`) [lib/openzeppelin-contracts/contracts/utils/introspection/IERC1820Registry.sol/interface_IERC1820Registry.md]

## State Variable Writes

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **minBondDuration** (`uint256`)
- **_cfa** (`contract IConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/agreements/IConstantFlowAgreementV1.sol/contract_IConstantFlowAgreementV1.md]

## Call Tree

```
┌─ [0] 🏗️ CONSTRUCTOR: TOGA.constructor(contract ISuperfluid,uint256) (NodeID: 0)
    💬 Args: [no args]
    🏗️  Contract: TOGA
```
