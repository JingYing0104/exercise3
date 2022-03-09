import 'dart:async';
import 'package:flutter/material.dart';
import 'course.dart';
import 'package:http/http.dart';
import 'dart:convert';

//@dart=2.9

Future<List<Course>> fetchCourse() async{
  Response response = await get('https://jsonplaceholder.typicode.com/todos/');
 List<Course> list = (json.decode(response.body) as List).map((e) => Course.fromJson(e)).toList();
 return list;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Exercise2',
      home:  MyHomePage(title: 'My Courses'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _selectedIndex = 0;

 late Future<List<Course>> futureCourse;

  @override
  void initState() {
    super.initState();
    futureCourse = fetchCourse();

  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title,
            style: TextStyle(
              color: Color(0xff6C6A73),
              fontSize: 16.0,
              fontFamily: 'Lato',
              fontWeight: FontWeight.normal,
            )
        ),
        backgroundColor: Colors.white,
      ),
      body: Center(
      child: FutureBuilder<List<Course>>(
      future: futureCourse,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Course>? courses = snapshot.data;
          return new ListView(
            children: courses!.map((e) => Column(
              children: <Widget>[
                new ListTile(
                  leading: Text(e.id.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Lato',
                      color: Color(0xff66C6A73),
                    ),
                  ),
                    title: Text(e.title,
                      style: TextStyle(
                          fontSize: 20.0,
                          fontFamily: 'Lato',
                          fontWeight: FontWeight.normal,
                          color: Color(0xff6C6A73)
                      ),
                    ),
                  subtitle: Text("Completed: "+e.completed.toString(),
                    style: TextStyle(
                      fontSize: 15.0,
                      fontFamily: 'Lato',
                      color: Color(0xff66C6A73),
                    ),
                  ),
                )
              ],
            )).toList()
          );
        } else if (snapshot.hasError) {
          return Text('${snapshot.error}');
        }

        // By default, show a loading spinner.
        return const CircularProgressIndicator();
      },
      ),
      ),

      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.menu_book_sharp),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings_outlined),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
