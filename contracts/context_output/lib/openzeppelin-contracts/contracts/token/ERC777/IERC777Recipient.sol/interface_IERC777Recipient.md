# Interface: IERC777Recipient

## Metadata

- **Name**: IERC777Recipient
- **Type**: Interface
- **Path**: lib/openzeppelin-contracts/contracts/token/ERC777/IERC777Recipient.sol
- **Documentation**:  @dev Interface of the ERC777TokensRecipient standard as defined in the EIP.
   Accounts can be notified of {IERC777} tokens being sent to them by having a
   contract implement this interface (contract holders can be their own
   implementer) and registering it on the
   https://eips.ethereum.org/EIPS/eip-1820[ERC1820 global registry].
   See {IERC1820Registry} and {ERC1820Implementer}.

## Public/External Functions

### tokensReceived(address,address,address,uint256,bytes,bytes)

- **Signature**: `tokensReceived(address,address,address,uint256,bytes,bytes)`
- **Visibility**: external
- **Source Range**: 1046:201:101

**Signature:**
```solidity
///  @dev Called by an {IERC777} token contract whenever tokens are being
///  moved or created into a registered account (`to`). The type of operation
///  is conveyed by `from` being the zero address or not.
///  This call occurs _after_ the token contract's state is updated, so
///  {IERC777-balanceOf}, etc., can be used to query the post-operation state.
///  This function may revert to prevent the operation from being executed.
function tokensReceived(address operator, address from, address to, uint256 amount, bytes calldata userData, bytes calldata operatorData) external;;
```
