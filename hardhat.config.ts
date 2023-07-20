import '@nomiclabs/hardhat-waffle'
import '@nomiclabs/hardhat-etherscan'
import '@nomiclabs/hardhat-ethers'
import '@typechain/hardhat'
import 'dotenv/config'
import 'hardhat-deploy'
import 'hardhat-gas-reporter'
import 'solidity-coverage'

import { CustomHardhatConfig } from './models/custom-hardhat-config.model'

require('dotenv').config()

const { COINMARKETCAP_API_KEY, POLYGONSCAN_API_KEY, PRIVATE_KEY } = process.env

const defaultNetwork = 'mumbai' // change the defaul network if you want to deploy onchain      0         bg
const config: CustomHardhatConfig = {
	defaultNetwork,
	networks: {
		hardhat: {
			chainId: 1337,
			allowUnlimitedContractSize: true
		},
		localhost: {
			chainId: 1337,
			allowUnlimitedContractSize: true
		},
		mumbai: {
			chainId: 80001,
			accounts: [PRIVATE_KEY || ''],
			url: 'https://rpc-mumbai.maticvigil.com',
			gas: 6000000, // Increase the gas limit
			gasPrice: 10000000000 // Set a custom gas price (in Gwei, optional)
		},
		coverage: {
			url: 'http://127.0.0.1:8555' // Coverage launches its own ganache-cli client
		}
	},
	etherscan: {
		apiKey: POLYGONSCAN_API_KEY
	},
	gasReporter: {
		enabled: true,
		currency: 'USD',
		outputFile: 'gas-report.txt',
		excludeContracts: ['Migrations'], // Exclude specific contracts if needed
		src: './contracts' // Directory containing the contracts
	},
	namedAccounts: {
		deployer: {
			default: 0,
			1: 0
		}
	},
	solidity: {
		version: '0.8.17',
		settings: {
			optimizer: {
				enabled: true,
				runs: 200,
				details: { yul: false }
			}
		}
	},
	mocha: {
		timeout: 200000
	}
}

export default config
