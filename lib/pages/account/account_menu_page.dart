import 'package:flutter/material.dart';


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
							child: Center()
						),

					],
				),
			),
		);
	}

}