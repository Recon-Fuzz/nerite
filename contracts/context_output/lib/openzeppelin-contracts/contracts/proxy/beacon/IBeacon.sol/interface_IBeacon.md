# Interface: IBeacon

## Metadata

- **Name**: IBeacon
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/proxy/beacon/IBeacon.sol
- **Documentation**:  @dev This is the interface that {BeaconProxy} expects of its beacon.

## Public/External Functions

### implementation()

- **Signature**: `implementation()`
- **Visibility**: external
- **Source Range**: 389:58:82

**Signature:**
```solidity
///  @dev Must return an address that can be used as a delegate call target.
///  {BeaconProxy} will check that this address is a contract.
function implementation() external view returns (address);;
```
