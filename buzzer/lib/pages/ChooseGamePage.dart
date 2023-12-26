import 'package:buzzer/components/buttons/BigButton.dart';
import 'package:buzzer/components/buttons/OneLineIconTextButton.dart';
import 'package:buzzer/components/buttons/TwoLineBigButton.dart';
import 'package:buzzer/components/transitions/SlideTransition.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:google_fonts/google_fonts.dart';

class ChooseGamePage extends StatefulWidget {
  const ChooseGamePage({super.key});

  @override
  State<ChooseGamePage> createState() => _ChooseGamePageState();
}

class _ChooseGamePageState extends State<ChooseGamePage>
    with SingleTickerProviderStateMixin {
  AnimationController? animationController;

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 300), vsync: this);

    animationController!.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(children: [
      Column(
        children: [
          _buildUpperBackground(),
          Expanded(
              child: Image(
            color: Colors.deepPurpleAccent.withOpacity(0.2),
            image: Svg("assets/images/background_image.svg",
                color: Colors.deepPurpleAccent),
            repeat: ImageRepeat.repeat,
          )),
          _buildBottomBackground()
        ],
      ),
      SafeArea(
          child: 
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildIntro(),
              _buildPlayerInfo(),
              Expanded(
                child: InternalSlideTransition(
                  
                  animationController: animationController!,
                  children: [
                    Column(children:[
                      Spacer(),
                      _buildCreateGameButton(),
                const SizedBox(height: 40),
                _buildJoinGameButton(),
                const Spacer(),
                _buildInventoryAndSettings(),
                const SizedBox(height: 20),
                    ]),
                    Column(children:[
                      Spacer(),
                      _buildCreateGameButton(),
                const SizedBox(height: 40),
                _buildJoinGameButton(),
                const Spacer(),
                _buildInventoryAndSettings(),
                const SizedBox(height: 20),
                    ]),
                  ]),
              )
        ],
      ))
    ]));
  }

  Widget _buildIntro() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("BIEN LE BONJOUR !",
                style: GoogleFonts.rubik(
                    textStyle: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 20,
                        fontWeight: FontWeight.w600))),
            Text("ET SI ON JOUAIT ?",
                style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.w600))),
          ],
        )
      ]),
    );
  }

  Widget _buildUpperBackground() {
    return Container(
      height: 220,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [Colors.deepPurple, Colors.deepPurpleAccent],
        ),
      ),
    );
  }

  Widget _buildPlayerInfo() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: BigButton(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(children: [
              ClipRRect(
                  borderRadius: BorderRadius.circular(30),
                  child: Image.network(
                    "https://avatars.githubusercontent.com/u/30233189?v=4",
                    width: 60,
                    height: 60,
                    fit: BoxFit.cover,
                  )),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Pseudo",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600))),
                  Text("Le magicien",
                      style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w600))),
                ],
              )
            ]),
          ),
          onPressed: () {}),
    );
  }

  Widget _buildCreateGameButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TwoLineBigButton(
            firstLine: "CRÉER",
            secondLine: "UN SALON ET RECEVOIR UN CODE",
            icon: Icons.add,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)),
            onPressed: () {
              setState(() {
                animationController!.forward();
              });
            }));
  }

  Widget _buildJoinGameButton() {
    return Padding(
        padding: const EdgeInsets.only(right: 16.0),
        child: TwoLineBigButton(
            firstLine: "REJOINDRE",
            secondLine: "UN SALON AVEC UN CODE",
            icon: Icons.send,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(20),
                topRight: Radius.circular(20)),
            onPressed: () {
              setState(() {
                animationController!.reverse();
              });
            }));
  }

  Widget _buildInventoryAndSettings() {
    return Row(
      children: [
        Expanded(child: _buildInventoryButton()),
        Expanded(child: _buildSettingsButton())
      ],
    );
  }

  Widget _buildInventoryButton() {
    return Padding(
        padding: const EdgeInsets.only(left: 16, right: 8.0),
        child: OneLineIconTextButton(
            colors: [Colors.deepPurple, Color.fromARGB(255, 113, 67, 219)],
            iconBackgroundColor: Colors.deepPurpleAccent,
            icon: Icons.badge,
            onPressed: () {},
            text: "INVENTAIRE"));
  }

  Widget _buildSettingsButton() {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 16.0),
        child: OneLineIconTextButton(
            colors: [
              const Color.fromARGB(255, 113, 67, 219),
              Colors.deepPurpleAccent
            ],
            iconBackgroundColor: Colors.deepPurpleAccent,
            icon: Icons.settings,
            onPressed: () {},
            text: "PARAMÈTRES"));
  }

  Widget _buildBottomBackground() {
    return Container(
      height: 0,
      decoration: const BoxDecoration(color: Colors.deepPurpleAccent),
    );
  }
}
