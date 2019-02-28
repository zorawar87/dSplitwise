// =============================================================================
//                                      UI 
// =============================================================================
function timeConverter(UNIX_timestamp){
  if (UNIX_timestamp === null) return "none, no pending debits";
  var a = new Date(UNIX_timestamp * 1000);
  return a.toLocaleString("en-US");
}


/**
 * helper methods
 */
// this section rewrittes project starter code, but sustains core functionality
function updateUserInfo(){
    $("#total_owed").html("$"+getTotalOwed(web3.eth.defaultAccount));
    $("#last_active").html(timeConverter(getLastActive(web3.eth.defaultAccount)))
}


// This code updates the 'Users' list in the UI with the results of your function
function updateActiveUsers(){
    $("#all_users").html(getUsers().map(function (u,i) { return "<li>"+u+"</li>" }));
}

/**
 * event listeners
 */
$("#myaccount").change(function() {
    web3.eth.defaultAccount = $(this).val();
    updateUserInfo();
});


$("#addiou").click(function() {
  add_IOU($("#creditor").val(), $("#amount").val());
  updateUserInfo();
  updateActiveUsers();
});

/**
 * execution
 */

// Allows switching between accounts in 'My Account' 
// and the 'fast-copy' in 'Address of person you owe
var opts = web3.eth.accounts.map(function (a) { return '<option value="'+a+'">'+a+'</option>' })
$(".account").html(opts);
$(".wallet_addresses").html(web3.eth.accounts.map(function (a) { return '<li>'+a+'</li>' }))

updateUserInfo();
updateActiveUsers();
