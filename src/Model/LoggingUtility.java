package Model;

import java.io.IOException;
import java.util.logging.FileHandler;
import java.util.logging.Logger;
import java.util.logging.SimpleFormatter;

public class LoggingUtility {

	// Define a static Logger
	private static final Logger logger = Logger.getLogger("MyAppLogger");

	static {
		try {
			// Create a FileHandler to write logs to a file
			FileHandler fileHandler = new FileHandler("D:\\Aurionpro\\BankApplication\\src\\logs\\test.log", true); // true
																													// for
																													// appending

			// Create a SimpleFormatter to format the log messages
			SimpleFormatter formatter = new SimpleFormatter();
			fileHandler.setFormatter(formatter);
			System.out.println("logger testing");
			// Add the FileHandler to the logger
			logger.addHandler(fileHandler);

			// Optional: Set the log level (INFO, WARNING, SEVERE, etc.)
			logger.setLevel(java.util.logging.Level.INFO);

		} catch (IOException e) {
			logger.severe("Failed to setup logger handler: " + e.getMessage());
		}
	}

	public static Logger getLogger() {
		return logger;
	}
}
