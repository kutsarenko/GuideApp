import 'package:flutter/material.dart';
import 'package:new_guide_app/components/colors.dart';
import 'package:new_guide_app/data/database_service.dart';
import 'package:new_guide_app/data/excursion_data.dart';

class NextTour extends StatefulWidget {
  NextTour({Key key}) : super(key: key);

  @override
  _NextTourState createState() => _NextTourState();
}

class _NextTourState extends State<NextTour> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Object>(
        stream: DatabaseService().listExcursion(),
        builder: (context, snapshot) {
          List<Excursion> excursions = snapshot.data;
          excursions?.sort((a, b) => a.date.compareTo(b.date));
          return (excursions?.isEmpty ?? true)
              ? Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: textAdditionalColor,
                        blurRadius: 20,
                      )
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                          child: Text(
                            'You have no planned tours',
                            style: TextStyle(
                                color: textPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 17.0),
                          ),
                          alignment: Alignment.center),
                      Icon(
                        Icons.mood_bad,
                        color: textPrimaryColor,
                        size: 30.0,
                      )
                    ],
                  ))
              : Container(
                  height: MediaQuery.of(context).size.height * 0.15,
                  padding: EdgeInsets.only(
                      left: 10.0, right: 10.0, top: 20.0, bottom: 20.0),
                  margin: EdgeInsets.only(left: 10.0, right: 10.0),
                  decoration: BoxDecoration(
                     boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 5),
                        color: textAdditionalColor,
                        blurRadius: 20,
                      )
                    ],
                    color: kPrimaryColor,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Text(
                            '${excursions[0].date} - ${excursions[0].time}',
                            style: TextStyle(
                                color: textPrimaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 20),
                          ),
                          Text(
                            '${excursions[0].excursionType}',
                            style: TextStyle(
                              color: textPrimaryColor,
                            ),
                          ),
                        ],
                      ),
                      Icon(
                        Icons.schedule,
                        color: textPrimaryColor,
                        size: 35.0,
                      ),
                    ],
                  ),
                );
        });
  }
}
