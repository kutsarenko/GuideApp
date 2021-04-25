import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:new_guide_app/data/database_service.dart';
import 'package:new_guide_app/data/excursion_data.dart';
import 'package:new_guide_app/pages/settings_page.dart';
import 'package:new_guide_app/components/show_up.dart';
import 'package:new_guide_app/components/colors.dart';

class HistoryPage extends StatefulWidget {
  HistoryPage({Key key}) : super(key: key);

  @override
  _HistoryPageState createState() => _HistoryPageState();
}

class _HistoryPageState extends State<HistoryPage> {
  int delayAmount = 500;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              'History',
              style: TextStyle(color: Colors.white),
            ),
            iconTheme: IconThemeData(color: textPrimaryColor),
            actions: <Widget>[
              Container(
                margin: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                    onTap: () {
                      setState(() {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingsPage()));
                      });
                    },
                    child: Icon(
                      Icons.more_vert,
                      color: textPrimaryColor,
                      size: 30,
                    )),
              ),
            ]),
        body: SafeArea(
          child: StreamBuilder<List<Excursion>>(
              stream: DatabaseService().listHistory(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                }
                List<Excursion> excursions = snapshot.data;
                return (excursions.length == 0)                
                ?  Align(
                      alignment: Alignment.center,
                      child: Text('You have not provided any excursion yet...'))
                : ShowUp(
                  delay: delayAmount + 200,
                  child:
                 
                  ListView.separated(
                      separatorBuilder: (context, index) =>
                          Divider(color: kPrimaryColor),
                      itemCount: excursions.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => AlertDialog(
                                      title: Center(
                                          child:
                                              Text('Do you want to delete it?')),
                                      content: StreamBuilder<List<Excursion>>(
                                          stream:
                                              DatabaseService().listExcursion(),
                                          builder: (context, snapshot) {
                                            return Container(
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height *
                                                  0.1,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.spaceAround,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  GestureDetector(
                                                    child: Text('Yes'),
                                                    onTap: () async {
                                                      await DatabaseService()
                                                          .removeHistory(
                                                              excursions[index]
                                                                  .uid);
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                  GestureDetector(
                                                    child: Text('No'),
                                                    onTap: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                    ));
                          },
                          title: Text(
                              '${excursions[index].date} - ${excursions[index].time} - ${excursions[index].excursionType}'),
                          subtitle: Text(
                              'Participants: ${excursions[index].participantNumbers} - Cost: \$${excursions[index].price}'),
                        );
                      }),
                );
              }),
        ));
  }
}
