import 'package:flutter/material.dart';
import 'package:my_word/auth_service.dart';


class AccountMenuPage extends StatelessWidget {
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Center(
				child: Column(
					children: <Widget>[

						Expanded(
							flex: 25,
							child: Center(
								child:
								Text(
									'Manage account:',
									textAlign: TextAlign.center,
									style: TextStyle(
										fontWeight: FontWeight.w700,
										fontSize: 32.0,
									),
								),
							)
						),

						Expanded(
							flex: 50,
							child: Column(
									mainAxisAlignment: MainAxisAlignment.center,
									children: <Widget>[

										RaisedButton(
											child: Text('Settings'),
											onPressed: null
										),

										RaisedButton(
											child: Text('Switch accounts'),
											onPressed: () {
												Navigator.pushNamed(context, '/auth');
											}
										),

									],
							)
						),

						Expanded(
							flex: 25,
							child: Center(
								child: Builder(builder: (context) =>
									RaisedButton(
										child: Text('Sign out'),
										color: Colors.red,
										onPressed: () {
											AuthService.instance.signOut().then((error) {
												if (error != null) {
													var snackBar = SnackBar(
														content: Text('There was an error, try again. [${error.toString()}]'), //TODO: remove error info
														behavior: SnackBarBehavior.floating,
													);
													Scaffold.of(context).showSnackBar(snackBar);

												} else {
													Navigator.pushNamedAndRemoveUntil(context, '/auth', (Route<dynamic> route) => false);
												}
											});
										}
									),
								),
							),
						),

					],
				),
			),
		);
	}

}