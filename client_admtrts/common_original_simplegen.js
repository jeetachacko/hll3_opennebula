'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');

var zipfian  = require("zipfian-integer")
let filearray = [];
let contractFunction = 'Func70'
let sizeKeySpace = 10000
let keyDisttribution = 1
const constantMultiplier = 100
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
    let contractArguments = new Array()
    let key = keyfunc()
    contractArguments[0] = key.toString()
    contractArguments[1] = (key * constantMultiplier).toString()
	var quotedAndCommaSeparated = '[' + "\"" + contractArguments.join("\",\"") + "\"" + ']';

	console.log(quotedAndCommaSeparated)

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

