import 'package:flutter/material.dart';
import 'package:my_word/auth.dart';


class AuthEmailPasswordPage extends StatefulWidget {
	@override
	_AuthEmailPasswordPageState createState() => _AuthEmailPasswordPageState();
}


class _AuthEmailPasswordPageState extends State<AuthEmailPasswordPage> {

	String _email = 'example@example.com';
	String _password = '123456';


	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[

						Padding(
							padding: EdgeInsets.all(8.0),
							child: TextField(
								decoration: InputDecoration(
									hintText: 'Email',
								),
								onChanged: (String str) {
									_email = str;
								},
							)
						),

						Padding(
							padding: EdgeInsets.all(8.0),
							child: TextField(
								obscureText: true,
								decoration: InputDecoration(
									hintText: 'Password',
								),
								onChanged: (String str) {
									_password = str;
								},
							)
						),

						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[

								Padding(
									padding: EdgeInsets.all(8.0),
									child: Builder(builder: (context) =>
										RaisedButton(
											child: Text('Sign Up'),
											onPressed: () {
												authService.signUpEmailPassword(_email, _password).then((error) {
													if (error == null) {
														Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);

													} else {
														var snackBar = SnackBar(
															content: Text('There was an error, try again. [${error.toString()}]'), //TODO: remove error info
															behavior: SnackBarBehavior.floating,
														);
														Scaffold.of(context).showSnackBar(snackBar);
													}
												});
											}
										),
									),
								),

								Padding(
									padding: EdgeInsets.all(8.0),
									child: Builder(
										builder: (context) =>
											RaisedButton(
												child: Text('Sign In'),
												onPressed: () {
													authService.signInEmailPassword(_email, _password).then((error) {
														if (error == null) {
															Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);

														} else {
															var snackBar = SnackBar(
																content: Text('There was an error, try again. [${error.toString()}]'), //TODO: remove error info
																behavior: SnackBarBehavior.floating,
															);
															Scaffold.of(context).showSnackBar(snackBar);
														}
													});
												}
											)
									),
								),

							],
						),
					]
				)
			)
		);
	}
}
