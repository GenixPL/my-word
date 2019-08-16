import 'package:flutter/material.dart';
import 'package:my_word/route_generator.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:provider/provider.dart';


class MainDrawer extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		var userService = Provider.of<MwUserService>(context);
		
		return Drawer(
			child: Column(
				children: <Widget>[
					
					UserAccountsDrawerHeader(
						accountName: Text(''),
						accountEmail: Text(
							userService.isSigned ? userService.email : 'Please log in',
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
										Icons.play_arrow,
										color: RouteGenerator.lastRoute == '/learn' ? Colors.grey : Colors.white,
									),
								),
								Expanded(
									child: Text(
										'Learn',
										style: TextStyle(
											color: RouteGenerator.lastRoute == '/learn' ? Colors.grey : Colors.white,
										),
									)
								),
							],
						),
						onTap: RouteGenerator.lastRoute == '/learn' ? () {
							Navigator.pop(context);
						} : () {
							Navigator.pop(context); //hides menu
							Navigator.pushNamed(context, '/learn');
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
										
										if (userService.isSigned) {
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