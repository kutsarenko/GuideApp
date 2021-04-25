import 'package:flutter/material.dart';
import 'package:new_guide_app/widgets/add_new_one.dart';
import 'excursion_list.dart';
import 'package:ff_navigation_bar/ff_navigation_bar.dart';
import 'history_page.dart';
import 'landing_page.dart';
import 'package:new_guide_app/components/colors.dart';


class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int sectionIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        body: (sectionIndex == 0) ? LandingPage() : (sectionIndex == 1)? ExcursionList() : HistoryPage(),
        bottomNavigationBar: FFNavigationBar(
          theme: FFNavigationBarTheme(
            barBackgroundColor: kPrimaryColor,
            selectedItemIconColor: textPrimaryColor,
            selectedItemBorderColor: textPrimaryColor,
            selectedItemBackgroundColor: Colors.cyan[200],
            unselectedItemLabelColor: textPrimaryColor,
            unselectedItemIconColor: textPrimaryColor,
          ),
          items: <FFNavigationBarItem>[
            FFNavigationBarItem(
              iconData: Icons.emoji_people,
              selectedLabelColor: textPrimaryColor,
              label: 'Main',
            ),
            FFNavigationBarItem(
              iconData: Icons.schedule,
              selectedLabelColor: textPrimaryColor,
              label: 'Schedule',
              selectedForegroundColor: textPrimaryColor,
            ),
            FFNavigationBarItem(
              iconData: Icons.history_edu,
              selectedLabelColor: textPrimaryColor,
              label: 'History',
            ),
          ],
          selectedIndex: sectionIndex,

          onSelectTab: (int index) {
            
            setState(() => sectionIndex = index);
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add, color: textPrimaryColor),
          onPressed: (){        
            showDialog(
              context: context, 
              builder: (_) => AddExcursion());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }
}