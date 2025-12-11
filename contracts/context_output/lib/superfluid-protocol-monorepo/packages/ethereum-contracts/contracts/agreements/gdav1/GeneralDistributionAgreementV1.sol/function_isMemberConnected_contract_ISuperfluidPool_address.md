# Function: isMemberConnected(contract ISuperfluidPool,address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `isMemberConnected(contract ISuperfluidPool,address)`
- **Visibility**: external
- **Source Range**: 16325:187:123

## Implementation

```solidity
function isMemberConnected(ISuperfluidPool pool, address member) override external view returns (bool) {
    return _isMemberConnected(pool.superToken(), address(pool), member);
}
```

## Related Implementations

### _isMemberConnected(contract ISuperfluidToken,address,address)

- **Kind**: internal
- **Source**: 16097:222:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isMemberConnected(contract ISuperfluidToken,address,address)`

```solidity
function _isMemberConnected(ISuperfluidToken token, address pool, address member) internal view returns (bool) {
    (bool exist, ) = _getPoolMemberData(token, member, ISuperfluidPool(pool));
    return exist;
}
```

### _getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 43023:373:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool)`

```solidity
function _getPoolMemberData(ISuperfluidToken token, address poolMember, ISuperfluidPool pool) internal view returns (bool exist, PoolMemberData memory poolMemberData) {
    (exist, poolMemberData) = _decodePoolMemberData(uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0]));
}
```

### _decodePoolMemberData(uint256)

- **Kind**: internal
- **Source**: 42663:354:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_decodePoolMemberData(uint256)`

```solidity
function _decodePoolMemberData(uint256 data) internal pure returns (bool exist, PoolMemberData memory poolMemberData) {
    exist = data > 0;
    if (exist) {
        poolMemberData.pool = address(uint160(data & uint256(type(uint160).max)));
        poolMemberData.poolID = uint32(data >> 160);
    }
}
```

### _getPoolMemberHash(address,contract ISuperfluidPool)

- **Kind**: internal
- **Source**: 30596:203:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolMemberHash(address,contract ISuperfluidPool)`

```solidity
function _getPoolMemberHash(address poolMember, ISuperfluidPool pool) internal view returns (bytes32) {
    return keccak256(abi.encode(block.chainid, "poolMember", poolMember, address(pool)));
}
```

## External Calls

- **ISuperfluidPool::superToken()**
- **ISuperfluidToken::getAgreementData(address,bytes32,uint256)**

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.isMemberConnected(contract ISuperfluidPool,address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isMemberConnected(contract ISuperfluidToken,address,address) (NodeID: 1)
      💬 Args: [pool.superToken(), address(pool), member]
      👁️  Def: internal
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberData(contract ISuperfluidToken,address,contract ISuperfluidPool) (NodeID: 2)
        💬 Args: [token, member, ISuperfluidPool(pool)]
        👁️  Def: internal
      └─ [3] ⚙️ FUNCTION: GeneralDistributionAgreementV1._decodePoolMemberData(uint256) (NodeID: 3)
          💬 Args: [uint256(token.getAgreementData(address(this), _getPoolMemberHash(poolMember, pool), 1)[0])]
          👁️  Def: internal
        └─ [4] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolMemberHash(address,contract ISuperfluidPool) (NodeID: 4)
            💬 Args: [poolMember, pool]
            👁️  Def: internal
```
