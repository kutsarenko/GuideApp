import 'package:flutter/material.dart';
import 'package:new_guide_app/data/database_service.dart';
import 'package:new_guide_app/data/excursion_data.dart';
import 'package:new_guide_app/pages/settings_page.dart';
import 'package:new_guide_app/widgets/next_tour.dart';
import 'package:new_guide_app/components/show_up.dart';
import 'package:new_guide_app/components/colors.dart';

class LandingPage extends StatefulWidget {
  LandingPage({Key key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  List<int> prices = [];
  List<int> people = [];
  var allTheMoney = '';
  var allThePeople = '';
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: DatabaseService().listHistory(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<Excursion> historyExcursion = snapshot.data;

          for (int i = 0; i < historyExcursion?.length; i++) {
            if (historyExcursion[i]?.price != null) {
              prices.add(int.tryParse(historyExcursion[i]?.price));
            }
          }
          var allTheMoney =
              prices.fold(0, (previous, current) => previous + current);

          for (int i = 0; i < historyExcursion?.length; i++) {
            if (historyExcursion[i]?.participantNumbers != null) {
              people.add(int.tryParse(historyExcursion[i]?.participantNumbers));
            }
          }

          var allThePeople =
              people.fold(0, (previous, current) => previous + current);

          return Scaffold(
            appBar: AppBar(
                title: Text(
                  'GuideApp',
                  style: TextStyle(color: textPrimaryColor),
                ),
                actions: <Widget>[
                  Container(
                    margin: EdgeInsets.only(right: 20.0),
                    child: GestureDetector(
                        onTap: () {
                         
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SettingsPage()));
                          },
                       
                        child: Icon(
                          Icons.more_vert,
                          color: textPrimaryColor,
                          size: 30,
                        )),
                  ),
                ]),
            body: SingleChildScrollView(
              child: ShowUp(
                delay: delayAmount + 200,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              margin: EdgeInsets.only(top: 10.0, bottom: 7.0),
                              child: Align(
                                  alignment: Alignment.center,
                                  child: Text('Your stats',
                                      style: TextStyle(
                                          color: listTextColor,
                                          fontSize: 30.0,
                                          fontWeight: FontWeight.bold))),
                            ),
                            Container(
                              height: MediaQuery.of(context).size.height * 0.3,
                              margin: EdgeInsets.only(
                                  left: 10.0, right: 10.0, bottom: 20.0),
                              padding: EdgeInsets.only(
                                  left: 10.0,
                                  right: 10.0,
                                  top: 30.0,
                                  bottom: 30.0),
                              decoration: BoxDecoration(
                                  boxShadow: [
                                    BoxShadow(
                                      offset: Offset(0, 5),
                                      color: textAdditionalColor,
                                      blurRadius: 20,
                                    )
                                  ],
                                  borderRadius: BorderRadius.circular(15.0),
                                  color: kPrimaryColor),
                              child: Align(
                                alignment: Alignment.center,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    StatField('Tours', Icons.work_rounded, (historyExcursion == null)? '0':'${historyExcursion?.length}'),
                                    StatField('Visitors', Icons.run_circle_outlined, (historyExcursion == null)? '0':'${allThePeople.toString()}'),
                                    StatField('Earn \$', Icons.money_sharp, (historyExcursion == null)? '0': '${allTheMoney.toString()}'),
                                  ],
                                ),
                              ),
                            ),
                            ShowUp(
                              delay: delayAmount + 200,
                              child: Container(
                                  margin:
                                      EdgeInsets.only(top: 10.0, bottom: 7.0),
                                  child: Align(
                                      alignment: Alignment.center,
                                      child: Text('Next tour',
                                          style: TextStyle(
                                            color: listTextColor,
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold,
                                          )))),
                            ),
                            NextTour(),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}

class StatField extends StatelessWidget {
  final String _title;
  final IconData _iconField;
  final String _stats;

  StatField( this._title, this._iconField, this._stats);
     

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(_title,
              style: TextStyle(color: textPrimaryColor, fontSize: 20.0)),
          Icon(_iconField, size: 35.0, color: textPrimaryColor),
          Text(_stats,
              style: TextStyle(
                  color: textPrimaryColor,
                  fontSize: 35.0,
                  fontWeight: FontWeight.bold))
        ],
      ),
    );
  }
}
