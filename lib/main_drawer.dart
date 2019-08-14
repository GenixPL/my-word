import 'package:flutter/material.dart';
import 'package:my_word/route_generator.dart';
import 'package:my_word/services/MwAuthService.dart';
import 'package:provider/provider.dart';


class MainDrawer extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		var auth = Provider.of<MwAuthService>(context);
		var isLoggedIn = (auth.user != null);
		
		return Drawer(
			child: Column(
				children: <Widget>[
					
					UserAccountsDrawerHeader(
						accountName: Text(''),
						accountEmail: Text(
							isLoggedIn ? auth.user.email : 'Please log in',
							style: TextStyle(
								fontWeight: FontWeight.w700,
							),
						),
						decoration: BoxDecoration(
							image: DecorationImage(
								image: AssetImage('assets/dark-background.jpg'),
								fit: BoxFit.fill,
							),
						),
					),
					
					GestureDetector(
						child: Row(
							mainAxisAlignment: MainAxisAlignment.start,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Padding(
									padding: const EdgeInsets.all(12.0),
									child: Icon(
										Icons.home,
										color: RouteGenerator.lastRoute == '/' ? Colors.grey : Colors.white,
									),
								),
								Expanded(child: Text(
									'Home',
									style: TextStyle(
										color: RouteGenerator.lastRoute == '/' ? Colors.grey : Colors.white,
									),
								)),
							],
						),
						onTap: RouteGenerator.lastRoute == '/' ? () {
							Navigator.pop(context);
						} : () {
							Navigator.pop(context); //hides menu
							Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
						},
					),
					
					GestureDetector(
						child: Row(
							mainAxisAlignment: MainAxisAlignment.start,
							mainAxisSize: MainAxisSize.max,
							children: <Widget>[
								Padding(
									padding: const EdgeInsets.all(12.0),
									child: Icon(
										Icons.view_headline,
										color: RouteGenerator.lastRoute == '/sets' ? Colors.grey : Colors.white,
									),
								),
								Expanded(
									child: Text(
										'Manage Sets',
										style: TextStyle(
											color: RouteGenerator.lastRoute == '/sets' ? Colors.grey : Colors.white,
										),
									)
								),
							],
						),
						onTap: RouteGenerator.lastRoute == '/sets' ? () {
							Navigator.pop(context);
						} : () {
							Navigator.pop(context); //hides menu
							Navigator.pushNamed(context, '/sets');
						},
					),
					
					Expanded(
						child: Column(
							mainAxisAlignment: MainAxisAlignment.end,
							children: <Widget>[
								
								GestureDetector(
									child: Row(
										mainAxisAlignment: MainAxisAlignment.start,
										mainAxisSize: MainAxisSize.max,
										children: <Widget>[
											Padding(
												padding: const EdgeInsets.all(12.0),
												child: Icon(Icons.account_box),
											),
											Expanded(child: Text('Account')),
										],
									),
									onTap: () {
										Navigator.pop(context); //hides menu
										
										if (auth.isSigned) {
											Navigator.pushNamed(context, '/account');
										} else {
											Navigator.pushNamed(context, '/auth');
										}
									},
								),
							
							],
						),
					),
				],
			),
		);
	}
	
}