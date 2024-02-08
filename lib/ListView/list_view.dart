import 'package:flutter/material.dart';

class ListView extends StatefulWidget {
  const ListView({ super.key });

  @override
  State<ListView> createState() => _ListView();
}

class _ListView extends State<ListView> {
  @override
  Widget build(BuildContext context) {
    return Container(color: Color.fromARGB(255, 59, 113, 127));
  }
}