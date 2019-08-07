import 'package:flutter/material.dart';

import 'package:my_word/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:my_word/auth.dart';


void main() => runApp(MyApp());

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
				ChangeNotifierProvider<AuthService>.value(value: authService),
			],
		);
	}
}