import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';
import 'package:my_word/pages/learn/MwLearningModeArgs.dart';
import 'package:my_word/services/user/MwUserService.dart';
import 'package:my_word/show_info.dart';
import 'package:provider/provider.dart';


const MODE_1 = 'Tap and Hold';
const MODE_2 = 'Type Whole';


class MwLearnMenuPage extends StatefulWidget {
	@override
	_MwLearnMenuPageState createState() => _MwLearnMenuPageState();
}


class _MwLearnMenuPageState extends State<MwLearnMenuPage> {
	String _mode = MODE_1;
	bool _switchOrder = false;
	
	
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
		return Row(
			children: <Widget>[
				
				Padding(
					padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
					child: Text(
						'Learning mode:',
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.w500,
						),
					),
				),
				
				Padding(
					padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 8.0),
					child: DropdownButton<String>(
						value: _mode,
						items: <String>[MODE_1, MODE_2]
							.map<DropdownMenuItem<String>>((String value) {
							return DropdownMenuItem<String>(
								value: value,
								child: Text(value),
							);
						}).toList(),
						onChanged: (String value) {
							setState(() {
								_mode = value;
							});
						},
					),
				),
			
			],
		);
	}
	
	Widget _buildSwitchWords(BuildContext context) {
		return Row(
			children: <Widget>[
				
				Padding(
					padding: const EdgeInsets.fromLTRB(16.0, 8.0, 8.0, 8.0),
					child: Text(
						'Switch order:',
						style: TextStyle(
							fontSize: 16.0,
							fontWeight: FontWeight.w500,
						),
					),
				),
				
				Checkbox(
					value: _switchOrder,
					onChanged: (bool value) {
						setState(() {
							_switchOrder = value;
						});
					},
				),
			
			],
		);
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
							_switchOrder ? '${sets[i].lang2} -> ${sets[i].lang1}' : '${sets[i].lang1} -> ${sets[i].lang2}',
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
									if (_mode == MODE_1) {
										Navigator.of(context).pushNamed('/learn/first', arguments: MwLearningModeArgs(set, _switchOrder));
									} else {
										ShowInfo.simple(context, 'Not implemented.');
									}
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