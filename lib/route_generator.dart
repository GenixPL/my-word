import 'package:flutter/material.dart';
import 'package:my_word/pages/account/account_menu_page.dart';
import 'package:my_word/pages/auth/auth_email_password_page.dart';
import 'package:my_word/pages/auth/auth_menu_page.dart';
import 'package:my_word/pages/home_page.dart';
import 'package:my_word/pages/sets/create_set_page.dart';
import 'package:my_word/pages/sets/sets_menu_page.dart';
import 'package:my_word/services/auth_service.dart';


class RouteGenerator {
	
	static String _lastRoute;
	
	static get lastRoute => _lastRoute;
	
	static Route<dynamic> generateRoute(RouteSettings settings) {
		final args = settings.arguments;
		
		if (!AuthService.instance.isSigned && !settings.name.contains('/auth')) {
			return MaterialPageRoute(builder: (_) => AuthMenuPage());
		}
		
		_lastRoute = settings.name;
		
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
			
			case '/sets/create':
				return MaterialPageRoute(builder: (_) => CreateSetPage());
			
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