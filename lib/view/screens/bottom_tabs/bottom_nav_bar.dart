import 'package:flutter/material.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/home_tab.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/message_tab.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/profile_tab.dart';
import 'package:ows_bigcareer/view/screens/bottom_tabs/work_tab.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:circle_bottom_navigation_bar/circle_bottom_navigation_bar.dart';
import 'package:circle_bottom_navigation_bar/widgets/tab_data.dart';

class BottomNavBar extends StatefulWidget {
  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar>
    with TickerProviderStateMixin {
  int currentPage = 0;
  int tabIndex = 0;
  var data;

  void getData() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    final user = preferences.getString('userDetails');
    if (mounted) {
      setState(() {
        data = jsonStringToMap(user!);
      });
    }
  }

  jsonStringToMap(String data) {
    Map<String, dynamic> result = {};
    try {
      List<String> str = data
          .replaceAll("{", "")
          .replaceAll("}", "")
          .replaceAll("\"", "")
          .replaceAll("'", "")
          .split(",");
      for (int i = 0; i < str.length; i++) {
        List<String> s = str[i].split(":");
        result.putIfAbsent(s[0].trim(), () => s[1].trim());
      }
    } catch (e) {}
    return result;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final viewPadding = MediaQuery.of(context).viewPadding;
    double barHeight;
    double barHeightWithNotch = 67;
    double arcHeightWithNotch = 67;

    if (size.height > 700) {
      barHeight = 70;
    } else {
      barHeight = size.height * 0.1;
    }

    if (viewPadding.bottom > 0) {
      barHeightWithNotch = (size.height * 0.07) + viewPadding.bottom;
      arcHeightWithNotch = (size.height * 0.075) + viewPadding.bottom;
    }

    return Scaffold(
      body: getBody('patientData', currentPage, data),
      bottomNavigationBar: CircleBottomNavigationBar(
        initialSelection: currentPage,
        barHeight: viewPadding.bottom > 0 ? barHeightWithNotch : barHeight,
        arcHeight: viewPadding.bottom > 0 ? arcHeightWithNotch : barHeight,
        itemTextOff: viewPadding.bottom > 0 ? 0 : 1,
        itemTextOn: viewPadding.bottom > 0 ? 0 : 1,
        circleOutline: 15.0,
        shadowAllowance: 0.0,
        circleSize: 50.0,
        blurShadowRadius: 50.0,
        circleColor: Colors.indigo,
        activeIconColor: Colors.white,
        inactiveIconColor: Colors.grey,
        tabs: getTabsData(),
        onTabChangedListener: (index) {
          if (index == 0) {
            setState((){
            currentPage=0;
            });
          } else if (index == 1) {
            setState((){
              currentPage=1;
            });
          } else if (index == 2) {
            setState((){
              currentPage=2;
            });
          } else if (index == 3) {
            setState((){
              currentPage=3;
            });
          }
        },
      ),
    );
  }

  getBody(var patientData, int currentPage, var data) {
    switch (currentPage) {
      case 0:
        return const HomeTab();
      case 1:
        return const WorkTab();
      case 2:
        return const MessageTab();
        break;
      case 3:
        return const ProfileTab();
    }
  }
}

List<TabData> getTabsData() {
  return [
    TabData(
      icon: Icons.home,
      iconSize: 25.0,
      title: 'Home',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.library_books,
      iconSize: 25,
      title: 'Work',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.mark_email_unread_sharp,
      iconSize: 25,
      title: 'Message',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
    TabData(
      icon: Icons.perm_identity,
      iconSize: 25,
      title: 'Profile',
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ];
}

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Home',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Appointment',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Search extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Earning',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class Alarm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text(
          'Profile ',
          style: TextStyle(
            fontSize: 30.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
