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

        this.txIndex++;
        let args;
        let contractArguments = new Array()
        let key = keyfunc()
        contractArguments[0] = key.toString()
        contractArguments[1] = (key * constantMultiplier).toString()
        var quotedAndCommaSeparated = '[' + "\"" + contractArguments.join("\",\"") + "\"" + ']';
        let client =  'client' + '0' + '.org1' + '.example.com'
        if (this.workerIndex < 5) {
            client =  'client' + this.workerIndex + '.org1' + '.example.com'
        }
        else  {
            client = 'client' + this.workerIndex + '.org2' + '.example.com'
        }
        
        console.log(" Worker: ", this.workerIndex, "Client: ", client)
        console.log(" Worker: ", this.workerIndex, "Transaction: ", this.txIndex)

        args = { contractId: 'generator',
                    contractVersion: 'v1',
                    contractFunction: contractFunction,
                    contractArguments: [quotedAndCommaSeparated],
                    invokerIdentity: client,
                    timeout: '30' }
        
        // if (this.txIndex % 10 == 0) {
        //     await this.sutAdapter.sendRequests(args);            
        // } else {
        //     console.log("Skipping  transaction: ", this.txIndex)
        // }

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

