import 'package:buzzer/components/textstyle/font.dart';
import 'package:buzzer/pages/settings/components/ServerSettingsComponent.dart';
import 'package:flutter/material.dart';

class SettingsRoute extends StatelessWidget {
  static const String route = "/settings";

  const SettingsRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return const SettingsPage();
  }
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            _buildUpperBackground(),
            ListView(children: [_buildAppInfo(), ServerSettingsComponent()]),
          ],
        ));
  }

  Widget _buildUpperBackground(){
     return Container(
      height: 160,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.deepPurpleAccent],
        ),
      ),
    );
  }

  Widget _buildAppInfo() {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.deepPurple, Colors.deepPurpleAccent])),
      height: 160,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Buzz it",
                style: BuzzerTextStyle.bigRubik.copyWith(color: Colors.white)),
            Text("An open-source buzzer system", style: BuzzerTextStyle.mediumRubik.copyWith(color: Colors.white)),
            const Spacer(),
            Text("Version 1.0.0", style: BuzzerTextStyle.mediumRubik.copyWith(color:Colors.white), )
          ],
        ),
      ),
    );
  }
}
