import 'package:flutter/material.dart';

class archive extends StatefulWidget {
  const archive({super.key});

  @override
  State<archive> createState() => _archiveState();
}

class _archiveState extends State<archive> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('archive',style: TextStyle(
        fontSize: 45,
      ),),
    );
  }
}
