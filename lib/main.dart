import 'package:flutter/material.dart';
import 'package:my_word/services/MwFactory.dart';
import 'package:my_word/models/MwSetInfo.dart';
import 'package:my_word/route_generator.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:provider/provider.dart';


void main() async {
	await MwFactory.userService.checkUserExists();
	
	runApp(MyApp());
}


class MyApp extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return MultiProvider(
			child: MaterialApp(
				initialRoute: '/',
				onGenerateRoute: RouteGenerator.generateRoute,
				theme: _theme(),
			),
			providers: [
				ChangeNotifierProvider<MwUserService>.value(value: MwFactory.userService),
			],
		);
	}
}


ThemeData _theme() {
	return ThemeData(
		brightness: Brightness.dark,
		inputDecorationTheme: InputDecorationTheme(
			focusedBorder: UnderlineInputBorder(
				borderSide: BorderSide(
					color: Colors.white
				)
			)
		)
	);
}