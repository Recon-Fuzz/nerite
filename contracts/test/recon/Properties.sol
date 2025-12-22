// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {BeforeAfter} from "./BeforeAfter.sol";

import {MIN_DEBT} from "../../src/Dependencies/Constants.sol";
import {LatestBatchData} from "../../src/Types/LatestBatchData.sol";
import {BatchId} from "../../src/Types/BatchId.sol";
import {SortedTroves} from "../../src/SortedTroves.sol";
import {LatestTroveData} from "../../src/Types/LatestTroveData.sol";


abstract contract Properties is BeforeAfter, Asserts {

    function _sumBatchSharesAndDebt(address batchManager) internal returns (uint256 sumBatchDebt, uint256 sumbBatchShares) {

        uint256 trove = sortedTroves.getFirst(); /// NOTE: Troves in ST are active
        while(trove != 0) {
            
            if(borrowerOperations.interestBatchManagerOf(trove) == clampedBatchManager) {
                sumBatchDebt += troveManager.getTroveEntireDebt(trove);
                sumbBatchShares += troveManager.getTroveBatchDebtShares(trove); 
            }

            trove = sortedTroves.getNext(trove);
        }

        // Add lastZombieTroveId if necessary
        uint256 lastZombieTroveId = troveManager.lastZombieTroveId();
        if(borrowerOperations.interestBatchManagerOf(lastZombieTroveId) == clampedBatchManager) {
            sumBatchDebt += troveManager.getTroveEntireDebt(lastZombieTroveId);
            sumbBatchShares += troveManager.getTroveBatchDebtShares(lastZombieTroveId);
        }
    }
}
