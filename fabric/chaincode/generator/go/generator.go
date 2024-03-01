package main

import (
	"encoding/json"
	"fmt"
	"time"
	"github.com/hyperledger/fabric-contract-api-go/contractapi"
	"strconv"
)

type SmartContract struct {
        contractapi.Contract
}

type Asset struct {
	DocType        string `json:"docType"` //docType is used to distinguish the various types of objects in state database
	ID             string `json:"ID"`      //the field tags are needed to keep case from bouncing around
	PlayCount          string `json:"playCount"`
	TotalRevenue           string    `json:"totalRevenue"`
}


func main() {

        // Create a new Smart Contract
        chaincode, err := contractapi.NewChaincode(new(SmartContract))
        if err != nil {
                fmt.Printf("Error creating new Smart Contract: %s", err)
        }
        if err := chaincode.Start(); err != nil {
                fmt.Printf("Error starting chaincode: %s", err.Error())
        }

}

func (s *SmartContract) Init(ctx contractapi.TransactionContextInterface) error {
	return nil
}


func (s *SmartContract) InitLedger(ctx contractapi.TransactionContextInterface, arg0 string, arg1 string) error {
	asset := &Asset{
		DocType:        "asset",
		ID:             arg0,
		PlayCount:          arg1,
		TotalRevenue:           "0",
	}
	jvalue, _ := json.Marshal(asset)

	ctx.GetStub().PutState(arg0, jvalue)

	return nil

}

func (s *SmartContract) DoNothing(ctx contractapi.TransactionContextInterface)  error {
	return nil
}

func (s *SmartContract) UpdatePlayCount(ctx contractapi.TransactionContextInterface, args []string) error {
	if args[2] == "0" {
		value, _ := ctx.GetStub().GetState(args[0])
		var asset Asset
		json.Unmarshal(value, &asset)
		asset.PlayCount = args[1]
		assetBytes, _ := json.Marshal(asset)
		ctx.GetStub().PutState(args[0], assetBytes)
	}	else { 	// UpdatePlayCountDelta
		name := args[0]
		op := "+"
		increment := strconv.Itoa(1)
		txid := ctx.GetStub().GetTxID()
		compositeIndexName := "varName~op~value~txID"
		value := []string{name, op, increment, txid}
		compositeKey, _ := ctx.GetStub().CreateCompositeKey(compositeIndexName, value)
		nullvalue := []byte{0x00}
		ctx.GetStub().PutState(compositeKey, nullvalue)
	}
	
	return nil
}


func (s *SmartContract) CalculateRevenue(ctx contractapi.TransactionContextInterface, args []string) error {
	value, _ := ctx.GetStub().GetState(args[0])
	var asset Asset
	json.Unmarshal(value, &asset)

	//Delay to simulate reading all play count increment keys
	time.Sleep(10 * time.Millisecond)

	playCount, _ := strconv.Atoi(asset.PlayCount)
	playCount += 10
	totalRevenue := playCount * 10
	asset.TotalRevenue = strconv.Itoa(totalRevenue)
	asset.PlayCount = strconv.Itoa(playCount)
	assetBytes, _ := json.Marshal(asset)
	ctx.GetStub().PutState(args[0], assetBytes)


	return nil
}




