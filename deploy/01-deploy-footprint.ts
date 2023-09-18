import { HardhatRuntimeEnvironment } from 'hardhat/types'
import { DeployFunction } from 'hardhat-deploy/types'
import { developmentChains, networkConfig } from '../helper-hardhat-config'
import verify from '../helper-functions'

const deployMeetdAppFactory: DeployFunction = async function (
	hre: HardhatRuntimeEnvironment
) {
	// @ts-ignore
	const { getNamedAccounts, deployments, network } = hre
	const { deploy, log } = deployments
	const { deployer } = await getNamedAccounts()

	log('----------------------------------------------------')
	log('Deploying MeetdAppFactory contract and waiting for confirmations...')

	const args: any[] = []

	const MeetdAppContract = await deploy('MeetdAppFactory', {
		from: deployer,
		args: args,
		log: true,
		waitConfirmations: networkConfig[network.name].blockConfirmations || 1
	})
	if (
		!developmentChains.includes(network.name) &&
		(process.env.CELOSCAN_API_KEY || process.env.POLYGONSCAN_API_KEY)
	) {
		await verify(MeetdAppContract.address, args)
	}
}

export default deployMeetdAppFactory
deployMeetdAppFactory.tags = ['all', 'MeetdAppFactory']
