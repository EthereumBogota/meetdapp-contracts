const { ethers } = require('hardhat')

async function transferFunds() {
	const [sender] = await ethers.getSigners()
	const receiverAddress = '0xE8e1543235e6C35C656ef0b28526C61571583f4B'

	const balance = await sender.getBalance()
	const value = ethers.utils.parseEther('3') // Cantidad que deseas transferir

	if (balance.lt(value)) {
		console.log('No tienes suficientes fondos en tu billetera de Hardhat.')
		return
	}

	const transaction = await sender.sendTransaction({
		to: receiverAddress,
		value: value
	})

	console.log('Transacción exitosa. Hash de transacción:', transaction.hash)
}

transferFunds()
	.then(() => process.exit(0))
	.catch(error => {
		console.error(error)
		process.exit(1)
	})
