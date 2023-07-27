import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late int a;
  late List<String> _items;
  @override
  void initState() {
    super.initState();
    a = Random().nextInt(5) + 2; // Số lượng phần tử từ 2 đến 6.
    _items = List.generate(a * a, (index) {
      if (index == a * a - 1) {
        return '';
      } else {
        return (index + 1).toString();
      }
    });
    _items.shuffle();
  }

  void _changeIndex(int i) {
    int _emptyIndex = _items.lastIndexOf('');
    int _perviousItem = i - 1;
    int _nextItem = i + 1;
    int _perviousRow = i - a;
    int _nextRow = i + a;
    if (_emptyIndex == _perviousItem) {
      _items[_perviousItem] = _items[i];
      _items[i] = '';
    } else if (_emptyIndex == _nextItem) {
      _items[_nextItem] = _items[i];
      _items[i] = '';
    } else if (_emptyIndex == _perviousRow) {
      _items[_perviousRow] = _items[i];
      _items[i] = '';
    } else if (_emptyIndex == _nextRow) {
      _items[_nextRow] = _items[i];
      _items[i] = '';
    }
    if (checkWin()) {
      handleWin();
    }
    setState(() {});
  }

  bool checkWin() {
    print(_items);
    bool result = true;
    for (int i = 0; i < _items.length - 1; i++) {
      if (_items[i] != (i + 1).toString()) {
        result = false;
        break;
        // return false;
      }
    }
    print(result);
    return result;
  }

  void handleWin() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Congratulations!"),
          content: Text("You have completed the puzzle!"),
          actions: [
            TextButton(
              child: Text("Play Again"),
              onPressed: () {
                setState(() {
                  a = Random().nextInt(5) + 2;
                  _items = List.generate(a * a, (index) {
                    if (index == a * a - 1) {
                      return '';
                    } else {
                      return (index + 1).toString();
                    }
                  });
                  _items.shuffle();
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: AspectRatio(
        aspectRatio: 1,
        child: GridView.count(
          crossAxisCount: a,
          children: [
            for (int i = 0; i < a * a; i++)
              InkWell(
                onTap: () {
                  _changeIndex(i);
                },
                child: Container(
                  margin: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                      color: _items[i].isEmpty ? Colors.white : Colors.blue,
                      borderRadius: BorderRadius.circular(10)),
                  child: Center(
                    child: Text(
                      '${_items[i]}',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
                    ),
                  ),
                ),
              ),
          ],
        ),
      )),
    );
  }
}
