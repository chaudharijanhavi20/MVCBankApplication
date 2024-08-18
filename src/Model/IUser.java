package Model;

public interface IUser {
	User validateUser(String email, String password) throws ClassNotFoundException;
}
