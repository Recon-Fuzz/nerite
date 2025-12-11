# Function: createPoolWithCustomERC20Metadata(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]

## Metadata

- **Contract**: GeneralDistributionAgreementV1
- **Signature**: `createPoolWithCustomERC20Metadata(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)`
- **Visibility**: external
- **Source Range**: 12711:315:123

## Implementation

```solidity
/// @inheritdoc IGeneralDistributionAgreementV1
function createPoolWithCustomERC20Metadata(ISuperfluidToken token, address admin, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) override external returns (ISuperfluidPool pool) {
    return _createPool(token, admin, config, poolERC20Metadata);
}
```

## Related Implementations

### _createPool(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)

- **Kind**: internal
- **Source**: 10989:1242:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_createPool(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata)`

```solidity
function _createPool(ISuperfluidToken token, address admin, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) internal returns (ISuperfluidPool pool) {
    if (admin == address(0)) revert GDA_NO_ZERO_ADDRESS_ADMIN();
    if (_isPool(token, admin)) revert GDA_ADMIN_CANNOT_BE_POOL();
    pool = ISuperfluidPool(address(SuperfluidPoolDeployerLibrary.deploy(address(superfluidPoolBeacon), admin, token, config, poolERC20Metadata)));
    bytes32[] memory data = new bytes32[](1);
    data[0] = bytes32(uint256(1));
    token.updateAgreementStateSlot(address(pool), _UNIVERSAL_INDEX_STATE_SLOT_ID, data);
    IPoolAdminNFT poolAdminNFT = IPoolAdminNFT(_getPoolAdminNFTAddress(token));
    if (address(poolAdminNFT) != address(0)) {
        poolAdminNFT.mint(address(pool));
    }
    emit PoolCreated(token, admin, pool);
}
```

### _isPool(contract ISuperfluidToken,address)

- **Kind**: internal
- **Source**: 39985:442:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_isPool(contract ISuperfluidToken,address)`

```solidity
function _isPool(ISuperfluidToken token, address account) internal view returns (bool exists) {
    exists = (((uint256(token.getAgreementStateSlot(address(this), account, _UNIVERSAL_INDEX_STATE_SLOT_ID, 1)[0]) << 224) >> 224) & 1) == 1;
}
```

### deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)

- **Kind**: internal
- **Source**: 449:799:128
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/SuperfluidPoolDeployerLibrary.sol:SuperfluidPoolDeployerLibrary:deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata)`

```solidity
function deploy(address beacon, address admin, ISuperfluidToken token, PoolConfig memory config, PoolERC20Metadata memory poolERC20Metadata) external returns (SuperfluidPool pool) {
    bytes memory initializeCallData = abi.encodeWithSelector(SuperfluidPool.initialize.selector, admin, token, config.transferabilityForUnitsOwner, config.distributionFromAnyAddress, poolERC20Metadata.name, poolERC20Metadata.symbol, poolERC20Metadata.decimals);
    BeaconProxy superfluidPoolBeaconProxy = new BeaconProxy(beacon, initializeCallData);
    pool = SuperfluidPool(address(superfluidPoolBeaconProxy));
}
```

### _getPoolAdminNFTAddress(contract ISuperfluidToken)

- **Kind**: internal
- **Source**: 24477:778:123
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol:GeneralDistributionAgreementV1:_getPoolAdminNFTAddress(contract ISuperfluidToken)`

```solidity
function _getPoolAdminNFTAddress(ISuperfluidToken token) internal view returns (address poolAdminNFTAddress) {
    (bool success, bytes memory data) = address(token).staticcall(abi.encodeWithSelector(ISuperToken.POOL_ADMIN_NFT.selector));
    if (success) {
        poolAdminNFTAddress = abi.decode(data, (address));
    }
}
```

## External Calls

- **ISuperfluidToken::updateAgreementStateSlot(address,uint256,bytes32[])**
- **IPoolAdminNFT::mint(address)**
- **ISuperfluidToken::getAgreementStateSlot(address,address,uint256,uint256)**
- **address::staticcall(bytes memory)**

## State Variable Reads

- **superfluidPoolBeacon** (`contract SuperfluidUpgradeableBeacon`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/upgradability/SuperfluidUpgradeableBeacon.sol/contract_SuperfluidUpgradeableBeacon.md]
- **_UNIVERSAL_INDEX_STATE_SLOT_ID** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: GeneralDistributionAgreementV1.createPoolWithCustomERC20Metadata(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  └─ [1] ⚙️ FUNCTION: GeneralDistributionAgreementV1._createPool(contract ISuperfluidToken,address,struct PoolConfig,struct PoolERC20Metadata) (NodeID: 1)
      💬 Args: [token, admin, config, poolERC20Metadata]
      👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._isPool(contract ISuperfluidToken,address) (NodeID: 2)
    │   💬 Args: [token, admin]
    │   👁️  Def: internal
    ├─ [2] ⚙️ FUNCTION: SuperfluidPoolDeployerLibrary.deploy(address,address,contract ISuperfluidToken,struct PoolConfig,struct PoolERC20Metadata) (NodeID: 3)
    │   💬 Args: [address(superfluidPoolBeacon), admin, token, config, poolERC20Metadata]
    │   👁️  Def: external
    └─ [2] ⚙️ FUNCTION: GeneralDistributionAgreementV1._getPoolAdminNFTAddress(contract ISuperfluidToken) (NodeID: 4)
        💬 Args: [token]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@inheritdoc IGeneralDistributionAgreementV1
