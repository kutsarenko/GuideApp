import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class AddTypeOfExcursion extends StatelessWidget {
  String typeOfExcursion;
  TextEditingController textEditingController = TextEditingController();
  AddTypeOfExcursion({Key key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
           height: MediaQuery.of(context).size.height * 0.45,
          child: Column(
            children: [
              Form(child: TextFormField(

              )),
              SizedBox(),
                      ElevatedButton(
                        onPressed: () async{

                        },
                      ),

          ],))
    );
  }
}