import 'package:flutter/material.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

class UrlConverter extends StatefulWidget {
  const UrlConverter({Key? key}) : super(key: key);

  @override
  _UrlConverterState createState() => _UrlConverterState();
}

class _UrlConverterState extends State<UrlConverter> {
  TextEditingController controller = TextEditingController();
  String text = "converted Url will be show here";

  getDataApi() async {
    final response = await http.post(Uri.parse("https://cleanuri.com/api/v1/shorten"),
      body:
        {
          'url': controller.text
        }
    );
    var jsonResponse =
    convert.jsonDecode(response.body) as Map<String, dynamic>;
    // var result =jsonDecode(response.body);
    setState(() {
      text = jsonResponse['result_url'];
    });
    print(jsonResponse);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Url Converter"),),

      body:
      Column(
        children: [
          SizedBox(height: 20,),
          TextField(
            controller: controller,
            decoration: InputDecoration(
              labelText: ("Enter the long URl"),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
          ),
          SizedBox(height: 20,),
          ElevatedButton(onPressed: (){
            getDataApi();
          }, child: Text("Convert URL")),

      SelectableText(text)
        ],
      ),
    );
  }
}
