# Function: decodeCtx(bytes)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]

## Metadata

- **Contract**: Superfluid
- **Signature**: `decodeCtx(bytes)`
- **Visibility**: public
- **Source Range**: 29063:150:163

## Implementation

```solidity
function decodeCtx(bytes memory ctx) override public pure returns (Context memory context) {
    return _decodeCtx(ctx);
}
```

## Related Implementations

### _decodeCtx(bytes)

- **Kind**: internal
- **Source**: 38076:1203:163
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol:Superfluid:_decodeCtx(bytes)`

```solidity
function _decodeCtx(bytes memory ctx) private pure returns (Context memory context) {
    bytes memory ctx1;
    bytes memory ctx2;
    (ctx1, ctx2) = abi.decode(ctx, (bytes, bytes));
    {
        uint256 callInfo;
        (callInfo, context.timestamp, context.msgSender, context.agreementSelector, context.userData) = abi.decode(ctx1, (uint256, uint256, address, bytes4, bytes));
        (context.appCallbackLevel, context.callType) = ContextDefinitions.decodeCallInfo(callInfo);
    }
    {
        uint256 creditIO;
        (creditIO, context.appCreditUsed, context.appAddress, context.appCreditToken) = abi.decode(ctx2, (uint256, int256, address, ISuperfluidToken));
        context.appCreditGranted = creditIO & type(uint128).max;
        context.appCreditWantedDeprecated = creditIO >> 128;
    }
}
```

### decodeCallInfo(uint256)

- **Kind**: internal
- **Source**: 3883:297:139
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/Definitions.sol:ContextDefinitions:decodeCallInfo(uint256)`

```solidity
function decodeCallInfo(uint256 callInfo) internal pure returns (uint8 appCallbackLevel, uint8 callType) {
    appCallbackLevel = uint8(callInfo & CALL_INFO_APP_LEVEL_MASK);
    callType = uint8((callInfo & CALL_INFO_CALL_TYPE_MASK) >> CALL_INFO_CALL_TYPE_SHIFT);
}
```

## State Variable Reads

- **CALL_INFO_APP_LEVEL_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_MASK** (`uint256`)
- **CALL_INFO_CALL_TYPE_SHIFT** (`uint256`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: Superfluid.decodeCtx(bytes) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  └─ [1] ⚙️ FUNCTION: Superfluid._decodeCtx(bytes) (NodeID: 1)
      💬 Args: [ctx]
      👁️  Def: private
    └─ [2] ⚙️ FUNCTION: ContextDefinitions.decodeCallInfo(uint256) (NodeID: 2)
        💬 Args: [callInfo]
        👁️  Def: internal
```
