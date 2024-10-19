class BankAccount {
  final String name;
  double balance;
  final String accountOwner;
  final int accountId;

  BankAccount(
      {required this.name,
      required this.accountOwner,
      required this.accountId,
      this.balance = 0});

  void currentBalance() {
    print("Balance: \$$balance");
  }

  double withdraw(double amount) {
    if (amount > balance) {
      throw Exception("Insufficient balance for withdrawal!");
    }
    balance -= amount;
    return balance;
  }

  double credit(double amount) {
    balance += amount;
    return balance;
  }
}

class Bank {
  final List<BankAccount> accounts = [];
  final String name;

  Bank({required this.name});

  BankAccount createAccount(int accountId, String accountOwner) {
    if (accounts.any((account) => account.accountId == accountId)) {
      throw Exception("Account with ID $accountId already exists!");
    }
    BankAccount newAccount = BankAccount(
        name: name, accountOwner: accountOwner, accountId: accountId);
    accounts.add(newAccount);
    return newAccount;
  }
}

void main() {
  Bank myBank = Bank(name: "CADT Bank");
  BankAccount ronanAccount = myBank.createAccount(100, 'Ronan');

  ronanAccount.currentBalance();
  ronanAccount.credit(100);
  ronanAccount.currentBalance();
  ronanAccount.withdraw(50);
  ronanAccount.currentBalance();

  try {
    ronanAccount.withdraw(75); // This will throw an exception
  } catch (e) {
    print(e); // Output: Insufficient balance for withdrawal!
  }

  try {
    myBank.createAccount(100, 'Honlgy'); // This will throw an exception
  } catch (e) {
    print(e); // Output: Account with ID 100 already exists!
  }
}
