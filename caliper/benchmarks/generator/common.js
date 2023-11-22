'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

var zipfian  = require("zipfian-integer")
var deck = require('deck');
const getValues = require('./getValues');

let filearray = [];
let sizeKeySpace = 10000
const constantMultiplier = 100
let keyDisttribution = 2
const keyfunc = zipfian(sizeKeySpace, sizeKeySpace*2, keyDisttribution)

/**
 * Workload module for the benchmark round.
 */
class CreateCarWorkload extends WorkloadModuleBase {
    /**
     * Initializes the workload module instance.
     */
    constructor() {
        super();
        this.txIndex = 0;
    }
    /**
     * Assemble TXs for the round.
     * @return {Promise<TxStatus[]>}
     */
    async submitTransaction() {


	let args;
    let contractFunction = 'UpdatePlayCount'
    if (getValues.workloadType() == 0) {
        contractFunction = deck.pick({'UpdatePlayCount': 10, 'CalculateRevenue': 0});
    }
    else {
        contractFunction = deck.pick({'UpdatePlayCount': 10, 'CalculateRevenue': 1});
    }


    let contractArguments = new Array()
    let key = keyfunc()
    contractArguments[0] = key.toString()
    contractArguments[1] = (key * constantMultiplier).toString()
    contractArguments[2] = getValues.functionType().toString()
    contractArguments[3] = 0
    // TEMP: NOT REQUIRED EVER! Comment this if statement for baseline run
    // if (this.txIndex == 0 && (this.roundIndex == 0 || this.roundIndex == 1)) {
    //     contractArguments[3] = 1
    // }

	var quotedAndCommaSeparated = '[' + "\"" + contractArguments.join("\",\"") + "\"" + ']';

	// console.log(quotedAndCommaSeparated)

	args = { contractId: 'generator',
                contractVersion: 'v1',
                contractFunction: contractFunction,
                contractArguments: [quotedAndCommaSeparated],
                timeout: '30' }
        

	    await this.sutAdapter.sendRequests(args);

    }
}

/**
 * Create a new instance of the workload module.
 * @return {WorkloadModuleInterface}
 */
function createWorkloadModule() {
	filearray = [];
    return new CreateCarWorkload();
}

module.exports.createWorkloadModule = createWorkloadModule;

