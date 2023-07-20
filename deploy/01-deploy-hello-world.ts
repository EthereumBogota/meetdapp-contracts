import { HardhatRuntimeEnvironment } from 'hardhat/types'
import { DeployFunction } from 'hardhat-deploy/types'
import { developmentChains, networkConfig } from '../helper-hardhat-config'
import verify from '../helper-functions'

const deployHelloWorld: DeployFunction = async function (
	hre: HardhatRuntimeEnvironment
) {
	// @ts-ignore
	const { getNamedAccounts, deployments, network } = hre
	const { deploy, log } = deployments
	const { deployer } = await getNamedAccounts()

	log('----------------------------------------------------')
	log('Deploying Hello World contract and waiting for confirmations...')

	const HelloWorldContract = await deploy('HelloWorld', {
		from: deployer,
		args: [],
		log: true,
		waitConfirmations: networkConfig[network.name].blockConfirmations || 1
	})

	if (
		!developmentChains.includes(network.name) &&
		process.env.POLYGONSCAN_API_KEY
	) {
		await verify(HelloWorldContract.address, [])
	}
}

export default deployHelloWorld
deployHelloWorld.tags = ['all', 'HelloWorld']
