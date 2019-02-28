pragma solidity ^0.5;

import "./TransferHandler.sol";
import "./SplitwiseSpec.sol";

// minimise amount of storage and compuations done by core functions
contract Splitwise is SplitwiseSpec {
    
    TransferHandler transferHandler;
    
    constructor() public {
        transferHandler = new TransferHandler();
    }
    
    // returns the amount that the debtor owes the creditor
    function lookup(address _debtor, address _creditor)
        public
        view
        returns (uint)
    {
        uint id = transferHandler.getHistory(_debtor, _creditor);
        if (id == 0 || transferHandler.isSettled(id)){
            return 0;
        }
        return transferHandler.getAmountFor(id);
    }
    
    // msg.sender promises to owe _amount money _creditor 
    function add_IOU(address _creditor, uint _amount)
        public
        validCreditor(_creditor)
    {
        bool isNew = true;
        uint id = transferHandler.getHistory(msg.sender, _creditor);
        if (id == 0) {
            transferHandler.add(msg.sender, _creditor, _amount);
        } else {
            isNew = false;
            transferHandler.update(id, _amount);
        }
        
        emit TransferProcessed(id, isNew,
            msg.sender, _creditor, transferHandler.getAmountFor(id));
    }
    
    function modify_IOU(uint id, uint _amountToReduce) public {
        require(id > 0, "zero is an invalid transfer id!");
        require(_amountToReduce > 0, "reducing by zero is a waste of gas!");
        require(_amountToReduce <= transferHandler.getAmountFor(id), "amountToReduce must be the minimum of a cycle!");
        transferHandler.modify(id, _amountToReduce);
        emit TransferProcessed(id, false,
            transferHandler.getDebtorFor(id), transferHandler.getCreditorFor(id), transferHandler.getAmountFor(id));
    }
    
    /**
     * Web3 API Functionality
     */
     
    function getLastTransferIndex()
        external
        view
        returns (uint)
    {
        return transferHandler.lastTxId();
    }
    
    function getIthDebit(address _user, uint _index)
        external
        view
        returns (uint)
    {
        return transferHandler.debitTransfers(_user, _index);
    }
    
    function getHistory(address _debtor, address _creditor)
        external
        view
        returns (uint)
    {
        return transferHandler.getHistory(_debtor, _creditor);
    }
     
    // gets transfer count for a given user                                                                                                                                                                         
    function getDebitCount(address _user)
        external
        view
        returns (uint)
    {
        return transferHandler.getTransferCount(_user);
    }

    // Struct Accessors
    function getDebtorFor(uint id)
        external
        view
        returns (address)
    {
        return transferHandler.getDebtorFor(id);
    }

    function getCreditorFor(uint id)
        external
        view
        returns (address)
    {
        return transferHandler.getCreditorFor(id);
    }

    function getAmountFor(uint id)
        external
        view
        returns (uint)
    {
        return transferHandler.getAmountFor(id);
    }

    function isSettled(uint id)
        external
        view
        returns (bool)
    {
        return transferHandler.isSettled(id);
    }

    function getTimeOfTransfer(uint id)
        external
        view
        returns (uint)
    {
        return transferHandler.getTimeOfTransfer(id);
    }
}
