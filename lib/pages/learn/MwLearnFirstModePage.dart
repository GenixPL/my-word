import 'package:flutter/material.dart';
import 'package:my_word/main_drawer.dart';
import 'package:my_word/models/MwSet.dart';
import 'package:my_word/pages/learn/MwLearnMenuPage.dart';


class MwLearnFirstModePage extends StatefulWidget {
	
	final MwLearningModeArgs _learningModeArgs;
	
	MwLearnFirstModePage(this._learningModeArgs);
	
	@override
	_MwLearnFirstModePageSate createState() => _MwLearnFirstModePageSate(_learningModeArgs.set, _learningModeArgs.isOrderSwitched);
}


class _MwLearnFirstModePageSate extends State<MwLearnFirstModePage> {
	
	final MwSet _set;
	final bool _isOrderSwitched;
	int _i = 0;
	bool _showTranslation = false;
	
	_MwLearnFirstModePageSate(this._set, this._isOrderSwitched);
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			appBar: AppBar(
				centerTitle: true,
				title: Text(_set.name),
			),
			drawer: MainDrawer(),
			body: Center(
				child: Column(
					children: <Widget>[
						
						Padding(
							padding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 16.0),
							child: Text(
								'Tap and hold to show a translation.',
								textAlign: TextAlign.center,
								style: TextStyle(
									fontSize: 16.0,
									fontWeight: FontWeight.w500,
								),
							),
						),
						
						_buildMain(context),
						
						
						_buildBottom(context),
					
					],
				),
			),
		);
	}
	
	Widget _buildMain(BuildContext context) {
		return Expanded(
			child: GestureDetector(
				child: Padding(
					padding: const EdgeInsets.fromLTRB(8.0, 0.0, 8.0, 0.0),
					child: Container(
						color: Color.fromARGB(50, 0, 0, 0),
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Expanded(
									flex: 50,
								  child: Center(
								    child: Text(
								    	_getFirstPart(),
								    	textAlign: TextAlign.center,
								    	style: TextStyle(
								    		fontSize: 24.0,
								    		fontWeight: FontWeight.w600,
								    	),
								    ),
								  ),
								),
								
								Divider(),
								
								Expanded(
									flex: 50,
								  child: Center(
								    child: Text(
								    	_getSecondPart(),
								    	textAlign: TextAlign.center,
								    	style: TextStyle(
								    		fontSize: 24.0,
								    		fontWeight: FontWeight.w600,
								    	),
								    ),
								  ),
								),
							
							],
						),
					),
				),
				onTapDown: (details) {
					setState(() {
						_showTranslation = true;
					});
				},
				onTapUp: (details) {
					setState(() {
						_showTranslation = false;
					});
				},
			),
		);
	}
	
	Widget _buildBottom(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.spaceBetween,
			children: <Widget>[
				
				Expanded(
					child: Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
						child: FlatButton(
							child: Text(
								'Previous',
							),
							onPressed: _isFirst() ? null : () {
								setState(() {
									_i--;
								});
							},
						),
					),
				),
				
				Expanded(
					child: Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
						child: FlatButton(
							child: Text(
								'Exit',
								style: TextStyle(
									color: Colors.red,
								),
							),
							onPressed: () {
								Navigator.of(context).pop();
							},
						),
					),
				),
				
				Expanded(
					child: Padding(
						padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
						child: FlatButton(
							child: Text(
								'Next',
							),
							onPressed: _isLast() ? null : () {
								setState(() {
									_i++;
								});
							},
						),
					),
				),
			
			],
		);
	}
	
	
	
	String _getFirstPart() {
		return _isOrderSwitched ? _set.wordPairs[_i].word2 : _set.wordPairs[_i].word1;
	}
	
	String _getSecondPart() {
		if (_showTranslation) {
			return _isOrderSwitched ? _set.wordPairs[_i].word1 : _set.wordPairs[_i].word2;
		} else {
			return '';
		}
	}
	
	bool _isFirst() {
		return _i == 0;
	}
	
	bool _isLast() {
		return _i == (_set.wordPairs.length - 1);
	}
	
}