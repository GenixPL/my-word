import 'package:flutter/material.dart';
import 'package:language_pickers/language.dart';
import 'package:language_pickers/language_picker_dialog.dart';
import 'package:language_pickers/utils/utils.dart';


class CreateSetPage extends StatefulWidget {
	@override
	_CreateSetPageState createState() => _CreateSetPageState();
}


class _CreateSetPageState extends State<CreateSetPage> {
	
	String _setName;
	Language _lang1 = LanguagePickerUtils.getLanguageByIsoCode('en');
	Language _lang2 = LanguagePickerUtils.getLanguageByIsoCode('de');
	
	
	@override
	Widget build(BuildContext context) {
		return Scaffold(
			resizeToAvoidBottomInset: false,
			appBar: AppBar(
				centerTitle: true,
				title: Text('Create New Set'),
			),
			body: Column(
				mainAxisAlignment: MainAxisAlignment.center,
				children: <Widget>[
					
					Expanded(
						flex: 80,
						child: Column(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Padding(
									padding: EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 32.0),
									child: TextFormField( //TODO: correct it
										style: TextStyle(
											fontSize: 16.0,
											fontWeight: FontWeight.w400,
										),
										decoration: InputDecoration(
											hintText: 'Set Name',
										),
										validator: (value) {
											return value.isEmpty ? 'Set name can\'t be empty.' : null;
										},
									)
								),
								
								Row(
									children: <Widget>[
										
										Expanded(
											flex: 50,
											child: GestureDetector(
												child: Text(
													'${_lang1.name} (${_lang1.isoCode})',
													textAlign: TextAlign.center,
													style: TextStyle(
														fontSize: 16.0,
														fontWeight: FontWeight.w400,
													),
												),
												onTap: () {
													_openFirstDialog();
												},
											),
										),
										
										Expanded(
											flex: 50,
											child: GestureDetector(
												child: Text(
													'${_lang2.name} (${_lang2.isoCode})',
													textAlign: TextAlign.center,
													style: TextStyle(
														fontSize: 16.0,
														fontWeight: FontWeight.w400,
													),
												),
												onTap: () {
													_openSecondDialog();
												},
											),
										)
									
									]
								)
							
							],
						),
					),
					
					Expanded(
						flex: 10,
						child: Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Padding(
									padding: const EdgeInsets.all(8.0),
									child: RaisedButton(
										child: Text(
											'Cancel',
										),
										color: Colors.red,
										onPressed: () {
											Navigator.of(context).pop();
										}
									),
								),
								
								Padding(
									padding: const EdgeInsets.all(8.0),
									child: RaisedButton(
										child: Text('Create'),
										color: Colors.green,
										onPressed: () {}
									),
								),
							
							],
						),
					),
				
				],
			),
		);
	}
	
	void _openFirstDialog() {
		showDialog(
			context: context,
			builder: (context) =>
				LanguagePickerDialog(
					titlePadding: EdgeInsets.all(8.0),
					searchInputDecoration: InputDecoration(hintText: 'Search...'),
					isSearchable: true,
					title: Text('Select your language'),
					onValuePicked: (Language language) =>
						setState(() {
							_lang1 = language;
						}),
					itemBuilder: _buildDialogItem
				)
		);
	}
	
	void _openSecondDialog() {
		showDialog(
			context: context,
			builder: (context) =>
				LanguagePickerDialog(
					titlePadding: EdgeInsets.all(8.0),
					searchInputDecoration: InputDecoration(hintText: 'Search...'),
					isSearchable: true,
					title: Text('Select your language'),
					onValuePicked: (Language language) =>
						setState(() {
							_lang2 = language;
						}),
					itemBuilder: _buildDialogItem
				)
		);
	}
	
	Widget _buildDialogItem(Language language) {
		return Row(
			children: <Widget>[
				Text(language.name),
				SizedBox(width: 8.0),
				Flexible(child: Text("(${language.isoCode})"))
			],
		);
	}
}
