import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:http/http.dart' as http;
import 'package:task_app/color.dart';

void main() {
  initializeDateFormatting().then((_) => runApp(MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List users = [];
  bool isLoading = false;
  bool _checkbox1 = false;
  bool _checkbox2 = false;
  bool _checkbox3 = false;
  bool _checkbox4 = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }

  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = Uri.parse("https://randomuser.me/api/?results=50");
    var response = await http.get(url);
    // print(response.body);
    if (response.statusCode == 200) {
      var items = json.decode(response.body)['results'];
      setState(() {
        users = items;
        isLoading = false;
      });
    } else {
      users = [];
      isLoading = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            title: Text('TabBar Widget'),
            bottom: TabBar(
              tabs: <Widget>[
                Tab(
                    text: 'Appointement',
                    icon: Icon(Icons.calendar_today_sharp)),
                Tab(text: 'Contacts', icon: Icon(Icons.contacts)),
                Tab(text: 'Notes', icon: Icon(Icons.note_sharp)),
                Tab(text: 'Tasks', icon: Icon(Icons.fact_check)),
              ],
            ),
          ),
          body: TabBarView(children: <Widget>[
            Center(
              child: TableCalendar(
                locale: 'en_US',
                firstDay: DateTime.utc(2010, 10, 16),
                lastDay: DateTime.utc(2030, 3, 14),
                focusedDay: DateTime.now(),
              ),
            ),
            Center(
              child: getBody(),
            ),
            Center(child: Text('It\'s notes here')),
            Center(
              child: gettask(),
            ),
          ]),
        ));
  }

  Widget getBody() {
    if (users.contains(null) || users.length < 0 || isLoading) {
      return Center(
          child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primary),
      ));
    }
    return ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return getCard(users[index]);
        });
  }

  Widget getCard(item) {
    var fullName = item['name']['title'] +
        " " +
        item['name']['first'] +
        " " +
        item['name']['last'];
    var email = item['email'];
    var profileUrl = item['picture']['large'];
    return Card(
      elevation: 1.5,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListTile(
          title: Row(
            children: <Widget>[
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    color: primary,
                    borderRadius: BorderRadius.circular(60 / 2),
                    image: DecorationImage(
                        fit: BoxFit.cover, image: NetworkImage(profileUrl))),
              ),
              SizedBox(
                width: 20,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                      width: MediaQuery.of(context).size.width - 140,
                      child: Text(
                        fullName,
                        style: TextStyle(fontSize: 17),
                      )),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    email.toString(),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget gettask() {
    return Column(
      children: [
        Row(
          children: [
            Checkbox(
              value: _checkbox1,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _checkbox1 = true;
                  } else {
                    _checkbox1 = false;
                  }
                });
              },
            ),
            Text('task flutter'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _checkbox2,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _checkbox2 = true;
                  } else {
                    _checkbox2 = false;
                  }
                });
              },
            ),
            Text('sql server task'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _checkbox3,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _checkbox3 = true;
                  } else {
                    _checkbox3 = false;
                  }
                });
              },
            ),
            Text('api task'),
          ],
        ),
        Row(
          children: [
            Checkbox(
              value: _checkbox4,
              onChanged: (value) {
                setState(() {
                  if (value) {
                    _checkbox4 = true;
                  } else {
                    _checkbox4 = false;
                  }
                });
              },
            ),
            Text('git task'),
          ],
        ),
      ],
    );
  }

  void onChanged(bool value) {
    Fluttertoast.showToast(
        msg: "This is task sceen",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }
}
