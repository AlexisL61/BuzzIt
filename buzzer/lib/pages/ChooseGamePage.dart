import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseGamePage extends StatefulWidget {
  const ChooseGamePage({super.key});

  @override
  State<ChooseGamePage> createState() => _ChooseGamePageState();
}

class _ChooseGamePageState extends State<ChooseGamePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      _buildBackground(),
      SafeArea(
          child: Column(
        children: [Spacer(),_buildCreateGameButton(), Spacer()],
      ))
    ]));
  }

  Widget _buildBackground() {
    return Container(
      height: 300,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.deepPurpleAccent],
        ),
      ),
    );
  }

  Widget _buildCreateGameButton() {
    return Padding(
      padding: const EdgeInsets.only(right:32.0),
      child: BigButton(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(20), topRight: Radius.circular(20)),
          child: Container(
            decoration: BoxDecoration(gradient: LinearGradient(colors: [Colors.deepPurple, Colors.deepPurpleAccent])),
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("CRÉER",
                                    style: GoogleFonts.rubik(textStyle: TextStyle(
                                      color: Colors.white,
                                        fontSize: 30, fontWeight: FontWeight.w600))
                        ),Text("UN SALON ET RECEVOIR UN CODE",
                                    style: GoogleFonts.rubik(textStyle: TextStyle(
                                      color: Colors.white.withOpacity(0.8),
                                        fontSize: 16, fontWeight: FontWeight.w600))),
                          ],
                        ),),
                  Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.deepPurple.withOpacity(0.5)),
                    child: Icon(Icons.add, color: Colors.white,),
                  )
                  
                ],
              ),
            ),
          ),
          onPressed: () {}),
    );
  }
}
