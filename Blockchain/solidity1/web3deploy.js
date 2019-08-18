var messageContract = web3.eth.contract([{"constant":true,"inputs":[],"name":"getLines","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"name":"_lines","type":"uint256"}],"name":"setLines","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"lines","outputs":[{"name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"}]);

var message = messageContract.new(
   {
     from: web3.eth.accounts[0], 
     data: '0x608060405234801561001057600080fd5b5061011e806100206000396000f3fe608060405260043610604d576000357c010000000000000000000000000000000000000000000000000000000090048063788b5456146052578063b2edd58d14607a578063d14082cc1460b1575b600080fd5b348015605d57600080fd5b50606460d9565b6040518082815260200191505060405180910390f35b348015608557600080fd5b5060af60048036036020811015609a57600080fd5b810190808035906020019092919050505060e2565b005b34801560bc57600080fd5b5060c360ec565b6040518082815260200191505060405180910390f35b60008054905090565b8060008190555050565b6000548156fea165627a7a7230582083856bf7d153baff8dbb09e0dd1852353ad86a07b74619adade8dc9b5c23512f0029', 
     gas: '4700000'
   }, function (e, contract){
    console.log(e, contract);
    if (typeof contract.address !== 'undefined') {
         console.log('Contract mined! address: ' + contract.address + ' transactionHash: ' + contract.transactionHash);
    }
 })