import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'dart:async';
import 'dart:convert';
import 'news.dart';
import 'form.dart';


class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => new _HomePageState();

}
class _HomePageState extends State<HomePage> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?sources=google-news&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson = json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));

      }
    }
    return _list;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  ListTile _buildItemsForListView(BuildContext context, int index) {

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else    if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },

              child:  new ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index)

                  {
                    return new Card(

                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[
                            new Row(
                              children: [
                                Expanded(


                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),
                          ],),
                      ),

                    );
                  }
              ),
            );


          }
        }



    );
  }
}



class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key key}) : super(key: key);

  @override
  _MyTabbedPageState createState() => new _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage> with SingleTickerProviderStateMixin {

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  final List<Tab> myTabs = <Tab>[
    new Tab(text: 'HOME'),
    new Tab(text: 'INDIA'),
    new Tab(text: 'TECHNOLOGY'),
    new Tab(text: 'BUSINESS'),
    new Tab(text: 'SPORTS'),
    new Tab(text: 'ENTERTAINMENT'),
    new Tab(text: 'POLITICS'),


  ];
  List<CustomPopupMenu> choices1 = <CustomPopupMenu>[
    CustomPopupMenu(title: 'HINDI' ),
    CustomPopupMenu(title: 'ENGLISH'),

  ];

  // The app's "state".
  TabController _tabController;




  @override
  void initState() {
    super.initState();
    _tabController = new TabController( vsync: this, length: myTabs.length);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      primary: true,
      key: _scaffoldKey,

      drawer: new Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              new Container(
                  color: Colors.grey,
                  child:Column(
                    children: <Widget>[
                      _createHeader(),
                      Divider(),
                      _createDrawerItem(icon:Icons.home,text: 'HOME',onTap: (){
                        _tabController.animateTo(0);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.language,text: 'INDIA',onTap: (){
                        _tabController.animateTo(1);
                        Navigator.pop(context);
                      }),

                      _createDrawerItem(icon:Icons.lightbulb_outline,text: 'TECHNOLOGY',onTap: (){
                        _tabController.animateTo(2);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.business,text: 'BUSINESS',onTap: (){
                        _tabController.animateTo(3);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.transfer_within_a_station,text:'SPORTS',onTap: (){
                        _tabController.animateTo(4);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.airplay,text: 'ENTERTAINMENT',onTap: (){
                        _tabController.animateTo(5);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.description,text: 'POLITICS',onTap: (){
                        _tabController.animateTo(6);
                        Navigator.pop(context);
                      }),
                      _createDrawerItem(icon:Icons.account_circle_rounded,text: 'LogOut',onTap: (){
                      }),

                    ],
                  )
              ),
            ],
          )
      ),

      appBar: AppBar(
        automaticallyImplyLeading: false,

        bottom: TabBar(
          isScrollable: true,
          indicatorColor: Colors.orange,
          labelPadding: EdgeInsets.only(right:10.0,left: 10.0),
          labelStyle: TextStyle(fontSize: 15),
          controller: _tabController,
          tabs: myTabs,
        ),


        title: const Text('NewsApp' ,style: TextStyle(fontWeight: FontWeight.bold, fontSize: 21 ),),
        backgroundColor: Colors.indigo,
        leading: new IconButton(icon: new Icon(Icons.menu),
            onPressed: () => _scaffoldKey.currentState.openDrawer()),
        actions: <Widget>[
          // action button
          IconButton(

            icon: Icon(choices[0].icon),
            onPressed: () {

            },
          ),
          // action button
          IconButton(
            icon: Icon(choices[1].icon),
            onPressed: () {
            },
          ),
          IconButton(
            icon: Icon(choices[3].icon),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) =>SIForm()));
              // Perform some action
            },),
          PopupMenuButton<CustomPopupMenu>(
            elevation: 3.2,
            initialValue: choices1[1],
            itemBuilder: (BuildContext context) {
              return choices1.map((CustomPopupMenu choice1) {
                return PopupMenuItem<CustomPopupMenu>(
                  value: choice1,
                  child: Text(choice1.title),
                );
              }).toList();
            },
          ),
          // overflow menu
        ],
      ),

      body:TabBarView(

        controller: _tabController,
        children: [

          new Container(



              margin: EdgeInsets.all(10),



              child: HomePage()
          ),
          new Container(
            margin: EdgeInsets.all(10),

            child:
            NewsPage5(),


          ),
          new Container(
            margin: EdgeInsets.all(10),

            child:
            NewsPage3(),


          ),


          new Container(
            margin: EdgeInsets.all(10),

            child:   NewsPage4(),




          ),
          new Container(
            margin: EdgeInsets.all(10),

            child:   NewsPage1(),




          ),
          new Container(
            margin: EdgeInsets.all(10),

            child: NewsPage2(),


          ),
          new Container(
            margin: EdgeInsets.all(10),

            child:    NewsPage5(),




          ),
        ],
      ),


    );
  }
}

class Choice {
  const Choice({this.title, this.icon});

  final String title;
  final IconData icon;
}

const List<Choice> choices = const <Choice>[
  const Choice(title: 'Search', icon: Icons.search ),
  const Choice(title: 'Live_tv', icon: Icons.live_tv),
  const Choice(title: "Contact us",icon: Icons.language),
  const Choice(title: 'Send Feedback',icon: Icons.rate_review),


];
Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}
Widget _createHeader() {
  return DrawerHeader(
      margin: EdgeInsets.zero,
      padding: EdgeInsets.zero,
      child: Stack(children: <Widget>[
        Positioned(
          bottom: 12.0,
          child: Image.asset(
              'images/NewsImage.png',
              width: 300,
              height: 100,
              fit:BoxFit.fill

          ),),
      ]));
}

class NewsPage1 extends StatefulWidget {
  @override
  _NewsPage1State createState() => new _NewsPage1State();

}
class _NewsPage1State extends State<NewsPage1> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?country=in&category=sports&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson=json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else
          if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },
              child:  new ListView.builder(
                  itemCount: 14,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[

                            new Row(
                              children: [
                                Expanded(

                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),


                          ],),
                      ),

                    );
                  }
              ),

            );}
        }



    );
  }}
class NewsPage2 extends StatefulWidget {
  @override
  _NewsPage2State createState() => new _NewsPage2State();

}
class _NewsPage2State extends State<NewsPage2> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?country=in&category=entertainment&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson=json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else
          if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },
              child:  new ListView.builder(
                  itemCount: 14,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[

                            new Row(
                              children: [
                                Expanded(

                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),


                          ],),
                      ),

                    );
                  }
              ),

            );}
        }



    );
  }}
class NewsPage3 extends StatefulWidget {
  @override
  _NewsPage3State createState() => new _NewsPage3State();

}
class _NewsPage3State extends State<NewsPage3> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?country=in&category=technology&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson=json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else
          if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },
              child:  new ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[

                            new Row(
                              children: [
                                Expanded(

                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),


                          ],),
                      ),

                    );
                  }
              ),

            );}
        }



    );
  }}
class NewsPage4 extends StatefulWidget {
  @override
  _NewsPage4State createState() => new _NewsPage4State();

}
class _NewsPage4State extends State<NewsPage4> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?country=in&category=business&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson=json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else
          if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },
              child:  new ListView.builder(
                  itemCount: 10,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[

                            new Row(
                              children: [
                                Expanded(

                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),


                          ],),
                      ),

                    );
                  }
              ),

            );}
        }



    );
  }}
class CustomPopupMenu {
  CustomPopupMenu({this.title, this.icon});

  String title;
  IconData icon;
}
class SelectedOption extends StatelessWidget {
  CustomPopupMenu choice;

  SelectedOption({Key key, this.choice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Icon(choice.icon, size: 140.0, color: Colors.white),
            Text(
              choice.title,
              style: TextStyle(color: Colors.white, fontSize: 30),
            )
          ],
        ),
      ),
    );
  }
}
class NewsPage5 extends StatefulWidget {
  @override
  _NewsPage5State createState() => new _NewsPage5State();

}
class _NewsPage5State extends State<NewsPage5> {
  var index=0;
  final FlutterWebviewPlugin flutterWebviewPlugin = new FlutterWebviewPlugin();
  List<News> _list=new List<News>();
  Future<List<News>> fetchNews() async{
    //Use your own api key if this stops working
    final response=await http.get('https://newsapi.org/v2/top-headlines?country=in&apiKey=8a96e8e475324b6b9ae6b4c45c0c7fb4');
    Map map=json.decode(response.body);
    final responseJson=json.decode(response.body);
    for(int i=0; i<map['articles'].length; i++){
      if(map['articles'][i]['author']!=null){
        _list.add(new News.fromJson(map['articles'][i]));
      }
    }
    return _list;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }
  @override
  Widget build(BuildContext context) {

    return new FutureBuilder(
        future: fetchNews(),
        builder: (BuildContext context, AsyncSnapshot<List<News>> snapshot){
          if(snapshot.data == null) {
            return Container(
              // ignore: missing_return
                child: Center(
                    child: Text("Loading...")
                )
            );
          } else
          if(snapshot.hasData){
            return new Dismissible(
              key:  Key(index.toString()),
              direction: DismissDirection.vertical,
              onDismissed: (direction){
                setState(() {
                  index++;
                });
              },
              child:  new ListView.builder(
                  itemCount: 13,
                  itemBuilder: (BuildContext context, int index) {
                    return new Card(
                      elevation: 1.7,
                      child: new Padding(
                        padding: new EdgeInsets.all(10.0),
                        child: new Column(

                          children: <Widget>[

                            new Row(
                              children: [
                                Expanded(

                                  child: new Image.network(snapshot.data[index].urlToImage,
                                    fit: BoxFit.cover,),

                                ),
                                Expanded(
                                  child: new GestureDetector(
                                    child: new Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        new Padding(
                                          padding: new EdgeInsets.only(
                                              left: 4.0,
                                              right: 8.0,
                                              bottom: 8.0,
                                              top: 8.0),
                                          child: new Text(
                                            '${snapshot.data[index].title}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15,
                                            ),
                                          ),
                                        ),
                                        new Padding(
                                          padding: new EdgeInsets.only(left: 4.0),
                                          child: new Text(
                                            '${snapshot.data[index].publishedAt}',
                                            style: new TextStyle(
                                              fontWeight: FontWeight.w400,

                                              fontSize: 11,

                                            ),
                                          ),
                                        ),
                                      ],),
                                    onTap: () {

                                      flutterWebviewPlugin.launch(
                                        snapshot.data[index].url,
                                      );
                                    },
                                  ),
                                ),
                              ],),


                          ],),

                      ),

                    );
                  }
              ),

            );}
        }

    );
  }}
