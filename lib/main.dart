import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

int _counter = 0;
TextEditingController message = TextEditingController();

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Method Channel Flutter",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.deepPurple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 30,
                ),
                getHeading("Android Message Toast"),
                const SizedBox(
                  height: 20,
                ),
                TextField(
                  controller: message,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    filled: true,
                    fillColor: Colors.deepPurple[200],
                    hintText: 'Type something...',
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 18),
                    prefixIcon: const Icon(
                      Icons.message,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                ElevatedButton(
                  onPressed: () {
                    showToast((message.text.trim() == "") ? "Android Native Toast" : message.text);
                  },
                  child: const Text(
                    "Show Toast",
                    style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 40.0),
                  child: Divider(),
                ),
                getHeading("Show Random number using kotlin"),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        _generateRandomNumber();
                        showToast("Number generated by KOTLIN =  $_counter" );
                      },
                      child: const Text(
                        "Generate number",
                        style: TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Align getHeading(String txt) {
    return Align(
      alignment: Alignment.topLeft,
      child: Text(
        txt,
        style: const TextStyle(
            color: Colors.deepPurple,
            fontWeight: FontWeight.w700,
            fontSize: 20),
      ),
    );
  }

  showToast(String message) {
    var channel = const MethodChannel("example.com/toast");

    channel.invokeMethod("showToast", {"message": message});
  }

  Future<void> _generateRandomNumber() async {
    var channel = const MethodChannel("example.com/number");

    int random;
    try {
      random = await channel.invokeMethod('getRandomNumber');
    } on PlatformException catch (e) {
      random = 0;
    }
    setState(() {
      _counter = random;
    });
  }
}
