import 'package:flutter/material.dart';
import 'package:untitled1/net_utils.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Room Light Control',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Room Light Control'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Builder(
          builder: (context) {
            return Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child:
                        Text("ON LIGHT", style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();

                      NetUtils.get("http://192.168.50.240/on").then((resp) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("LIGHT IS ON.")));
                      }).catchError((e) {
                        print(e);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("ERROR." + e.toString())));
                      });
                    },
                    color: Color.fromARGB(255, 64, 158, 255),
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 20),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  RaisedButton(
                    child: Text("OFF LIGHT",
                        style: TextStyle(color: Colors.white)),
                    color: Color.fromARGB(255, 245, 108, 108),
                    onPressed: () {
                      Scaffold.of(context).hideCurrentSnackBar();
                      NetUtils.get("http://192.168.50.240/off").then((resp) {
                        Scaffold.of(context).showSnackBar(
                            SnackBar(content: Text("LIGHT IS OFF.")));
                      }).catchError((e) {
                        print(e);
                        Scaffold.of(context)
                            .showSnackBar(SnackBar(content: Text("ERROR."+ e.toString())));
                      });
                    },
                    padding: EdgeInsets.only(
                        left: 30, right: 30, top: 20, bottom: 20),
                  ),
                ],
              ),
            );
          },
        ));
  }
}
