# Function: realtimeBalanceOfNow(address)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperToken.sol/contract_SuperToken.md]

## Metadata

- **Contract**: SuperToken
- **Signature**: `realtimeBalanceOfNow(address)`
- **Visibility**: public
- **Source Range**: 3526:428:164
- **Inherited From**: SuperfluidToken

## Implementation

```solidity
/// @dev ISuperfluidToken.realtimeBalanceOfNow implementation
function realtimeBalanceOfNow(address account) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit, uint256 timestamp) {
    timestamp = _host.getNow();
    (availableBalance, deposit, owedDeposit) = realtimeBalanceOf(account, timestamp);
}
```

## Related Implementations

### realtimeBalanceOf(address,uint256)

- **Kind**: internal
- **Source**: 2120:1334:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:realtimeBalanceOf(address,uint256)`

```solidity
/// @dev ISuperfluidToken.realtimeBalanceOf implementation
function realtimeBalanceOf(address account, uint256 timestamp) virtual override public view returns (int256 availableBalance, uint256 deposit, uint256 owedDeposit) {
    availableBalance = _sharedSettledBalances[account];
    ISuperAgreement[] memory activeAgreements = getAccountActiveAgreements(account);
    for (uint256 i = 0; i < activeAgreements.length; ++i) {
        (int256 agreementDynamicBalance, uint256 agreementDeposit, uint256 agreementOwedDeposit) = activeAgreements[i].realtimeBalanceOf(this, account, timestamp);
        deposit = deposit + agreementDeposit;
        owedDeposit = owedDeposit + agreementOwedDeposit;
        availableBalance = (availableBalance + agreementDynamicBalance) - ((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0).toInt256();
    }
}
```

### getAccountActiveAgreements(address)

- **Kind**: internal
- **Source**: 5267:218:164
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperfluidToken.sol:SuperfluidToken:getAccountActiveAgreements(address)`

```solidity
/// @dev ISuperfluidToken.getAccountActiveAgreements implementation
function getAccountActiveAgreements(address account) virtual override public view returns (ISuperAgreement[] memory) {
    return _host.mapAgreementClasses(~_inactiveAgreementBitmap[account]);
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

## External Calls

- **ISuperfluid::getNow()**
- **ISuperAgreement::realtimeBalanceOf(contract ISuperfluidToken,address,uint256)**
- **ISuperfluid::mapAgreementClasses(uint256)**

## State Variable Reads

- **_host** (`contract ISuperfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperfluid.sol/interface_ISuperfluid.md]
- **_sharedSettledBalances** (`mapping(address => int256)`)
- **_inactiveAgreementBitmap** (`mapping(address => uint256)`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOfNow(address) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: SuperfluidToken.realtimeBalanceOf(address,uint256) (NodeID: 1)
      💬 Args: [account, timestamp]
      👁️  Def: public
    ├─ [2] ⚙️ FUNCTION: SuperfluidToken.getAccountActiveAgreements(address) (NodeID: 2)
    │   💬 Args: [account]
    │   👁️  Def: public
    └─ [2] ⚙️ FUNCTION: SafeCast.toInt256(uint256) (NodeID: 3)
        💬 Args: [((agreementDeposit > agreementOwedDeposit) ? (agreementDeposit - agreementOwedDeposit) : 0)]
        👁️  Def: internal
```

## Documentation

### Function Documentation

@dev ISuperfluidToken.realtimeBalanceOfNow implementation

### Interface Documentation

 @notice Calculate the realtime balance given the current host.getNow() value
 @dev realtimeBalanceOf with timestamp equals to block timestamp
 @param account for the query
 @return availableBalance Real-time balance
 @return deposit Account deposit
 @return owedDeposit Account owed Deposit
