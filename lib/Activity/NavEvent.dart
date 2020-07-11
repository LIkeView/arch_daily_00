import 'dart:convert';

import 'package:arch_daily/Model/ApiResponse.dart';
import 'package:arch_daily/Model/ListEvent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:http/http.dart' as http;

List data;

class NavEvent extends StatefulWidget {



  @override

  _NavEventState createState() => _NavEventState();
}

class _NavEventState extends State<NavEvent>{


  final String url = "http://www.eatfresh.cc/arch_daily/api/listOfEvent";
  List data;
  var  newdata;

  @override
  void initState(){
    super.initState();
    this.getJsonData();
  }

  Future<String> getJsonData() async{
    var response = await http.post(
      // Encode the url
        Uri.encodeFull(url), body: data
      //only accept json response
      //headers: {"Accept": "application/json"}
    );

    if(response.statusCode == 200) {
      print(response.body);


      setState(() {
        var convertDataToJson = json.decode(response.body);
//     data = convertDataToJson['res_data'];

        data = convertDataToJson["res_data"]["list_event"];
      });

    }

    return "Success";
  }

  Widget build(BuildContext context){
    return
      Scaffold(
        appBar: AppBar(
          title: Text("Arch Daily"),
        ),
        body: new ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, int index){
              return
                Container(
                  color: Colors.white,
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(40),
                                  child: Image(
                                    image: NetworkImage(data[index]['main_banner_path']),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(data[index]['event_name'],style: TextStyle
                                  (
                                    fontSize: 20.00
                                ),),
                              ],
                            ),
                            IconButton(
                              icon: Icon(SimpleLineIcons.options),
                              onPressed: () {},
                            ),
                          ],
                        ),
                      ),

                      FadeInImage(
                        image: NetworkImage(data[index]['main_banner_path']),
                        placeholder: AssetImage("assets/placeholder.png"),
                        width: MediaQuery.of(context).size.width,

                      ),



                      Container(
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        child: RichText(
                          softWrap: true,
                          overflow: TextOverflow.visible,
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "Liked By ",
                                style: TextStyle(color: Colors.black),
                              ),
                              TextSpan(
                                text: "Dhruv,",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: " Yash,",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: " Dk",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                              TextSpan(
                                text: " and",
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: " 1263 others",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ],
                          ),
                        ),
                      ),

                      // caption
//                    Container(
//                      width: MediaQuery.of(context).size.width,
//                      margin: EdgeInsets.symmetric(
//                        horizontal: 14,
//                        vertical: 5,
//                      ),
//                      child: RichText(
//                        softWrap: true,
//                        overflow: TextOverflow.visible,
//                        text: TextSpan(
//                          children: [
//                            TextSpan(
//                              text: posts[i].username,
//                              style: TextStyle(
//                                  fontWeight: FontWeight.bold,
//                                  color: Colors.black),
//                            ),
//                            TextSpan(
//                              text: " ${posts[i].caption}",
//                              style: TextStyle(color: Colors.black),
//                            ),
//                          ],
//                        ),
//                      ),
//                    ),

                      // post date
                      Container(
                        margin: EdgeInsets.symmetric(
                          horizontal: 14,
                        ),
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Febuary 2020",
                          textAlign: TextAlign.start,
                          style: TextStyle(
                            color: Colors.grey,
                          ),
                        ),
                      ),
                    ],
                  ),
                );

//            new Container(
//              child: new Center(
//                child: new Column(
//                  crossAxisAlignment: CrossAxisAlignment.stretch,
//                  children: <Widget>[
//                    new Card(
//                      child: new Container(
//                        child: new Text(data[index]['user_name']),
//                        padding: const EdgeInsets.all(20.0),
//                      ),
//                    )
//                  ],
//                ),
//              ),
//            );
            }
        ),
      );
  }
}