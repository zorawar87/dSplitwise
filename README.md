# Deliverables 
1. [Write Up](moolenaar-project-submission.pdf)
2. [Release](dSplitwise.tgz)

# DecentralisedSplitwise #
Extends the [Programming Project 3, CS251 Stanford Cryptocurrencies and Blockchain Technologies](http://cs251crypto.stanford.edu/18au-cs251/hw/proj3.pdf)

Splitwise is an application that allows users to collect and resolve owed money ("IOUs")
amongst each other. DecentralisedSplitwise is its decentralised version, through which
users can resolve owed money without any central authority.

## Prerequisites ##
Node.js & npm --- [Available here](https://nodejs.org/en/download/) or through a package manager

## Setup ##
1. Extract the files `tar -xf dSplitwise.tgz`
2. `cd dSplitwise && npm install ganache-cli && ln -s node_modules/.bin/ganache-cli .` The npm installation will cause a lot of output. Believe it or not, it's not malware.
3. In a separet terminal run `./ganache-cli`, and make sure it is listening on `localhost:8545` (default)
4. Navigate to <https://remix.ethereum.org> in a browser.
5. On the top left, click the folder icon and upload `dSplitwise/contracts/*.sol`
6. Click on `Splitwise.sol` in the left panel, and then compile using the right panel.
7. Stil in the Remix window, navigate to the "Run" tab on the right.
8. On the right, in "Environment", choose "Web3 Provider". Hit ok on the dialog box, and accept the default URL "https://localhost:8545". If any issues, make sure that ganache is running.
9. Right below, Select "Splitwise" and hit "Deploy". (Ensure, it's Splitwise, not TransferHandler or SplitwiseSpec)
10. On the bottom right, a contract should be deployed. Copy its address using the clipboard icon.
11. Paste this address in "dSplitwise/config.js" at contractAddress.
12. Finally, in a new browser window, open "dSplitwise/index.html"
13. the application *should* be ready :) 
14. Everytime the ganache server is shut down, or a new contract is deployed using Remix, the address **must** be changed in `config.js`. If solidity code is changed, then the ABI JSON value needs to be changed as well, which is an additional out of scope step.
