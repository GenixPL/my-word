import 'package:flutter/material.dart';


class CreateSetDialog extends StatelessWidget {

	TextEditingController _setNameController = TextEditingController();
	
	@override
  Widget build(BuildContext context) {
    return Dialog(
			child: Container(
				color: Colors.indigo,
				child: Column(
					mainAxisSize: MainAxisSize.min,
					mainAxisAlignment: MainAxisAlignment.center,
					children: <Widget>[
						
						Padding(
							padding: EdgeInsets.all(8.0),
							child: TextField(
								decoration: InputDecoration(
									hintText: 'Set Name',
								),
								controller: _setNameController,
							)
						),
						
						Row(
							mainAxisAlignment: MainAxisAlignment.center,
							children: <Widget>[
								
								Padding(
								  padding: const EdgeInsets.all(8.0),
								  child: RaisedButton(onPressed: null),
								),
								
								Padding(
								  padding: const EdgeInsets.all(8.0),
								  child: RaisedButton(onPressed: null),
								),
								
							],
						),
					
					],
				),
			),
    );
  }
}
