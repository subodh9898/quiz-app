import 'dart:convert';

import 'package:flutter/material.dart';

class JsonText extends StatefulWidget {
  const JsonText({Key? key}) : super(key: key);

  @override
  State<JsonText> createState() => _JsonTextState();
}

class _JsonTextState extends State<JsonText> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(" Json to List Demo"),
      ),
      body: FutureBuilder(
        future: DefaultAssetBundle.of(context)
            .loadString("images/qnatest1.json", cache: true),
        builder: (context, snapshot) {
          if (snapshot.data != null) {
            Map mydata = json.decode((snapshot.data.toString()));
            // print(mydata);
            return ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mydata.toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mydata['gk'].toString()),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(mydata['iq'].toString()),
                ),
                Container(
                  height: 400,
                  color: Colors.red,
                  child: ListView.builder(
                      itemCount: mydata['gk'].length,
                      itemBuilder: (context, index) {
                        return Text(mydata['gk']['${index + 1}'].toString());
                      }),
                )
              ],
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
