package Model;

public class Account {
	private int accountId;
	private String accountNumber;
	private int customerId;
	private double balance;

	public Account() {
		super();
		this.accountId = accountId;
		this.accountNumber = accountNumber;
		this.customerId = customerId;
		this.balance = balance;
	}

	public int getAccountId() {
		return accountId;
	}

	public void setAccountId(int accountId) {
		this.accountId = accountId;
	}

	public String getAccountNumber() {
		return accountNumber;
	}

	public void setAccountNumber(String accountNumber) {
		this.accountNumber = accountNumber;
	}

	public int getCustomerId() {
		return customerId;
	}

	public void setCustomerId(int customerId) {
		this.customerId = customerId;
	}

	public double getBalance() {
		return balance;
	}

	public void setBalance(double balance) {
		this.balance = balance;
	}

	@Override
	public String toString() {
		return "Account [accountId=" + accountId + ", accountNumber=" + accountNumber + ", customerId=" + customerId
				+ ", balance=" + balance + "]";
	}

}
