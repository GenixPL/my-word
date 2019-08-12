import 'package:flutter/material.dart';

import 'package:my_word/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:my_word/services/auth_service.dart';


void main() async {
	await AuthService.instance.checkUserExists();

	runApp(MyApp());
}


class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
		  child: MaterialApp(
		  	initialRoute: '/',
		  	onGenerateRoute: RouteGenerator.generateRoute,
		  	theme: ThemeData.dark(),
		  ),
			providers: [
				ChangeNotifierProvider<AuthService>.value(value: AuthService.instance),
			],
		);
	}
}