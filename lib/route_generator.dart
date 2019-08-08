import 'package:flutter/material.dart';
import 'package:my_word/auth_service.dart';
import 'package:my_word/pages/account/account_menu_page.dart';
import 'package:my_word/pages/auth/auth_email_password_page.dart';
import 'package:my_word/pages/auth/auth_menu_page.dart';
import 'package:my_word/pages/home_page.dart';
import 'package:my_word/pages/sets/SetsMenuPage.dart';


class RouteGenerator {

	static Route<dynamic> generateRoute(RouteSettings settings) {
		final args = settings.arguments;

		if (!AuthService.instance.isSigned && !settings.name.contains('/auth')) {
			return MaterialPageRoute(builder: (_) => AuthMenuPage());
		}

		switch (settings.name) {
			case '/':
				return MaterialPageRoute(builder: (_) => HomePage());

			case '/auth':
				return MaterialPageRoute(builder: (_) => AuthMenuPage());

			case '/auth/email-password':
				return MaterialPageRoute(builder: (_) => AuthEmailPasswordPage());

			case '/account':
				return MaterialPageRoute(builder: (_) => AccountMenuPage());

			case '/sets':
				return MaterialPageRoute(builder: (_) => SetsPage());

			default:
				return _errorRoute();
		}
	}

	static Route<dynamic> _errorRoute() {
		return MaterialPageRoute(builder: (_) {
			return Scaffold(
				body: Center(
					child: Text('ERROR ROUTE'),
				),
			);
		});
	}

}