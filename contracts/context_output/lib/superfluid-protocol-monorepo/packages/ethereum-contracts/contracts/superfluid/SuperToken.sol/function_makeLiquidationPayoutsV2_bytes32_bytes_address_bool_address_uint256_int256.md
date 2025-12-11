# Function: makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256)`
- **Visibility**: external
- **Source Range**: 10475:2510:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.makeLiquidationPayoutsV2 implementation
function makeLiquidationPayoutsV2(bytes32 id, bytes memory liquidationTypeData, address liquidatorAccount, bool useDefaultRewardAccount, address targetAccount, uint256 rewardAmount, int256 targetAccountBalanceDelta) virtual override external onlyAgreement() {
    address rewardAccount = _getRewardAccount();
    if (rewardAccount == address(0)) {
        rewardAccount = liquidatorAccount;
    }
    address rewardAmountReceiver = useDefaultRewardAccount ? rewardAccount : liquidatorAccount;
    if (targetAccountBalanceDelta <= 0) {
        assert(rewardAmount.toInt256() == (-targetAccountBalanceDelta));
        _sharedSettledBalances[rewardAmountReceiver] += rewardAmount.toInt256();
        _sharedSettledBalances[targetAccount] += targetAccountBalanceDelta;
        emit IERC20.Transfer(targetAccount, rewardAmountReceiver, rewardAmount);
    } else {
        assert(!useDefaultRewardAccount);
        _sharedSettledBalances[rewardAccount] -= (rewardAmount.toInt256() + targetAccountBalanceDelta);
        _sharedSettledBalances[liquidatorAccount] += rewardAmount.toInt256();
        _sharedSettledBalances[targetAccount] += targetAccountBalanceDelta;
        emit IERC20.Transfer(rewardAccount, liquidatorAccount, rewardAmount);
        emit IERC20.Transfer(rewardAccount, targetAccount, uint256(targetAccountBalanceDelta));
    }
    emit AgreementLiquidatedV2(msg.sender, id, liquidatorAccount, targetAccount, rewardAmountReceiver, rewardAmount, targetAccountBalanceDelta, liquidationTypeData);
}
```

## Related Implementations

### _getRewardAccount()

- **Kind**: internal
- **Source**: 6838:230:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:_getRewardAccount()`

```solidity
function _getRewardAccount() internal view returns (address rewardAccount) {
    ISuperfluidGovernance gov = _host.getGovernance();
    rewardAccount = gov.getConfigAsAddress(_host, this, _REWARD_ADDRESS_CONFIG_KEY);
}
```

### toInt256(uint256)

- **Kind**: internal
- **Source**: 34781:297:115
- **Link**: `lib/openzeppelin-contracts/contracts/utils/math/SafeCast.sol:SafeCast:toInt256(uint256)`

```solidity
///  @dev Converts an unsigned uint256 into a signed int256.
///  Requirements:
///  - input must be less than or equal to maxInt256.
///  _Available since v3.0._
function toInt256(uint256 value) internal pure returns (int256) {
    require(value <= uint256(type(int256).max), "SafeCast: value doesn't fit in an int256");
    return int256(value);
}
```

### onlyAgreement()

- **Kind**: modifier
- **Source**: 13167:180:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:onlyAgreement()`

```solidity
modifier onlyAgreement() {
    if (!_host.isAgreementClassListed(ISuperAgreement(msg.sender))) {
        revert SF_TOKEN_ONLY_LISTED_AGREEMENT();
    }
    _;
}
```

## External Calls

- **ISuperfluid::getGovernance()**
- **ISuperfluidGovernance::getConfigAsAddress(contract ISuperfluid,contract ISuperfluidToken,bytes32)**
- **ISuperfluid::isAgreementClassListed(contract ISuperAgreement)**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_REWARD_ADDRESS_CONFIG_KEY** (`bytes32`)

## State Variable Writes

- **_sharedSettledBalances** (`mapping(address => int256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.makeLiquidationPayoutsV2(bytes32,bytes,address,bool,address,uint256,int256) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidToken._getRewardAccount() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 2)
  │   💬 Args: [rewardAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 3)
  │   💬 Args: [rewardAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 4)
  │   💬 Args: [rewardAmount]
  │   👁️  Def: internal
  ├─ [1] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 5)
  │   💬 Args: [rewardAmount]
  │   👁️  Def: internal
  └─ [1] 🔒 MODIFIER: SuperfluidToken.onlyAgreement() (NodeID: 6)
      💬 Args: [no args]
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.makeLiquidationPayoutsV2 implementation

### Interface Documentation

 @dev Make liquidation payouts (v2)
 @param id Agreement ID
 @param liquidationTypeData Data regarding the version of the liquidation schema and the type
 @param liquidatorAccount Address of the executor of the liquidation
 @param useDefaultRewardAccount Whether or not the default reward account receives the rewardAmount
 @param targetAccount Account to be liquidated
 @param rewardAmount The amount the rewarded account will receive
 @param targetAccountBalanceDelta The delta amount the target account balance should change by
 @custom:note 
 - If a bailout is required (bailoutAmount > 0)
   - the actual reward (single deposit) goes to the executor,
   - while the reward account becomes the bailout account
   - total bailout include: bailout amount + reward amount
   - the targetAccount will be bailed out
 - If a bailout is not required
   - the targetAccount will pay the rewardAmount
   - the liquidator (reward account in PIC period) will receive the rewardAmount
 @custom:modifiers 
  - onlyAgreement
