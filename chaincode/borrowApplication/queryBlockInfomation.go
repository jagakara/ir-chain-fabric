package main

import (
	"fmt"

	"github.com/hyperledger/fabric/core/chaincode/shim"
	sc "github.com/hyperledger/fabric/protos/peer"
)

// SmartContract structure
type SmartContract struct {
}

/* MaxNumber structure
type MaxNumber struct {
	MaxApplicationNo string `json:"maxApplicationNo"`
}
*/

//Init method is called as a result of deployment "borrowApplication"
func (s *SmartContract) Init(APIstub shim.ChaincodeStubInterface) sc.Response {
	return shim.Success(nil)
}

//Invoke method is called as a result of an application request to run the Smart Contract "borrowApplication"
func (s *SmartContract) Invoke(APIstub shim.ChaincodeStubInterface) sc.Response {

	// Retrieve the requested Smart Contract function and arguments
	function, args := APIstub.GetFunctionAndParameters()
	// Route to the appropriate handler function to interact with the ledger
	if function == "queryMaxApplicationNo" {
		return s.queryMaxApplicationNo(APIstub, args)
	}
	return shim.Error("Invalid Smart Contract function name.")
}

func (s *SmartContract) queryMaxApplicationNo(APIstub shim.ChaincodeStubInterface, args []string) sc.Response {

	if len(args) != 0 {
		return shim.Error("Incorrect number of arguments. Expecting 1")
	}

	//get maxNumber of application
	maxApplicationNo, _ := APIstub.GetState("maxApplicationNo")
	return shim.Success(maxApplicationNo)
}

// The main function is only relevant in unit test mode. Only included here for completeness.
func main() {
	// Create a new Smart Contract
	err := shim.Start(new(SmartContract))
	if err != nil {
		fmt.Printf("Error creating new Smart Contract: %s", err)
	}
}
