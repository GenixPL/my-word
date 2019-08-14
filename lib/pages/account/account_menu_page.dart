import 'package:flutter/material.dart';
import 'package:my_word/services/MwAuthService.dart';
import 'package:my_word/show_info.dart';


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
											MwAuthService.instance.signOut()
												.then((v) {
												Navigator.pushNamedAndRemoveUntil(context, '/auth', (Route<dynamic> route) => false);
											}).catchError((e) {
												ShowInfo.error(context, '', e);
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