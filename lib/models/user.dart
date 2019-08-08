import 'package:firebase_auth/firebase_auth.dart';


class User {

	String _id;
	String _email;


	String get id => _id;

	String get email => _email;


	User(this._id, this._email);

	static User fromMap(Map<String, dynamic> map) {
		var id = map['id'] ?? (throw ArgumentError("id is required"));
		var email = map['email'] ?? (throw ArgumentError("email is required"));

		return User(id, email);
	}

	Map<String, dynamic> toMap() {
		var map = Map<String, dynamic>();

		map['id'] = id;
		map['email'] = email;

		return map;
	}
}