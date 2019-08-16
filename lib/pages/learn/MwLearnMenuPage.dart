import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:my_word/show_info.dart';
import 'package:provider/provider.dart';


class MwLearningModeArgs {
	
	MwSet set;
	bool isOrderSwitched;
	
	MwLearningModeArgs(this.set, this.isOrderSwitched);
	
}


class MwLearnMenuPage extends StatelessWidget {
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text(
					'Learn',
				),
			),
			drawer: MainDrawer(),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						
						Expanded(
							flex: 10,
							child: _buildLearningMode(context),
						),
						
						Expanded(
							flex: 10,
							child: _buildSwitchWords(context),
						),
						
						Expanded(
							flex: 80,
							child: Padding(
							  padding: const EdgeInsets.only(bottom: 8.0, top: 8.0),
							  child: _setsListView(context),
							),
						),
					
					],
				),
			),
		);
	}
	
	Widget _buildLearningMode(BuildContext context) {
		return Container(color: Colors.red,);
	}
	
	Widget _buildSwitchWords(BuildContext context) {
		return Container(color: Colors.green,);
	}
	
	Widget _setsListView(BuildContext context) {
		//TODO: extract this to separate function
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
							userService.getSet(sets[i].id).then((set) {
								if (set.wordPairs.isEmpty) {
									ShowInfo.simple(context, 'This set is empty.');
								} else {
									Navigator.of(context).pushNamed('/learn/first', arguments: MwLearningModeArgs(set, false));
								}
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