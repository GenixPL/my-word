import 'package:flutter/material.dart';
import 'package:my_word/auth_service.dart';
import 'package:my_word/db/users_db.dart';
import 'package:my_word/main_drawer.dart';


class HomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(),
			drawer: MainDrawer(),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[

						Text('HOME'),

						RaisedButton(
							onPressed: () {
								var user = AuthService.instance.user;
								print('${user.email} + ${user.id}');
							}
						),

					]
				)
			)
		);
	}
}
