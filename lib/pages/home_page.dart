import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';


class HomePage extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text('Home'),
			),
			drawer: MainDrawer(),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[

						RaisedButton(
							child: Text('Learn'),
							onPressed: () {
								Navigator.pushNamed(context, '/learn');
							},
						),

						RaisedButton(
							child: Text('Manage sets'),
							onPressed: () {
								Navigator.pushNamed(context, '/sets');
							},
						),

					]
				)
			)
		);
	}
}
