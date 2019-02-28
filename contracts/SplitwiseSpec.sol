pragma solidity ^0.5;

// minimise amount of storage and compuations done by core functions
contract SplitwiseSpec {
    function add_IOU(address _creditor, uint _amount) public;
    function lookup(address _debtor, address _creditor) public view returns (uint);
    
    modifier validCreditor(address _user){
        require(_user != address(0), "zero address is invalid");
        require(_user != msg.sender, "cannot credit oneself");
        _;
    }
    
    event TransferProcessed(
        uint transferId,
        bool isNew,
        address debtor,
        address creditor,
        uint amount
    );
    
}
