# Function: executeStep(uint8)

**Contract**: [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeployer.t.sol/contract_SuperfluidFrameworkDeployer.md]

## Metadata

- **Contract**: SuperfluidFrameworkDeployer
- **Signature**: `executeStep(uint8)`
- **Visibility**: public
- **Source Range**: 5661:8777:181
- **Inherited From**: SuperfluidFrameworkDeploymentSteps

## Implementation

```solidity
function executeStep(uint8 step) public {
    if (step != currentStep) revert("Incorrect step");
    if (step == 0) {
        testGovernance = SuperfluidGovDeployerLibrary.deployTestGovernance();
        SuperfluidGovDeployerLibrary.transferOwnership(testGovernance, address(this));
    } else if (step == 1) {
        SimpleForwarder simpleForwarder = new SimpleForwarder();
        ERC2771Forwarder erc2771Forwarder = new ERC2771Forwarder();
        host = SuperfluidHostDeployerLibrary.deploy(true, false, 3_000_000, address(simpleForwarder), address(erc2771Forwarder));
        simpleForwarder.transferOwnership(address(host));
        erc2771Forwarder.transferOwnership(address(host));
        host.initialize(testGovernance);
        testGovernance.initialize(host, DEFAULT_REWARD_ADDRESS, DEFAULT_LIQUIDATION_PERIOD, DEFAULT_PATRICIAN_PERIOD, new address[](0));
    } else if (step == 2) {
        ConstantFlowAgreementV1 cfaV1Logic = SuperfluidCFAv1DeployerLibrary.deploy(host);
        InstantDistributionAgreementV1 idaV1Logic = SuperfluidIDAv1DeployerLibrary.deploy(host);
        GeneralDistributionAgreementV1 gdaV1Logic;
        {
            SuperfluidPool superfluidPoolLogic = SuperfluidPoolLogicDeployerLibrary.deploy(GeneralDistributionAgreementV1(address(0)));
            SuperfluidUpgradeableBeacon superfluidPoolBeacon = ProxyDeployerLibrary.deploySuperfluidUpgradeableBeacon(address(superfluidPoolLogic));
            gdaV1Logic = SuperfluidGDAv1DeployerLibrary.deploy(host, superfluidPoolBeacon);
        }
        testGovernance.registerAgreementClass(host, address(cfaV1Logic));
        cfaV1 = ConstantFlowAgreementV1(address(host.getAgreementClass(cfaV1Logic.agreementType())));
        testGovernance.registerAgreementClass(host, address(idaV1Logic));
        idaV1 = InstantDistributionAgreementV1(address(host.getAgreementClass(idaV1Logic.agreementType())));
        testGovernance.registerAgreementClass(host, address(gdaV1Logic));
        gdaV1 = GeneralDistributionAgreementV1(address(host.getAgreementClass(gdaV1Logic.agreementType())));
        {
            SuperfluidPool superfluidPoolLogic = SuperfluidPoolLogicDeployerLibrary.deploy(gdaV1);
            superfluidPoolLogic.castrate();
            gdaV1Logic.superfluidPoolBeacon().upgradeTo(address(superfluidPoolLogic));
            gdaV1Logic.superfluidPoolBeacon().transferOwnership(address(host));
        }
    } else if (step == 3) {
        {
            poolAdminNFT = PoolAdminNFT(address(ProxyDeployerLibrary.deployUUPSProxy()));
            PoolAdminNFT poolAdminNFTLogic = SuperfluidPoolNFTLogicDeployerLibrary.deployPoolAdminNFT(host, gdaV1);
            poolAdminNFTLogic.castrate();
            UUPSProxy(payable(address(poolAdminNFT))).initializeProxy(address(poolAdminNFTLogic));
            poolMemberNFT = PoolMemberNFT(address(ProxyDeployerLibrary.deployUUPSProxy()));
            PoolMemberNFT poolMemberNFTLogic = SuperfluidPoolNFTLogicDeployerLibrary.deployPoolMemberNFT(host, gdaV1);
            poolMemberNFTLogic.castrate();
            UUPSProxy(payable(address(poolMemberNFT))).initializeProxy(address(poolMemberNFTLogic));
            poolAdminNFT.initialize("Pool Admin NFT", "PA");
            poolMemberNFT.initialize("Pool Member NFT", "PM");
        }
    } else if (step == 4) {
        cfaV1Forwarder = CFAv1ForwarderDeployerLibrary.deploy(host);
        testGovernance.enableTrustedForwarder(host, ISuperfluidToken(address(0)), address(cfaV1Forwarder));
        gdaV1Forwarder = GDAv1ForwarderDeployerLibrary.deploy(host);
        testGovernance.enableTrustedForwarder(host, ISuperfluidToken(address(0)), address(gdaV1Forwarder));
        macroForwarder = new MacroForwarder(host);
        testGovernance.enableTrustedForwarder(host, ISuperfluidToken(address(0)), address(macroForwarder));
    } else if (step == 5) {
        superTokenLogic = SuperToken(SuperTokenDeployerLibrary.deploy(host, poolAdminNFT, poolMemberNFT));
        SuperTokenFactory superTokenFactoryLogic = SuperTokenFactoryDeployerLibrary.deploy(host, superTokenLogic, IPoolAdminNFT(poolAdminNFT.getCodeAddress()), IPoolMemberNFT(poolMemberNFT.getCodeAddress()));
        testGovernance.updateContracts(host, address(0), new address[](0), address(superTokenFactoryLogic), address(0));
        superTokenFactory = SuperTokenFactory(address(host.getSuperTokenFactory()));
    } else if (step == 6) {
        testResolver = SuperfluidPeripheryDeployerLibrary.deployTestResolver(address(this));
        superfluidLoader = SuperfluidPeripheryDeployerLibrary.deploySuperfluidLoader(testResolver);
        testResolver.set("TestGovernance.test", address(testGovernance));
        testResolver.set("Superfluid.test", address(host));
        testResolver.set("SuperfluidLoader-v1", address(superfluidLoader));
        testResolver.set("CFAv1Forwarder", address(cfaV1Forwarder));
        testResolver.set("GDAv1Forwarder", address(gdaV1Forwarder));
        testResolver.addAdmin(msg.sender);
        batchLiquidator = SuperfluidPeripheryDeployerLibrary.deployBatchLiquidator(host);
        if (!_is1820Deployed()) revert DEPLOY_TOGA_REQUIRES_1820();
        toga = SuperfluidPeripheryDeployerLibrary.deployTOGA(host, DEFAULT_TOGA_MIN_BOND_DURATION);
        testGovernance.setRewardAddress(host, ISuperfluidToken(address(0)), address(toga));
    } else {
        revert("Invalid step");
    }
    currentStep++;
}
```

## Related Implementations

### deployTestGovernance()

- **Kind**: internal
- **Source**: 14749:110:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidGovDeployerLibrary:deployTestGovernance()`

```solidity
function deployTestGovernance() external returns (TestGovernance) {
    return new TestGovernance();
}
```

### transferOwnership(contract TestGovernance,address)

- **Kind**: internal
- **Source**: 14865:126:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidGovDeployerLibrary:transferOwnership(contract TestGovernance,address)`

```solidity
function transferOwnership(TestGovernance _gov, address _newOwner) external {
    _gov.transferOwnership(_newOwner);
}
```

### deploy(bool,bool,uint64,address,address)

- **Kind**: internal
- **Source**: 15039:413:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidHostDeployerLibrary:deploy(bool,bool,uint64,address,address)`

```solidity
function deploy(bool _nonUpgradable, bool _appWhiteListingEnabled, uint64 callbackGasLimit, address simpleForwarderAddress, address erc2771ForwarderAddress) external returns (Superfluid) {
    return new Superfluid(_nonUpgradable, _appWhiteListingEnabled, callbackGasLimit, simpleForwarderAddress, erc2771ForwarderAddress);
}
```

### deploy(contract ISuperfluid)

- **Kind**: internal
- **Source**: 15501:136:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidCFAv1DeployerLibrary:deploy(contract ISuperfluid)`

```solidity
function deploy(ISuperfluid _host) external returns (ConstantFlowAgreementV1) {
    return new ConstantFlowAgreementV1(_host);
}
```

### deploy(contract ISuperfluid)

- **Kind**: internal
- **Source**: 15686:170:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidIDAv1DeployerLibrary:deploy(contract ISuperfluid)`

```solidity
function deploy(ISuperfluid _host) external returns (InstantDistributionAgreementV1) {
    return new InstantDistributionAgreementV1(_host);
}
```

### deploy(contract GeneralDistributionAgreementV1)

- **Kind**: internal
- **Source**: 15909:133:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPoolLogicDeployerLibrary:deploy(contract GeneralDistributionAgreementV1)`

```solidity
function deploy(GeneralDistributionAgreementV1 gda) external returns (SuperfluidPool) {
    return new SuperfluidPool(gda);
}
```

### deploySuperfluidUpgradeableBeacon(address)

- **Kind**: internal
- **Source**: 17659:183:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:ProxyDeployerLibrary:deploySuperfluidUpgradeableBeacon(address)`

```solidity
function deploySuperfluidUpgradeableBeacon(address logicContract) external returns (SuperfluidUpgradeableBeacon) {
    return new SuperfluidUpgradeableBeacon(logicContract);
}
```

### deploy(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)

- **Kind**: internal
- **Source**: 16091:249:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidGDAv1DeployerLibrary:deploy(contract ISuperfluid,contract SuperfluidUpgradeableBeacon)`

```solidity
function deploy(ISuperfluid host, SuperfluidUpgradeableBeacon superfluidPoolBeacon) external returns (GeneralDistributionAgreementV1 gdaV1Logic) {
    gdaV1Logic = new GeneralDistributionAgreementV1(host, superfluidPoolBeacon);
}
```

### deployUUPSProxy()

- **Kind**: internal
- **Source**: 17558:95:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:ProxyDeployerLibrary:deployUUPSProxy()`

```solidity
function deployUUPSProxy() external returns (UUPSProxy) {
    return new UUPSProxy();
}
```

### deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Kind**: internal
- **Source**: 17138:186:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPoolNFTLogicDeployerLibrary:deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`

```solidity
function deployPoolAdminNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolAdminNFT) {
    return new PoolAdminNFT(host, gda);
}
```

### deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)

- **Kind**: internal
- **Source**: 17330:189:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPoolNFTLogicDeployerLibrary:deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1)`

```solidity
function deployPoolMemberNFT(ISuperfluid host, IGeneralDistributionAgreementV1 gda) external returns (PoolMemberNFT) {
    return new PoolMemberNFT(host, gda);
}
```

### deploy(contract ISuperfluid)

- **Kind**: internal
- **Source**: 16388:118:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:CFAv1ForwarderDeployerLibrary:deploy(contract ISuperfluid)`

```solidity
function deploy(ISuperfluid _host) external returns (CFAv1Forwarder) {
    return new CFAv1Forwarder(_host);
}
```

### deploy(contract ISuperfluid)

- **Kind**: internal
- **Source**: 16554:118:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:GDAv1ForwarderDeployerLibrary:deploy(contract ISuperfluid)`

```solidity
function deploy(ISuperfluid _host) external returns (GDAv1Forwarder) {
    return new GDAv1Forwarder(_host);
}
```

### deploy(contract ISuperfluid,contract IPoolAdminNFT,contract IPoolMemberNFT)

- **Kind**: internal
- **Source**: 16716:366:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperTokenDeployerLibrary:deploy(contract ISuperfluid,contract IPoolAdminNFT,contract IPoolMemberNFT)`

```solidity
function deploy(ISuperfluid host, IPoolAdminNFT poolAdminNFT, IPoolMemberNFT poolMemberNFT) external returns (address) {
    return address(new SuperToken(host, IConstantOutflowNFT(address(0)), IConstantInflowNFT(address(0)), poolAdminNFT, poolMemberNFT));
}
```

### deploy(contract ISuperfluid,contract ISuperToken,contract IPoolAdminNFT,contract IPoolMemberNFT)

- **Kind**: internal
- **Source**: 18442:460:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperTokenFactoryDeployerLibrary:deploy(contract ISuperfluid,contract ISuperToken,contract IPoolAdminNFT,contract IPoolMemberNFT)`

```solidity
function deploy(ISuperfluid host, ISuperToken superTokenLogic, IPoolAdminNFT poolAdminNFTLogic, IPoolMemberNFT poolMemberNFTLogic) external returns (SuperTokenFactory) {
    return new SuperTokenFactory(host, superTokenLogic, IConstantOutflowNFT(address(0)), IConstantInflowNFT(address(0)), poolAdminNFTLogic, poolMemberNFTLogic);
}
```

### deployTestResolver(address)

- **Kind**: internal
- **Source**: 18955:142:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPeripheryDeployerLibrary:deployTestResolver(address)`

```solidity
function deployTestResolver(address additionalAdmin) external returns (TestResolver) {
    return new TestResolver(additionalAdmin);
}
```

### deploySuperfluidLoader(contract IResolver)

- **Kind**: internal
- **Source**: 19103:142:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPeripheryDeployerLibrary:deploySuperfluidLoader(contract IResolver)`

```solidity
function deploySuperfluidLoader(IResolver resolver) external returns (SuperfluidLoader) {
    return new SuperfluidLoader(resolver);
}
```

### deployBatchLiquidator(contract ISuperfluid)

- **Kind**: internal
- **Source**: 19251:142:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPeripheryDeployerLibrary:deployBatchLiquidator(contract ISuperfluid)`

```solidity
function deployBatchLiquidator(ISuperfluid host) external returns (BatchLiquidator) {
    return new BatchLiquidator(address(host));
}
```

### _is1820Deployed()

- **Kind**: internal
- **Source**: 14444:228:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidFrameworkDeploymentSteps:_is1820Deployed()`

```solidity
function _is1820Deployed() internal view returns (bool) {
    uint256 codeSize;
    assembly {
        codeSize := extcodesize(0x1820a4B7618BdE71Dce8cdc73aAB6C95905faD24)
    }
    return codeSize != 0;
}
```

### deployTOGA(contract ISuperfluid,uint256)

- **Kind**: internal
- **Source**: 19399:142:181
- **Link**: `lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidFrameworkDeploymentSteps.t.sol:SuperfluidPeripheryDeployerLibrary:deployTOGA(contract ISuperfluid,uint256)`

```solidity
function deployTOGA(ISuperfluid host, uint256 minBondDuration) external returns (TOGA) {
    return new TOGA(host, minBondDuration);
}
```

## External Calls

- **SimpleForwarder::transferOwnership(address)**
- **ERC2771Forwarder::transferOwnership(address)**
- **Superfluid::initialize(contract ISuperfluidGovernance)**
- **TestGovernance::initialize(contract ISuperfluid,address,uint256,uint256,address[])**
- **TestGovernance::registerAgreementClass(contract ISuperfluid,address)**
- **Superfluid::getAgreementClass(bytes32)**
- **ConstantFlowAgreementV1::agreementType()**
- **InstantDistributionAgreementV1::agreementType()**
- **GeneralDistributionAgreementV1::agreementType()**
- **SuperfluidPool::castrate()**
- **SuperfluidUpgradeableBeacon::upgradeTo(address)**
- **GeneralDistributionAgreementV1::superfluidPoolBeacon()**
- **SuperfluidUpgradeableBeacon::transferOwnership(address)**
- **PoolAdminNFT::castrate()**
- **UUPSProxy::initializeProxy(address)**
- **PoolMemberNFT::castrate()**
- **PoolAdminNFT::initialize(string,string)**
- **PoolMemberNFT::initialize(string,string)**
- **TestGovernance::enableTrustedForwarder(contract ISuperfluid,contract ISuperfluidToken,address)**
- **PoolAdminNFT::getCodeAddress()**
- **PoolMemberNFT::getCodeAddress()**
- **TestGovernance::updateContracts(contract ISuperfluid,address,address[],address,address)**
- **Superfluid::getSuperTokenFactory()**
- **TestResolver::set(string,address)**
- **TestResolver::addAdmin(address)**
- **TestGovernance::setRewardAddress(contract ISuperfluid,contract ISuperfluidToken,address)**
- **TestGovernance::transferOwnership(address)**

## State Variable Reads

- **currentStep** (`uint8`)
- **testGovernance** (`contract TestGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]
- **host** (`contract Superfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]
- **DEFAULT_REWARD_ADDRESS** (`address`)
- **DEFAULT_LIQUIDATION_PERIOD** (`uint256`)
- **DEFAULT_PATRICIAN_PERIOD** (`uint256`)
- **gdaV1** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]
- **poolAdminNFT** (`contract PoolAdminNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]
- **poolMemberNFT** (`contract PoolMemberNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]
- **cfaV1Forwarder** (`contract CFAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]
- **gdaV1Forwarder** (`contract GDAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]
- **macroForwarder** (`contract MacroForwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]
- **superTokenLogic** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **testResolver** (`contract TestResolver`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]
- **superfluidLoader** (`contract SuperfluidLoader`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]
- **DEFAULT_TOGA_MIN_BOND_DURATION** (`uint256`)
- **toga** (`contract TOGA`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]

## State Variable Writes

- **testGovernance** (`contract TestGovernance`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestGovernance.sol/contract_TestGovernance.md]
- **host** (`contract Superfluid`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/Superfluid.sol/contract_Superfluid.md]
- **cfaV1** (`contract ConstantFlowAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/ConstantFlowAgreementV1.sol/contract_ConstantFlowAgreementV1.md]
- **idaV1** (`contract InstantDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/InstantDistributionAgreementV1.sol/contract_InstantDistributionAgreementV1.md]
- **gdaV1** (`contract GeneralDistributionAgreementV1`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/GeneralDistributionAgreementV1.sol/contract_GeneralDistributionAgreementV1.md]
- **poolAdminNFT** (`contract PoolAdminNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolAdminNFT.sol/contract_PoolAdminNFT.md]
- **poolMemberNFT** (`contract PoolMemberNFT`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/agreements/gdav1/PoolMemberNFT.sol/contract_PoolMemberNFT.md]
- **cfaV1Forwarder** (`contract CFAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/CFAv1Forwarder.sol/contract_CFAv1Forwarder.md]
- **gdaV1Forwarder** (`contract GDAv1Forwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/GDAv1Forwarder.sol/contract_GDAv1Forwarder.md]
- **macroForwarder** (`contract MacroForwarder`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/MacroForwarder.sol/contract_MacroForwarder.md]
- **superTokenLogic** (`contract ISuperToken`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/interfaces/superfluid/ISuperToken.sol/interface_ISuperToken.md]
- **superTokenFactory** (`contract SuperTokenFactory`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/superfluid/SuperTokenFactory.sol/contract_SuperTokenFactory.md]
- **testResolver** (`contract TestResolver`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TestResolver.sol/contract_TestResolver.md]
- **superfluidLoader** (`contract SuperfluidLoader`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/SuperfluidLoader.sol/contract_SuperfluidLoader.md]
- **batchLiquidator** (`contract BatchLiquidator`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/BatchLiquidator.sol/contract_BatchLiquidator.md]
- **toga** (`contract TOGA`) [lib/superfluid-protocol-monorepo/packages/ethereum-contracts/contracts/utils/TOGA.sol/contract_TOGA.md]
- **currentStep** (`uint8`)

## Call Tree

```
┌─ [0] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps.executeStep(uint8) (NodeID: 0)
    💬 Args: [no args]
    👁️  Def: public
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovDeployerLibrary.deployTestGovernance() (NodeID: 1)
  │   💬 Args: [no args]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGovDeployerLibrary.transferOwnership(contract TestGovernance,address) (NodeID: 2)
  │   💬 Args: [testGovernance, address(this)]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidHostDeployerLibrary.deploy(bool,bool,uint64,address,address) (NodeID: 3)
  │   💬 Args: [true, false, 3_000_000, address(simpleForwarder), address(erc2771Forwarder)]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidCFAv1DeployerLibrary.deploy(contract ISuperfluid) (NodeID: 4)
  │   💬 Args: [host]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidIDAv1DeployerLibrary.deploy(contract ISuperfluid) (NodeID: 5)
  │   💬 Args: [host]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPoolLogicDeployerLibrary.deploy(contract GeneralDistributionAgreementV1) (NodeID: 6)
  │   💬 Args: [GeneralDistributionAgreementV1(address(0))]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ProxyDeployerLibrary.deploySuperfluidUpgradeableBeacon(address) (NodeID: 7)
  │   💬 Args: [address(superfluidPoolLogic)]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidGDAv1DeployerLibrary.deploy(contract ISuperfluid,contract SuperfluidUpgradeableBeacon) (NodeID: 8)
  │   💬 Args: [host, superfluidPoolBeacon]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPoolLogicDeployerLibrary.deploy(contract GeneralDistributionAgreementV1) (NodeID: 9)
  │   💬 Args: [gdaV1]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ProxyDeployerLibrary.deployUUPSProxy() (NodeID: 10)
  │   💬 Args: [no args]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPoolNFTLogicDeployerLibrary.deployPoolAdminNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1) (NodeID: 11)
  │   💬 Args: [host, gdaV1]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: ProxyDeployerLibrary.deployUUPSProxy() (NodeID: 12)
  │   💬 Args: [no args]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPoolNFTLogicDeployerLibrary.deployPoolMemberNFT(contract ISuperfluid,contract IGeneralDistributionAgreementV1) (NodeID: 13)
  │   💬 Args: [host, gdaV1]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: CFAv1ForwarderDeployerLibrary.deploy(contract ISuperfluid) (NodeID: 14)
  │   💬 Args: [host]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: GDAv1ForwarderDeployerLibrary.deploy(contract ISuperfluid) (NodeID: 15)
  │   💬 Args: [host]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperTokenDeployerLibrary.deploy(contract ISuperfluid,contract IPoolAdminNFT,contract IPoolMemberNFT) (NodeID: 16)
  │   💬 Args: [host, poolAdminNFT, poolMemberNFT]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperTokenFactoryDeployerLibrary.deploy(contract ISuperfluid,contract ISuperToken,contract IPoolAdminNFT,contract IPoolMemberNFT) (NodeID: 17)
  │   💬 Args: [host, superTokenLogic, IPoolAdminNFT(poolAdminNFT.getCodeAddress()), IPoolMemberNFT(poolMemberNFT.getCodeAddress())]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPeripheryDeployerLibrary.deployTestResolver(address) (NodeID: 18)
  │   💬 Args: [address(this)]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPeripheryDeployerLibrary.deploySuperfluidLoader(contract IResolver) (NodeID: 19)
  │   💬 Args: [testResolver]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidPeripheryDeployerLibrary.deployBatchLiquidator(contract ISuperfluid) (NodeID: 20)
  │   💬 Args: [host]
  │   👁️  Def: external
  ├─ [1] ⚙️ FUNCTION: SuperfluidFrameworkDeploymentSteps._is1820Deployed() (NodeID: 21)
  │   💬 Args: [no args]
  │   👁️  Def: internal
  └─ [1] ⚙️ FUNCTION: SuperfluidPeripheryDeployerLibrary.deployTOGA(contract ISuperfluid,uint256) (NodeID: 22)
      💬 Args: [host, DEFAULT_TOGA_MIN_BOND_DURATION]
      👁️  Def: external
```
