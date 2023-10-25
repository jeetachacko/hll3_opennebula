/*
* Licensed under the Apache License, Version 2.0 (the "License");
* you may not use this file except in compliance with the License.
* You may obtain a copy of the License at
*
* http://www.apache.org/licenses/LICENSE-2.0
*
* Unless required by applicable law or agreed to in writing, software
* distributed under the License is distributed on an "AS IS" BASIS,
* WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
* See the License for the specific language governing permissions and
* limitations under the License.
*/

'use strict';

//function nocache(module) {require("fs").watchFile(require("path").resolve(module), () => {delete require.cache[require.resolve(module)]})}
//nocache("./getValues.js");

const RateInterface = require('@hyperledger/caliper-core/lib/worker/rate-control/rateInterface.js');
let Sleep = require('@hyperledger/caliper-core/lib/common/utils/caliper-utils').sleep;
const getValues = require('./getValues.js');
//const fs = require('fs');
//var stream = fs.createWriteStream("/home/ubuntu/hll3_opennebula/caliper/blockreader-logs.txt", {flags:'a'});
//let getValues = requireUncached('./getValues')
/**
 * Rate controller that sends transactions at a fixed rate.
 *
 * @property {number} sleepTime The number of milliseconds to sleep to keep the specified TX sending rate.
 *
 * @extends RateInterface
 *
*/

// function requireUncached(module) {
//     delete require.cache[require.resolve(module)];
//     return require(module);
// }

class CustomRate extends RateInterface {

    /**
     * Initializes the rate controller instance.
     * @param {TestMessage} testMessage start test message
     * @param {TransactionStatisticsCollector} stats The TX stats collector instance.
     * @param {number} workerIndex The 0-based index of the worker node.
     */
    constructor(testMessage, stats, workerIndex) {
        super(testMessage, stats, workerIndex);
        this.txIndex = 0;

        const tps = this.options.tps ? this.options.tps : 10;
        //let getValues = requireUncached('/caliper-getvalues/getValues')
        let learnedrate = getValues.workerLearnedRate();
        let tpsPerWorker = learnedrate[workerIndex]
        //console.log("applyRateControl workerIndex:", this.workerIndex, "tpsPerWorker:", tpsPerWorker)
        this.sleepTime = (tpsPerWorker > 0) ? 1000/tpsPerWorker : 0;
    }

    /**
     * Perform the rate control action by blocking the execution for a certain amount of time.
     * @async
     */
    async applyRateControl() {

        this.txIndex++;
        //console.log("applyRateControl txIndex:", this.txIndex)
        
        if (this.sleepTime === 0) {
            return;
        }

        const totalSubmitted = this.stats.getTotalSubmittedTx();
        let diff = (this.sleepTime * totalSubmitted - (Date.now() - this.stats.getRoundStartTime()));
        // if (this.workerIndex > 5) {
        //     diff = diff + 5000;
        //     // diff = ((diff + 10000) > 0) ? diff + 2000 : diff;
        // }
        // console.log("applyRateControl workerIndex:", this.workerIndex, "diff:", diff)
        // console.log("applyRateControl workerIndex:", this.workerIndex, "getTotalSubmittedTx:", this.stats.getTotalSubmittedTx())
        // console.log("applyRateControl workerIndex:", this.workerIndex, "getTotalSuccessfulTx:", this.stats.getTotalSuccessfulTx())
        // console.log("applyRateControl workerIndex:", this.workerIndex, "getTotalLatencyForSuccessful:", this.stats.getTotalLatencyForSuccessful())
        await Sleep(diff);
    }

    /**
     * Notify the rate controller about the end of the round.
     * @async
     */
    async end() { 
        console.log("applyRateControl workerIndex=", this.workerIndex, "=getTotalSuccessfulTx=", this.stats.getTotalSuccessfulTx(), "=getTotalSubmittedTx=", this.stats.getTotalSubmittedTx(), "=getTotalLatencyForSuccessful=", this.stats.getTotalLatencyForSuccessful(), "=")
        //stream.write("Worker: " + this.workerIndex + " CumulativeTxStatistics: " + this.stats.getCumulativeTxStatistics() + "\n");
        // console.log("end txIndex:", this.txIndex)
        // let getValues = requireUncached('/caliper-getvalues/getValues')
        // for (const path in require.cache) {
        //     if (path.endsWith('getValues.js')) { // only clear *.js, not *.node
        //       delete require.cache[path]
        //     }
        // }
        //delete require.cache['./getValues'];
        //delete require.cache[require.resolve('/caliper-workload/getValues.js')];
        //Object.keys(require.cache).forEach(function(key) { delete require.cache[key] })
        //for (var i in require.cache) { delete require.cache[i] }
        //let getValues = require('/caliper-workload/getValues.js');
        // let learnedrate = getValues.workerLearnedRate();
        // let tpsPerWorker = learnedrate[this.workerIndex]
        // this.sleepTime = (tpsPerWorker > 0) ? 1000/tpsPerWorker : 0;
    }
}

/**
 * Factory for creating a new rate controller instance.
 * @param {TestMessage} testMessage start test message
 * @param {TransactionStatisticsCollector} stats The TX stats collector instance.
 * @param {number} workerIndex The 0-based index of the worker node.
 *
 * @return {RateInterface} The new rate controller instance.
 */
function createRateController(testMessage, stats, workerIndex) {
    return new CustomRate(testMessage, stats, workerIndex);
}

module.exports.createRateController = createRateController;