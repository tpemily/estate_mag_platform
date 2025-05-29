# Estate Mag Platform 🏢

A decentralized real estate tokenization platform built on the Stacks blockchain using Clarity smart contracts. Estate Mag enables fractional ownership of real estate properties through tokenization, automated rent distribution, and transparent property management.

## 🌟 Features

### Core Functionality
- **🪙 Token Management**: Mint and transfer estate tokens representing fractional ownership
- **💰 Rent Distribution**: Automated collection and distribution of rental income to token holders
- **🔧 Maintenance Logging**: Transparent tracking of property maintenance activities
- **🔐 Access Control**: Manager-only functions with comprehensive authorization
- **📊 Data Queries**: Read-only functions for all contract state information

### Smart Contract Capabilities
- **Token Transfer**: Secure peer-to-peer token transfers with validation
- **Minting System**: Manager-controlled token creation with supply limits
- **Rent Management**: Deposit rental income and distribute to investors
- **Maintenance Records**: Immutable logging of property maintenance activities
- **Balance Tracking**: Real-time token balance queries for all accounts

## 🏗️ Architecture

### Smart Contract Structure
```
contracts/
└── estate_mag.clar          # Main smart contract (98 lines)
    ├── Token Management      # Transfer, mint, balance tracking
    ├── Rent Distribution     # Deposit and distribute rental income
    ├── Maintenance Logging   # Property maintenance records
    ├── Access Control        # Manager authorization
    └── Data Queries          # Read-only state functions
```

### Key Components
- **Balances Map**: Tracks token ownership across all accounts
- **Rent Variables**: Manages collected and distributed rental income
- **Maintenance Log**: Immutable record of property maintenance
- **Error Handling**: Comprehensive error constants and validation

## 🚀 Getting Started

### Prerequisites
- [Clarinet](https://docs.hiro.so/clarinet) - Stacks smart contract development tool
- [Node.js](https://nodejs.org/) (for testing)
- [Git](https://git-scm.com/)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/tpemily/estate_mag_platform.git
   cd estate_mag_platform
   ```

2. **Install dependencies**
   ```bash
   npm install
   ```

3. **Verify smart contract**
   ```bash
   clarinet check
   ```

### Quick Start

1. **Check contract syntax**
   ```bash
   clarinet check
   ```

2. **Run interactive console**
   ```bash
   clarinet console
   ```

3. **Test basic functions**
   ```clarity
   ;; Get contract manager
   (contract-call? .estate_mag get-manager)
   
   ;; Mint tokens to an address
   (contract-call? .estate_mag mint-tokens 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 u1000)
   
   ;; Check balance
   (contract-call? .estate_mag get-balance 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5)
   ```

## 📋 Smart Contract Functions

### Public Functions

#### Token Management
- `transfer(to: principal, amount: uint)` - Transfer tokens between accounts
- `mint-tokens(recipient: principal, amount: uint)` - Mint new tokens (manager only)

#### Rent Management  
- `deposit-rent(amount: uint)` - Deposit rental income (manager only)
- `distribute-rent()` - Distribute collected rent (manager only)

#### Maintenance
- `add-maintenance-log(description: string-ascii)` - Log maintenance activity (manager only)

### Read-Only Functions
- `get-balance(account: principal)` - Get token balance for account
- `get-total-rent-collected()` - Get total rent currently collected
- `get-total-distributed()` - Get total rent distributed historically
- `get-manager()` - Get the manager's address
- `get-maintenance-log(log-id: uint)` - Get maintenance log entry
- `get-log-counter()` - Get current maintenance log counter

## 🧪 Testing

### Run Tests
```bash
npm test
```

### Manual Testing with Clarinet Console
```bash
clarinet console
```

Example test sequence:
```clarity
;; 1. Check initial state
(contract-call? .estate_mag get-manager)
(contract-call? .estate_mag get-total-rent-collected)

;; 2. Mint tokens
(contract-call? .estate_mag mint-tokens 'ST1SJ3DTE5DN7X54YDH5D64R3BCB6A2AG2ZQ8YPD5 u1000)

;; 3. Transfer tokens
(contract-call? .estate_mag transfer 'ST2CY5V39NHDPWSXMW9QDT3HC3GD6Q6XX4CFRK9AG u500)

;; 4. Deposit and distribute rent
(contract-call? .estate_mag deposit-rent u10000)
(contract-call? .estate_mag distribute-rent)

;; 5. Add maintenance log
(contract-call? .estate_mag add-maintenance-log "HVAC system maintenance completed")
```

## 🔧 Configuration

### Clarinet.toml
The project uses Clarity version 3 with epoch 3.1 for optimal compatibility.

### Network Settings
- **Devnet**: Local development environment
- **Testnet**: Stacks testnet deployment
- **Mainnet**: Production deployment

## 📊 Contract Constants

- **Token Decimals**: 6
- **Total Supply**: 1,000,000 tokens maximum
- **Error Codes**:
  - `u401`: Unauthorized access
  - `u402`: Insufficient balance
  - `u403`: Invalid amount

## 🛡️ Security Features

- **Access Control**: Manager-only functions with strict authorization
- **Overflow Protection**: Safe arithmetic operations with bounds checking
- **Input Validation**: Comprehensive parameter validation
- **Error Handling**: Detailed error codes and messages
- **Supply Limits**: Maximum token supply enforcement

## 🚀 Deployment

### Local Development
```bash
clarinet integrate
```

### Testnet Deployment
```bash
clarinet deploy --testnet
```

### Mainnet Deployment
```bash
clarinet deploy --mainnet
```

## 📈 Roadmap

- [ ] **Phase 1**: Core tokenization and rent distribution ✅
- [ ] **Phase 2**: Multi-property support
- [ ] **Phase 3**: Governance mechanisms
- [ ] **Phase 4**: Integration with DeFi protocols
- [ ] **Phase 5**: Mobile application interface

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/amazing-feature`)
3. Commit your changes (`git commit -m 'Add amazing feature'`)
4. Push to the branch (`git push origin feature/amazing-feature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🔗 Links

- **Repository**: https://github.com/tpemily/estate_mag_platform
- **Stacks Documentation**: https://docs.stacks.co/
- **Clarinet Documentation**: https://docs.hiro.so/clarinet
- **Clarity Language**: https://docs.stacks.co/clarity

## 📞 Support

For questions and support, please open an issue in the GitHub repository.

---

**Built with ❤️ on Stacks blockchain**
