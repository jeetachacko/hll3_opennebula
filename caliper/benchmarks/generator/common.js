'use strict';

const { WorkloadModuleBase } = require('@hyperledger/caliper-core');
let Sleep = require('@hyperledger/caliper-core/lib/common/utils/caliper-utils').sleep;

var zipfian  = require("zipfian-integer")
let filearray = [];
let contractFunction = 'Func70'
let sizeKeySpace = 10000
let keyDisttribution = 0
const constantMultiplier = 100
//const keyfunc = zipfian(sizeKeySpace, sizeKeySpace*2, keyDisttribution)
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
        let keyfunc;
        switch(this.workerIndex) {
            case 0:
            case 5:
                keyfunc = zipfian(10000, 10300, keyDisttribution)
                break;
            case 1:
            case 6:
                keyfunc = zipfian(12001, 12300, keyDisttribution)
                break;
            case 2:
            case 7:
                keyfunc = zipfian(14001, 14300, keyDisttribution)
                break;
            case 3:
            case 8:
                keyfunc = zipfian(16001, 16300, keyDisttribution)
                break;
            case 4:
            case 9:
                keyfunc = zipfian(18001, 18300, keyDisttribution)
                break;
            default:
                keyfunc = zipfian(10000, 10300, keyDisttribution)
                break;
        }
        
        let key = keyfunc()
        contractArguments[0] = key.toString()
        contractArguments[1] = (key * constantMultiplier).toString()
        contractArguments[2] = (this.workerIndex).toString()
        var quotedAndCommaSeparated = '[' + "\"" + contractArguments.join("\",\"") + "\"" + ']';
        let client =  'client' + '0' + '.org1' + '.example.com'
        if (this.workerIndex < 5) {
            client =  'client' + this.workerIndex + '.org1' + '.example.com'
            //1 second delay for clients of org1
            //await Sleep(2000);
        }
        else  {
            client = 'client' + this.workerIndex + '.org2' + '.example.com'
            contractFunction = 'FuncCompute'
            //1 second delay for clients of org2
            //await Sleep(5000);
        }
        
        //console.log(" Worker: ", this.workerIndex, "Client: ", client)
        //console.log(" Worker: ", this.workerIndex, "Transaction: ", this.txIndex)

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

