package Model;



import java.math.BigDecimal;
import java.sql.Timestamp;

public class Transaction {
	private String senderAccountNumber;
	private String receiverAccountNumber;
	private String transactionType;
	private BigDecimal amount;
	private Timestamp transactionDate;

	public Transaction(String senderAccountNumber, String receiverAccountNumber, String transactionType,
			BigDecimal amount, Timestamp transactionDate) {
		this.senderAccountNumber = senderAccountNumber;
		this.receiverAccountNumber = receiverAccountNumber;
		this.transactionType = transactionType;
		this.amount = amount;
		this.transactionDate = transactionDate;
	}

	// Getters and Setters
	public String getSenderAccountNumber() {
		return senderAccountNumber;
	}

	public void setSenderAccountNumber(String senderAccountNumber) {
		this.senderAccountNumber = senderAccountNumber;
	}

	public String getReceiverAccountNumber() {
		return receiverAccountNumber;
	}

	public void setReceiverAccountNumber(String receiverAccountNumber) {
		this.receiverAccountNumber = receiverAccountNumber;
	}

	public String getTransactionType() {
		return transactionType;
	}

	public void setTransactionType(String transactionType) {
		this.transactionType = transactionType;
	}

	public BigDecimal getAmount() {
		return amount;
	}

	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}

	public Timestamp getTransactionDate() {
		return transactionDate;
	}

	public void setTransactionDate(Timestamp transactionDate) {
		this.transactionDate = transactionDate;
	}

	@Override
	public String toString() {
		return "Transaction [senderAccountNumber=" + senderAccountNumber + ", receiverAccountNumber="
				+ receiverAccountNumber + ", transactionType=" + transactionType + ", amount=" + amount
				+ ", transactionDate=" + transactionDate + "]";
	}
	
}
