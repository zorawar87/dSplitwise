pragma solidity ^0.5;

contract TransferHandler {
    struct Transfer {
        uint id;
        address debtor;
        address creditor;
        uint amount;
        bool isSettled;
        uint time;
    }
    
    mapping (uint => Transfer) public Transfers;
    mapping (address => uint[]) public debitTransfers;
    
    uint public lastTxId = 0;
    
    function getTransferCount(address _debtor) 
        public 
        view 
        returns (uint)
    {
        return debitTransfers[_debtor].length;
    }
    
    function getHistory(address _debtor, address _creditor) 
        public 
        view 
        returns (uint)
    {
        uint[] memory relevantTfs = debitTransfers[_debtor];
        for (uint i = 0; i < relevantTfs.length; i++){
            if (Transfers[relevantTfs[i]].creditor == _creditor) {
                return Transfers[relevantTfs[i]].id;
            }
        }
        return 0;
    }
    
    function modify(uint id, uint amountToReduce) public {
        Transfers[id].amount -= amountToReduce;
        if (Transfers[id].amount == 0){
            Transfers[id].isSettled = true;
        }
    }
       
    function add(address _debtor, address _creditor, uint _amount) external {
        lastTxId++;
        Transfer memory t = Transfer({
            id: lastTxId,
            debtor: _debtor,
            creditor: _creditor,
            amount: _amount,
            isSettled: false,
            time: now
        });
        Transfers[lastTxId] = t;
        debitTransfers[_debtor].push(lastTxId);
    }
    
    function update(uint id, uint _amount) external {
        Transfers[id].amount += _amount;
        Transfers[id].isSettled = false;
    }
    
    
    /**
     *  Transfer Struct Accessors
     */
    function getDebtorFor(uint id) 
        external 
        view 
        returns (address)
    {
        return Transfers[id].debtor;
    }
    
    function getCreditorFor(uint id) 
        external 
        view 
        returns (address)
    {
        return Transfers[id].creditor;
    }
    
    function getAmountFor(uint id) 
        external 
        view 
        returns (uint)
    {
        return Transfers[id].amount;
    }
    
    function isSettled(uint id) 
        external 
        view 
        returns (bool)
    {
        return Transfers[id].isSettled;
    }
    
    function getTimeOfTransfer(uint id) 
        external 
        view 
        returns (uint)
    {
        return Transfers[id].time;
    }
    
    /**
     *  DebitTransfer Accessors
     */
    function getIthDebit(address _user, uint _index) 
        external 
        view 
        returns (uint)
    {
        return debitTransfers[_user][_index];
    }
}

