# Interface: ISuperAgreement

## Metadata

- **Name**: ISuperAgreement
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperAgreement.sol
- **Documentation**:  @title Super agreement interface
   @author Superfluid

## Public/External Functions

### agreementType()

- **Signature**: `agreementType()`
- **Visibility**: external
- **Source Range**: 283:57:41

**Signature:**
```solidity
///  @dev Get the type of the agreement class
function agreementType() external view returns (bytes32);;
```

### realtimeBalanceOf(contract ISuperfluidToken,address,uint256)

- **Signature**: `realtimeBalanceOf(contract ISuperfluidToken,address,uint256)`
- **Visibility**: external
- **Source Range**: 776:266:41

**Signature:**
```solidity
///  @dev Calculate the real-time balance for the account of this agreement class
///  @param account Account the state belongs to
///  @param time Time used for the calculation
///  @return dynamicBalance Dynamic balance portion of real-time balance of this agreement
///  @return deposit Account deposit amount of this agreement
///  @return owedDeposit Account owed deposit amount of this agreement
function realtimeBalanceOf(ISuperfluidToken token, address account, uint256 time) external view returns (int256 dynamicBalance, uint256 deposit, uint256 owedDeposit);;
```
