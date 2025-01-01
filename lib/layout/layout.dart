import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/module/DoneTask/donetask.dart';
import 'package:todo/module/archive/archive.dart';

import '../module/todo/todo.dart';

class layout extends StatefulWidget {
  const layout({super.key});

  @override
  State<layout> createState() => _layoutState();
}
var inde=0;
List page = [
  todo(),
  donetask(),
  archive(),
];
List N_Bar = [
  'Todo',
  'Done tasl',
  'archive',
];
var titleControl =  TextEditingController();
var timecont =  TextEditingController();
var daetcont =  TextEditingController();
bool shetStat = false;
IconData floticon = Icons.add;
var kay = GlobalKey<ScaffoldState>();
var Formkay = GlobalKey<FormState>();
Database? database;
class _layoutState extends State<layout> {
  @override
  void initState() {
    super.initState();
    CreateDataBase();
  }
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      key: kay,
      appBar: AppBar(
        title: Text(
          '${N_Bar[inde]}'
          ,style: TextStyle(
          fontSize: 30,
        ),
        ),
      ),
      body: page[inde],
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(shetStat){
          if(Formkay.currentState!.validate()){
            Navigator.pop(context);
            shetStat = false;
            setState(() {
              floticon=Icons.add;
            });
          }


        }else {
          kay.currentState?.showBottomSheet(
                  (builder) =>
              Container(
                color: Colors.grey[100],
                padding: EdgeInsets.all(20),
                child: Form(
                  key: Formkay,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        validator: (v){
                          if(v==null||v.isEmpty){
                            return "Title must be added";
                          }
                          return null;
                        },
                        controller: titleControl,
                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('title'),
                          prefixIcon: Icon(Icons.title)
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(

                        controller: timecont,
                        onTap: (){
                          FocusScope.of(context).requestFocus(FocusNode());
                          showTimePicker(context: context, initialTime: TimeOfDay.now()).then((onValue){
                            timecont.text=onValue!.format(context).toString();
                          });
                        },
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            // Return a message instead of printing
                            return "Time must be added";
                          }
                          return null; // Return null if validation is successful
                        },
                        decoration: InputDecoration(

                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              width: 1,color: Colors.deepPurple,
                            ),
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          label: Text('Task time'),
                          prefixIcon: Icon(Icons.watch_later),
                        ),
                      ),
                      SizedBox(height: 20,),
                      TextFormField(
                        controller: daetcont,
                        onTap: (){
                          FocusScope.of(context).requestFocus(FocusNode());

                          showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                    lastDate:DateTime.now().add(Duration(days: 365*100)),
                              ).then((onValue){
                                print(DateFormat.yMMMMd().format(onValue!));
                                daetcont.text=DateFormat.yMMMMd().format(onValue!);
                              });
                        },
                        validator: (v) {
                          if (v == null || v.isEmpty) {
                            // Return a message instead of printing
                            return "Date must be added";
                          }
                          return null; // Return null if validation is successful
                        },
                        decoration: InputDecoration(

                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,color: Colors.deepPurple,
                              ),
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                            label: Text('Task Date'),
                            prefixIcon: Icon(Icons.date_range)
                        ),
                      ),
                    ],
                  ),
                ),
              )
          );
          setState(() {
            floticon=Icons.edit;
          });
          //insertToDatabase();
          shetStat = true;
        }
      }
        ,child:
          Icon(
            floticon,
          )

        ),

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: inde,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.add),
            label: 'todo',

          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.done),
            label: 'done task',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            label: 'archive',
          ),
        ],
      ),

    );
  }
  void CreateDataBase() async{
   database = await openDatabase(
    'todo.db',
    version: 1,
    onCreate: (database,version){
    print("database onCreate");
    database.execute(
      'CREATE TABLE todo (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT, status TEXT)'
    ).then((Value){
     print('teable is done');
    }).catchError((onError){
      print(onError);
    });
    },
    onOpen: (database){
      print("open done");
    }
  );
  }
  void insertToDatabase(){
    database?.transaction((action)
    => action.rawInsert('INSERT INTO todo(title,date,time,status) VALUES("w","2","22","d")').then((onValue){
      print("insertDone");
    }).catchError((onError){
    print(onError);
      }));
  }
  void _onItemTapped(int index) {
    setState(() {
      inde = index;
    });
  }
}
