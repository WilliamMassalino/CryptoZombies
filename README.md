# Zombie Factory Solidity Project

Welcome to the Zombie Factory repository, a blockchain-based project where users can generate and manage their own unique zombies through Ethereum smart contracts. This project utilizes Solidity version 0.4.19 and has been developed in the Remix IDE, an open-source web and desktop application that facilitates the writing, testing, and deploying of smart contracts.
This code was based on the cryptoZombies course - Solidity: Beginner to Intermediate Smart Contracts: https://cryptozombies.io/en/course

## Project Overview

The Zombie Factory project consists of a series of interconnected smart contracts that handle various aspects of zombie creation, feeding, battling, and trading. Here’s a brief outline of each contract and its purpose:

- **ZombieFactory.sol**: The foundational contract for zombie creation. It defines the properties of a zombie and allows for the creation of a zombie with random DNA.
- **ZombieFeeding.sol**: Extends ZombieFactory to include feeding mechanisms where zombies can feed on other creatures, like kitties (from the CryptoKitties universe), to evolve.
- **ZombieHelper.sol**: Provides additional helper functions for zombies, such as leveling up and changing names after certain conditions are met.
- **ZombieAttack.sol**: Introduces a battle system where zombies can attack each other, affecting their win/loss record and leveling up.
- **ZombieOwnership.sol**: Implements the ERC721 standard to allow zombies to be traded like tokens on the Ethereum network.
- **SafeMath.sol**: A library used to perform arithmetic operations safely.
- **Ownable.sol**: A contract that provides basic authorization control functions, simplifying the implementation of user permissions and ownership.

## Development Environment

This project was developed using the Remix IDE, which is an excellent choice for Solidity development due to its real-time compiler, quick access to deployed contracts, and integrated debugging tools.

## How to Set Up and Run the Project

- **Access Remix IDE**: Go to [Remix IDE](https://remix.ethereum.org) and create a new workspace.
- **Clone Repository**: Clone this repository into your workspace. You can copy and paste the smart contract codes into new files within Remix.
- **Compile Contracts**: Use Remix's Solidity compiler to compile the contracts. Ensure that you select the correct compiler version (0.4.19).
- **Deploy Contracts**: Deploy the contracts on the JavaScript VM or on a testnet such as Rinkeby or Ropsten. Make sure to deploy ZombieFactory first, followed by the other contracts, linking them as necessary.
- **Interact with Contracts**: Use Remix's built-in transaction environment to interact with the deployed contracts.

## Future Ideas

While the current implementation covers basic functionalities of zombie management, several enhancements and features can be considered for future development:

- **Upgradable Contracts**: Implementing proxy contracts or using a tool like OpenZeppelin's upgrades plugin to make the contracts upgradable without losing state.
- **Gas Optimization**: Further optimize contract functions to reduce gas costs, potentially by refining storage and memory usage.
- **Frontend Integration**: Develop a user-friendly frontend using frameworks like React.js to interact with the contracts, making the project accessible to non-technical users.
- **Additional Creatures**: Besides kitties, introduce other creatures for zombies to interact with, possibly creating a cross-platform ecosystem.
- **Governance Mechanism**: Implement a DAO for decision-making processes, such as feature updates or parameter adjustments based on community votes.
- **More Detailed Battle Logic**: Enhance the battle system with more complex game mechanics, including attributes like strength, agility, and intelligence.

## Contributions

Contributions are welcome! If you have ideas for improvements or have found a bug, please open an issue or submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE.md file for details.
