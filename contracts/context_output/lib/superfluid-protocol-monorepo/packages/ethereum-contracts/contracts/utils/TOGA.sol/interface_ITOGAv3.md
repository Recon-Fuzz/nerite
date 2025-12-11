# Interface: ITOGAv3

## Metadata

- **Name**: ITOGAv3
- **Type**: Interface
- **Path**: lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol

## Implements Interfaces

- **ITOGAv1** [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/interface_ITOGAv1.md]

## Events

### NewPIC (inherited from ITOGAv1)

```solidity
///  @dev Emitted on a successful bid designating a PIC
///  @param token The Super token the new PIC bid for
///  @param pic The address of the new PIC
///  @param bond The size (amount) of the bond staked by the PIC
///  @param exitRate The flowrate at which the bond and accrued rewards will be streamed to the PIC
///  The exitRate must be greater or equal zero and respect the upper bound defined by getMaxExitRateFor()
event NewPIC(ISuperToken indexed token, address pic, uint256 bond, int96 exitRate);
```

### ExitRateChanged (inherited from ITOGAv1)

```solidity
///  @dev Emitted if a PIC changes the exit rate
///  @param token The Super token for which the exit rate was changed
///  @param exitRate The new flowrate of the given token from the contract to the PIC
event ExitRateChanged(ISuperToken indexed token, int96 exitRate);
```

### BondIncreased

```solidity
///  @dev Emitted if a PIC increases its bond
///  @param additionalBond The additional amount added to the bond
event BondIncreased(ISuperToken indexed token, uint256 additionalBond);
```

## Public/External Functions

### getCurrentPIC(contract ISuperToken) (inherited from ITOGAv1)

- **Signature**: `getCurrentPIC(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 1950:77:183

**Signature:**
```solidity
///  @dev get the address of the current PIC for the given token.
///  @param token The token for which to get the PIC
function getCurrentPIC(ISuperToken token) external view returns (address pic);;
```

### getCurrentPICInfo(contract ISuperToken) (inherited from ITOGAv1)

- **Signature**: `getCurrentPICInfo(contract ISuperToken)`
- **Visibility**: external
- **Source Range**: 2687:119:183

**Signature:**
```solidity
///  @dev get info about the state - most importantly the bond amount - of the current PIC for the given token.
///  @param token The token for which to get PIC info
///  Notes:
///  The bond changes dynamically and can both grow or shrink between 2 blocks.
///  Even the PIC itself could change anytime, this being a continuous auction.
///  @return pic Address of the current PIC. Returns the ZERO address if not set
///  @return bond The current bond amount. Can shrink or grow over time, depending on exitRate and rewards accrued
///  @return exitRate The current flowrate of given tokens from the contract to the PIC
function getCurrentPICInfo(ISuperToken token) external view returns (address pic, uint256 bond, int96 exitRate);;
```

### getDefaultExitRateFor(contract ISuperToken,uint256) (inherited from ITOGAv1)

- **Signature**: `getDefaultExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: external
- **Source Range**: 3146:108:183

**Signature:**
```solidity
///  @dev Get the exit rate set by default for the given token and bond amount
///  @param token The token for which to get info
///  @param bondAmount The bond amount for which to make the calculation
///  @return exitRate The exit rate set by default for a bid with the given bond amount for the given token
function getDefaultExitRateFor(ISuperToken token, uint256 bondAmount) external view returns (int96 exitRate);;
```

### getMaxExitRateFor(contract ISuperToken,uint256) (inherited from ITOGAv1)

- **Signature**: `getMaxExitRateFor(contract ISuperToken,uint256)`
- **Visibility**: external
- **Source Range**: 3703:104:183

**Signature:**
```solidity
///  @dev Get the max exit which can be set for the given token and bond amount
///  @param token The token for which to get info
///  @param bondAmount The bond amount for which to calculate the max exit rate
///  @return exitRate The max exit rate which can be set for the given bond amount and token
///  This limit is enforced only at the time of setting or updating the flow from the contract to the PIC.
function getMaxExitRateFor(ISuperToken token, uint256 bondAmount) external view returns (int96 exitRate);;
```

### changeExitRate(contract ISuperToken,int96) (inherited from ITOGAv1)

- **Signature**: `changeExitRate(contract ISuperToken,int96)`
- **Visibility**: external
- **Source Range**: 4361:71:183

**Signature:**
```solidity
///  @dev allows the current PIC for the given token to change the exit rate
///  @param token The Super Token the exit rate should be changed for
///  @param newExitRate The new exit rate. The same constraints as during bidding apply.
///  Notes:
///  newExitRate can't be higher than the value returned by getMaxExitRateFor() for the given token and bond.
///  newExitRate can also be 0, this triggers closing of the flow from the contract to the PIC.
///  If newExitRate is > 0 and no flow exists, a flow is created.
function changeExitRate(ISuperToken token, int96 newExitRate) external;;
```
