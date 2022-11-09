import 'package:flutter/material.dart';

class WorkTab extends StatefulWidget {
  const WorkTab({Key? key}) : super(key: key);

  @override
  State<WorkTab> createState() => _WorkTabState();
}

class _WorkTabState extends State<WorkTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Center(child: Text('Work Tab'),),);
  }
}
