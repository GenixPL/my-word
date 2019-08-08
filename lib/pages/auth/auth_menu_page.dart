import 'package:flutter/material.dart';
import 'package:my_word/auth_service.dart';


class AuthMenuPage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			body: Column(
				children: [

					Expanded(
						flex: 25,
						child: Center(
							child:
							Text(
								'Please choose authentication method:',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontWeight: FontWeight.w700,
									fontSize: 32.0,
								),
							),
						)
					),

					Expanded(
						flex: 55,
						child: Center(
							child: Column(
								mainAxisAlignment: MainAxisAlignment.center,
								children: <Widget>[

									RaisedButton(
										child: Text('Email & Password'),
										onPressed: () {
											Navigator.pushNamed(context, '/auth/email-password');
										}
									)

								],
							),
						),
					),

					Expanded(
						flex: 20,
						child: Center(),
					),

				],
			)
		);
	}
}
