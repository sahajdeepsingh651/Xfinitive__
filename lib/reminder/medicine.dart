import 'package:flutter/material.dart';

import 'package:xfinitive/reminder/global_bloc.dart';

import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

import 'package:xfinitive/reminder/pages/Medcine.dart';

class ReminderScreen extends StatefulWidget {
  const ReminderScreen({Key? key}) : super(key: key);

  @override
  State<ReminderScreen> createState() => _ReminderScreenState();
}

class _ReminderScreenState extends State<ReminderScreen> {
  late GlobalBloc globalBloc;

  @override
  void initState() {
    super.initState();
    globalBloc = GlobalBloc();
  }

  @override
  void dispose() {
    globalBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('ReminderScreen');
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: Sizer(
        builder: (context, orientation, deviceType) {
          return const Scaffold(
            body: ReminderPage(),
          );
        },
      ),
    );
  }
}
