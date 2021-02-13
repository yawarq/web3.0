const HDWalletProvider = require('truffle-hdwallet-provider');
const Web3 = require('web3');
const {interface,bytecode} = require('./compile.js');

const provider = new HDWalletProvider(
    'dust tortoise people snake panda crack radio debate cigar curious member race',
    'https://rinkeby.infura.io/v3/974eef0b81ab41939afd229995812617'
);


const web3 = new Web3(provider);

const deploy = async ()=>{
    const accounts = await web3.eth.getAccounts();
    console.log(accounts);
    console.log('Contract is deployed by the manager with address', accounts[0]);

    const result = await new web3.eth.Contract(JSON.parse(interface))
    .deploy({data: '0x' + bytecode})
    .send({gas: '2000000', from: accounts[0]})

    console.log('Contract deployed to address', result.options.address);
    // 0x7A2ee58ca73bFde6De1c86FE8B352058b94D93da

}
deploy();