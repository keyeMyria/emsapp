import 'package:flutter/material.dart';


DecorationImage backgroundImage = new DecorationImage(
  image: new ExactAssetImage('assets/login-screen-background.png'),
  fit: BoxFit.cover,
);

TextStyle headingStyle = new TextStyle(
  color: Colors.white,
  fontSize: 22.0,
  fontWeight: FontWeight.bold,
);

ExactAssetImage logo = new ExactAssetImage("assets/logo.png");




//For Appbar Menu
class Choice {
  const Choice({this.title, this.page});

  final String title;
  final String page;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'CHAT', page: '/ChatAlternatePage'),
 // const Choice(title: 'HYDRATION', page: ''),
 // const Choice(title: 'TRAINING', page: ''),
  const Choice(title: 'PROFILE', page: '/ProfilePage'),
  //const Choice(title: 'PROFILE', icon: Icons.menu),

];

const List<Choice> alertChoices = const <Choice>[
  const Choice(title: 'Add Alert', page: '/ChatAlternatePage'),
  

];

class ChoiceCard extends StatelessWidget {
  const ChoiceCard({Key key, this.choice}) : super(key: key);

  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(choice.title, style: textStyle),
          ],
        ),
      ),
    );
  }
}

