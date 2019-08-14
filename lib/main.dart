import 'package:flutter/material.dart';

import 'package:my_word/route_generator.dart';
import 'package:provider/provider.dart';
import 'package:my_word/services/MwAuthService.dart';


void main() async {
	await MwAuthService.instance.checkUserExists();

	runApp(MyApp());
}


class MyApp extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		return MultiProvider(
		  child: MaterialApp(
		  	initialRoute: '/',
		  	onGenerateRoute: RouteGenerator.generateRoute,
		  	theme: ThemeData(
				  brightness: Brightness.dark,
				  inputDecorationTheme: InputDecorationTheme(
					  focusedBorder: UnderlineInputBorder(
						  borderSide: BorderSide(
							  color: Colors.white
						  )
					  )
				  )
			  ),
		  ),
			providers: [
				ChangeNotifierProvider<MwAuthService>.value(value: MwAuthService.instance),
			],
		);
	}
}