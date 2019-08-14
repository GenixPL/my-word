import 'package:flutter/material.dart';
import 'package:my_word/services/MwFactory.dart';
import 'package:my_word/main_drawer.dart';
import 'package:my_word/services/auth/MwAuthService.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:my_word/show_info.dart';
import 'package:provider/provider.dart';


class SetsPage extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				title: Text('Sets'),
				centerTitle: true,
			),
			drawer: MainDrawer(),
			resizeToAvoidBottomInset: false,
			body: Center(
				child: Column(
					children: <Widget>[
						
						Expanded(
							flex: 90,
							child: Padding(
								padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
								child: _setsListView(context),
							),
						),
						
						Expanded( //TODO: child -> row with information how to handle actions
							flex: 10,
							child: FloatingActionButton(
								backgroundColor: Colors.redAccent,
								child: Text(
									'+',
									style: TextStyle(
										fontSize: 32.0,
										fontWeight: FontWeight.w400,
										color: Colors.white,
									),
								),
								onPressed: () async {
									Navigator.of(context).pushNamed('/sets/create');
								}
							),
						
						),
					
					],
				),
			),
		);
	}
	
	Widget _setsListView(BuildContext context) {
		var userService = Provider.of<MwUserService>(context);
		var sets = userService.setsInfo;
		
		return Scrollbar(
			child: ListView.separated(
				itemCount: sets.length,
				itemBuilder: (context, i) =>
					ListTile(
						leading: Text(
							'${sets[i].lang1} ${sets[i].lang2}',
							style: TextStyle(
								fontSize: 20.0,
								fontWeight: FontWeight.w600,
							),
						),
						title: Text(
							'${sets[i].name}',
						),
						onTap: () {
							MwFactory.userService.getSet(sets[i].id).then((set) {
								Navigator.of(context).pushNamed('/sets/edit', arguments: set);
							}).catchError((e) {
								ShowInfo.error(context, '', e);
							});
						},
					),
				separatorBuilder: (context, i) => Divider(),
			),
		);
	}
	
}