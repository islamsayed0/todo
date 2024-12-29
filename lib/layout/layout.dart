import 'package:flutter/material.dart';
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
bool shetStat = false;
IconData floticon = Icons.add;
var kay = GlobalKey<ScaffoldState>();
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
          Navigator.pop(context);
          shetStat = false;
          setState(() {
            floticon=Icons.add;
          });

        }else {
          kay.currentState?.showBottomSheet(
                  (builder) =>
              Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    color: Colors.grey[100],
                    padding: EdgeInsets.all(20),
                    child: TextFormField(
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
                  )
                ],
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
