# Contract: SemanticMoney

## Metadata

- **Name**: SemanticMoney
- **Type**: Contract
- **Path**: lib/superfluid-protocol-monorepo/packages/solidity-semantic-money/src/SemanticMoney.sol
- **Documentation**:  @dev Semantic Money Library: providing generalized payment primitives.
   Notes:
   - Basic payment 2-primitives include shift2 and flow2.
   - As its name suggesting, 2-primitives work over two parties, each party is represented by an "index".
   - A universal index is BasicParticle plus being a Monoid. It is universal in the sense that every monetary
   unit should have one and only one such index.
   - Proportional distribution pool has one index per pool.
   - This solidity library provides 2-primitives for `UniversalIndex-to-UniversalIndex` and
     `UniversalIndex-to-ProportionalDistributionPoolIndex`.
