import 'package:flutter/material.dart';
import 'package:new_guide_app/data/database_service.dart';
import 'package:new_guide_app/pages/excursion_list.dart';
import 'package:new_guide_app/components/colors.dart';

class AddExcursion extends StatefulWidget {
  AddExcursion({Key key}) : super(key: key);

  @override
  _AddExcursionState createState() => _AddExcursionState();
}

class _AddExcursionState extends State<AddExcursion> {
  String _excursionType;
  String _date;
  String _time;
  String _participantNumbers;
  String _uid;
  String _price;
  final _formKey = GlobalKey<FormState>();
  bool _filledForm = false;
  String _hint = ' - fill this field';

  TextEditingController _typeController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();
  TextEditingController _participantController = TextEditingController();
  TextEditingController _priceController = TextEditingController();

  Future selectDate() async {
    FocusScope.of(context).requestFocus(FocusNode());
    DateTime _choosenDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2030));
    var formattedDate =
        "${_choosenDate.year.toString()}-${_choosenDate.month.toString().padLeft(2, '0')}-${_choosenDate.day.toString().padLeft(2, '0')}";
    _dateController.text = formattedDate.toString();
  }

  Future selectTime() async {
    FocusScope.of(context).requestFocus(FocusNode());
    TimeOfDay _choosenTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    var formattedTime =
        "${_choosenTime.hour.toString().padLeft(2, '0')}:${_choosenTime.minute.toString().padLeft(2, '0')}";
    _timeController.text = formattedTime.toString();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        content: Container(
          height: MediaQuery.of(context).size.height * 0.45,
          child: Column(children: [
            Flexible(
              child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FormField(
                          _typeController,
                          (_filledForm == true) ? 'Tour $_hint' : 'Tour',
                          (_filledForm == true)
                              ? unfilledColor
                              : textAdditionalColor,
                          _excursionType),
                      Flexible(
                        child: TextFormField(
                          controller: _dateController,
                          decoration: InputDecoration(
                            hintText:
                                (_filledForm == true) ? 'Date $_hint' : 'Date',
                            hintStyle: TextStyle(
                                color: (_filledForm == true)
                                    ? unfilledColor
                                    : textAdditionalColor,
                                fontSize: 14),
                          ),
                          onChanged: (val) => _date = val,
                          onTap: () async {
                            selectDate();
                          },
                        ),
                      ),
                      Flexible(
                        child: TextFormField(
                          controller: _timeController,
                          decoration: InputDecoration(
                              hintText: (_filledForm == true)
                                  ? 'Time $_hint'
                                  : 'Time',
                              hintStyle: TextStyle(
                                  color: (_filledForm == true)
                                      ? unfilledColor
                                      : textAdditionalColor,
                                  fontSize: 14)),
                                  onChanged: (val) => _time = val,
                          onTap: () async {
                            selectTime();
                          },
                        ),
                      ),
                      FormField(
                        _participantController,
                        (_filledForm == true)
                            ? 'Participant numbers $_hint'
                            : 'Participant numbers',
                        (_filledForm == true)
                            ? unfilledColor
                            : textAdditionalColor,
                        _participantNumbers,
                      ),
                      FormField(
                          _priceController,
                          (_filledForm == true) ? 'Cost \$ $_hint' : 'Cost \$',
                          (_filledForm == true)
                              ? unfilledColor
                              : textAdditionalColor,
                          _price),
                      SizedBox(),
                      ElevatedButton(
                        onPressed: () async {
                          if (_participantController.text.isNotEmpty &&
                              _timeController.text.isNotEmpty &&
                              _dateController.text.isNotEmpty &&
                              _typeController.text.isNotEmpty &&
                              _priceController.text.isNotEmpty) {
                            await DatabaseService().createNewExcursion(
                                _typeController.text,
                                _dateController.text,
                                _timeController.text,
                                _participantController.text,
                                _priceController.text,
                                _uid);
                            Navigator.pop(context);
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ExcursionList()));
                          } else {
                            setState(() {
                              _filledForm = true;
                            });
                          }
                        },
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15.0)),
                          child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                'Add',
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                      ),
                    ],
                  )),
            ),
          ]),
        ));
  }
}

class FormField extends StatelessWidget {
  TextEditingController _controller = TextEditingController();
  final String _hintText;
  final Color _color;
  String _onChanged;

  FormField(this._controller, this._hintText, this._color, this._onChanged);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: TextFormField(
        controller: _controller,
        decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: TextStyle(color: _color, fontSize: 14)),
        onChanged: (val) => _onChanged = val,
      ),
    );
  }
}
