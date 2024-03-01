package main

import (
	"encoding/json"
	"fmt"
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

// func (s *SmartContract) SwitchContractLogic(ctx contractapi.TransactionContextInterface, args []string) error {

// 	value, _ := ctx.GetStub().GetState(args[0])
// 	var asset Asset
// 	json.Unmarshal(value, &asset)
	
// 	playCountIterator, err := ctx.GetStub().GetStateByPartialCompositeKey("varName~op~value~txID", []string{args[0]})
// 	if err != nil {
// 		return err
// 	}
// 	defer playCountIterator.Close()
// 	playCount, _ := strconv.Atoi(asset.PlayCount)
// 	for playCountIterator.HasNext() {
// 		responseRange, _ := playCountIterator.Next()
// 		_, compositeKeyParts, _ := ctx.GetStub().SplitCompositeKey(responseRange.Key)
// 		if len(compositeKeyParts) > 1 {
// 			value, _ := strconv.Atoi(compositeKeyParts[2])
// 			playCount += value
// 			ctx.GetStub().DelState(responseRange.Key)
// 		}
// 	}
	
// 	totalRevenue := playCount * 10
// 	asset.TotalRevenue = strconv.Itoa(totalRevenue)
// 	asset.PlayCount = strconv.Itoa(playCount)
// 	assetBytes, _ := json.Marshal(asset)
// 	ctx.GetStub().PutState(args[0], assetBytes)
// 	return nil
	
// }


func (s *SmartContract) UpdatePlayCount(ctx contractapi.TransactionContextInterface, args []string) error {
	// if args[3] == "1" {
	// 	s.SwitchContractLogic(ctx, args)
	// }
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

	playCountIterator, err := ctx.GetStub().GetStateByPartialCompositeKey("varName~op~value~txID", []string{args[0]})

	if err == nil {
		defer playCountIterator.Close()
		playCount, _ := strconv.Atoi(asset.PlayCount)
	
		for playCountIterator.HasNext() {
			responseRange, _ := playCountIterator.Next()
			_, compositeKeyParts, _ := ctx.GetStub().SplitCompositeKey(responseRange.Key)
			if len(compositeKeyParts) > 1 {
				value, _ := strconv.Atoi(compositeKeyParts[2])
				playCount += value
				ctx.GetStub().DelState(responseRange.Key)
			}
		}
	
		totalRevenue := playCount * 10
		asset.TotalRevenue = strconv.Itoa(totalRevenue)
		asset.PlayCount = strconv.Itoa(playCount)
		assetBytes, _ := json.Marshal(asset)
		ctx.GetStub().PutState(args[0], assetBytes)
	} else {
		playCount, _ := strconv.Atoi(asset.PlayCount)
		totalRevenue := playCount * 10
		asset.TotalRevenue = strconv.Itoa(totalRevenue)
		assetBytes, _ := json.Marshal(asset)
		ctx.GetStub().PutState(args[0], assetBytes)
	}


	return nil
}



// func (s *SmartContract) CalculateRevenue(ctx contractapi.TransactionContextInterface, args []string) error {
// 	if args[3] == "1" {
// 		s.SwitchContractLogic(ctx, args)
// 	}
// 	if args[2] == "0" {
// 		value, _ := ctx.GetStub().GetState(args[0])
// 		var asset Asset
// 		json.Unmarshal(value, &asset)
// 		playCount, _ := strconv.Atoi(asset.PlayCount)
// 		totalRevenue := playCount * 10
// 		asset.TotalRevenue = strconv.Itoa(totalRevenue)
// 		assetBytes, _ := json.Marshal(asset)
// 		ctx.GetStub().PutState(args[0], assetBytes)
// 	}	else { //CalculateRevenueDelta
// 		value, _ := ctx.GetStub().GetState(args[0])
// 		var asset Asset
// 		json.Unmarshal(value, &asset)
	
// 		playCountIterator, err := ctx.GetStub().GetStateByPartialCompositeKey("varName~op~value~txID", []string{args[0]})
// 		if err != nil {
// 			return err
// 		}
// 		defer playCountIterator.Close()
// 		playCount, _ := strconv.Atoi(asset.PlayCount)
	
// 		for playCountIterator.HasNext() {
// 			responseRange, _ := playCountIterator.Next()
// 			_, compositeKeyParts, _ := ctx.GetStub().SplitCompositeKey(responseRange.Key)
// 			if len(compositeKeyParts) > 1 {
// 				value, _ := strconv.Atoi(compositeKeyParts[2])
// 				playCount += value
// 				ctx.GetStub().DelState(responseRange.Key)
// 			}
// 		}
	
// 		totalRevenue := playCount * 10
// 		asset.TotalRevenue = strconv.Itoa(totalRevenue)
// 		asset.PlayCount = strconv.Itoa(playCount)
// 		assetBytes, _ := json.Marshal(asset)
// 		ctx.GetStub().PutState(args[0], assetBytes)
// 	}

// 	return nil
// }


