import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:new_guide_app/data/database_service.dart';
import 'package:new_guide_app/data/excursion_data.dart';
import 'package:new_guide_app/pages/history_page.dart';
import 'package:new_guide_app/pages/settings_page.dart';
import 'package:new_guide_app/components/show_up.dart';
import 'package:new_guide_app/components/colors.dart';

class ExcursionList extends StatefulWidget {
  ExcursionList({Key key}) : super(key: key);

  @override
  ExcursionListState createState() => ExcursionListState();
}

class ExcursionListState extends State<ExcursionList> {
  int delayAmount = 500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(
            'Schedule',
            style: TextStyle(color: textPrimaryColor),
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
      body: StreamBuilder<List<Excursion>>(
          stream: DatabaseService().listExcursion(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: CircularProgressIndicator());
            }
            List<Excursion> excursions = snapshot.data;
            excursions.sort((a, b) => a.date.compareTo(b.date));
            return (excursions.length == 0)
                ? Align(
                    alignment: Alignment.center,
                    child: Text('The schedule is empty yet...'))
                : ShowUp(
                    delay: delayAmount + 200,
                    child: ListView.separated(
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
                                            child: Text('You want to...')),
                                        content: StreamBuilder<List<Excursion>>(
                                            stream: DatabaseService()
                                                .listExcursion(),
                                            builder: (context, snapshot) {
                                              return Container(
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.1,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    GestureDetector(
                                                        child: Text(
                                                            'Move it to\n  History'),
                                                        onTap: () async {
                                                          await DatabaseService()
                                                              .createNewHistory(
                                                            excursions[index]
                                                                .date,
                                                            excursions[index]
                                                                .time,
                                                            excursions[index]
                                                                .excursionType,
                                                            excursions[index]
                                                                .participantNumbers,
                                                            excursions[index]
                                                                .price,
                                                            excursions[index]
                                                                .uid,
                                                          );
                                                          {
                                                            await DatabaseService()
                                                                .removeExcursion(
                                                                    excursions[
                                                                            index]
                                                                        .uid);
                                                          }
                                                          Navigator.pop(
                                                              context);
                                                          setState(() {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            HistoryPage()));
                                                          });
                                                        }),
                                                    GestureDetector(
                                                      child: Text('Remove it'),
                                                      onTap: () async {
                                                        await DatabaseService()
                                                            .removeExcursion(
                                                                excursions[
                                                                        index]
                                                                    .uid);
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
                                'Participants: ${excursions[index].participantNumbers} - Cost: \$${excursions[index].price.toString()}'),
                          );
                        }),
                  );
          }),
    );
  }
}
