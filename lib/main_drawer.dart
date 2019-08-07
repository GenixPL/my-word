import 'package:flutter/material.dart';
import 'package:my_word/auth.dart';
import 'package:provider/provider.dart';


class MainDrawer extends StatelessWidget {

	@override
	Widget build(BuildContext context) {
		var auth = Provider.of<AuthService>(context);
		var isLoggedIn = (auth.user != null);
		var hasDisplayName = (auth.user == null ? false : (auth.user.displayName != null));

		return Drawer(
			child: Column(
				children: <Widget>[

					UserAccountsDrawerHeader(
						accountName: Text(
							hasDisplayName ? auth.user.displayName : '',
							style: TextStyle(
								fontWeight: FontWeight.w700,
							),
						),
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
									child: Icon(Icons.home),
								),
								Expanded(child: Text('Home')),
							],
						),
						onTap: () {
							Navigator.pop(context); //hides menu
							Navigator.pushNamedAndRemoveUntil(context, '/', (Route<dynamic> route) => false);
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