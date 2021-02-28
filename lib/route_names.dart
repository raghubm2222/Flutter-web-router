import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('Hello HOme'),
      ),
    );
  }
}

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text('About page'),
      ),
    );
  }
}

class Notfound extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Text(
          'ERROR 404',
          style: TextStyle(
              fontSize: 50, fontWeight: FontWeight.bold, wordSpacing: 2),
        ),
      ),
    );
  }
}
