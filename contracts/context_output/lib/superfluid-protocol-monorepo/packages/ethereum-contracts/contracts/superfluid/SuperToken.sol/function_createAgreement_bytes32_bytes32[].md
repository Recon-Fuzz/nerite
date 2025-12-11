# Function: createAgreement(bytes32,bytes32[])

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `createAgreement(bytes32,bytes32[])`
- **Visibility**: external
- **Source Range**: 7337:481:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.createAgreement implementation
function createAgreement(bytes32 id, bytes32[] calldata data) virtual override external {
    address agreementClass = msg.sender;
    bytes32 slot = keccak256(abi.encode("AgreementData", agreementClass, id));
    if (FixedSizeData.hasData(slot, data.length)) {
        revert SF_TOKEN_AGREEMENT_ALREADY_EXISTS();
    }
    FixedSizeData.storeData(slot, data);
    emit AgreementCreated(agreementClass, id, data);
}
```

## Related Implementations

### hasData(bytes32,uint256)

- **Kind**: internal
- **Source**: 921:282:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:hasData(bytes32,uint256)`

```solidity
function hasData(bytes32 slot, uint dataLength) internal view returns (bool) {
    for (uint j = 0; j < dataLength; ++j) {
        bytes32 d;
        assembly {
            d := sload(add(slot, j))
        }
        if (uint256(d) > 0) return true;
    }
    return false;
}
```

### storeData(bytes32,bytes32[])

- **Kind**: internal
- **Source**: 702:213:157
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/libs/FixedSizeData.sol:FixedSizeData:storeData(bytes32,bytes32[])`

```solidity
///  @dev Store data to the slot at `slot`
function storeData(bytes32 slot, bytes32[] memory data) internal {
    for (uint j = 0; j < data.length; ++j) {
        bytes32 d = data[j];
        assembly {
            sstore(add(slot, j), d)
        }
    }
}
```

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.createAgreement(bytes32,bytes32[]) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: FixedSizeData.hasData(bytes32,uint256) (NodeID: 1)
  │   💬 Args: [slot, data.length]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: FixedSizeData.storeData(bytes32,bytes32[]) (NodeID: 2)
      💬 Args: [slot, data]
      👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.createAgreement implementation

### Interface Documentation

 @dev Create a new agreement
 @param id Agreement ID
 @param data Agreement data
