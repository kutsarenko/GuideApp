import 'package:flutter/material.dart';
import 'package:new_guide_app/components/add_type.dart';
import 'package:new_guide_app/components/colors.dart';

class SettingsPage extends StatefulWidget {
  SettingsPage({Key key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Settings',
          style: TextStyle(color: textPrimaryColor),
        ),
        iconTheme: IconThemeData(color: textPrimaryColor),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){        
            showDialog(
              context: context, 
              builder: (_) => AddTypeOfExcursion());
          },
    ),
    );
  }
}
