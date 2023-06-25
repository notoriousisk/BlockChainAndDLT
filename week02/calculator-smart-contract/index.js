const contractAddress = '0x3160e5c911120ed64e24785fa8287c13ca8a13ec';
const contractABI = [
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "y",
				"type": "uint256"
			}
		],
		"name": "add",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "y",
				"type": "uint256"
			}
		],
		"name": "divide",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "y",
				"type": "uint256"
			}
		],
		"name": "multiply",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [
			{
				"internalType": "uint256",
				"name": "x",
				"type": "uint256"
			},
			{
				"internalType": "uint256",
				"name": "y",
				"type": "uint256"
			}
		],
		"name": "subtract",
		"outputs": [],
		"stateMutability": "nonpayable",
		"type": "function"
	},
	{
		"inputs": [],
		"name": "result",
		"outputs": [
			{
				"internalType": "uint256",
				"name": "",
				"type": "uint256"
			}
		],
		"stateMutability": "view",
		"type": "function"
	}
];


async function loadWeb3() {
    if (window.ethereum) {
        window.web3 = new Web3(window.ethereum);
        window.ethereum.enable();
        window.web3.eth.defaultAccount = '0xFEf1dCaaa2CbB5cDB157bbEA0B35b763b4a95089';
    }
}

async function load() {
    await loadWeb3();
    window.contract = await loadContract();
}

async function loadContract() {
    return await new window.web3.eth.Contract(contractABI, contractAddress);
}


function add() {
    const x = document.getElementById('x').value;
    const y = document.getElementById('y').value;

    contract.methods.add(x, y).send({ from: web3.eth.defaultAccount })
      .then(() => {
        getResult();
      })
      .catch(error => {
        console.error(error);
      });
  }

  function subtract() {
    const x = document.getElementById('x').value;
    const y = document.getElementById('y').value;

    contract.methods.subtract(x, y).send({ from: web3.eth.defaultAccount })
      .then(() => {
        getResult();
      })
      .catch(error => {
        console.error(error);
      });
  }

  function multiply() {
    const x = document.getElementById('x').value;
    const y = document.getElementById('y').value;

    contract.methods.multiply(x, y).send({ from: web3.eth.defaultAccount })
      .then(() => {
        getResult();
      })
      .catch(error => {
        console.error(error);
      });
  }

  function divide() {
    const x = document.getElementById('x').value;
    const y = document.getElementById('y').value;

    contract.methods.divide(x, y).send({ from: web3.eth.defaultAccount })
      .then(() => {
        getResult();
      })
      .catch(error => {
        console.error(error);
      });
  }

  function getResult() {
    contract.methods.result().call()
      .then(result => {
        document.getElementById('result').textContent = result;
      })
      .catch(error => {
        console.error(error);
      });
  }

  load();
