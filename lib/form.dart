import 'package:flutter/material.dart';

class SIForm extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {

    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {

  var _currencies = [
    '-Select-',
    'Videos',
    'Program feedback',
    'channel feedback',
    'Other'
  ];
  final double _minimumPadding = 5.0;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Please Comment Your Review'),
      ),

      body: Container(

        margin: EdgeInsets.all(_minimumPadding * 2),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(


                    decoration: InputDecoration(
                        labelText: 'Enter Your name',
                        hintText: 'Name',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  )
              ),

              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        labelText: 'Enter Your Email',
                        hintText: 'Email',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0)
                        )
                    ),
                  )),

              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: Text(
                            "Feedback To", textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 20, color: Colors.black,)),
                      ),

                      Container(width: _minimumPadding * 5,),

                      Expanded(child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,style: TextStyle(),),
                          );
                        }).toList(),

                        value: '-Select-',

                        onChanged: (value) {
                          setState(() => value = value);
                        },

                      ))


                    ],
                  )),
              Padding(
                  padding: EdgeInsets.only(
                      top: _minimumPadding, bottom: _minimumPadding),
                  child: Row(
                    children: <Widget>[

                      Expanded(
                        child: Text("Comment", textDirection: TextDirection.ltr,
                            style: TextStyle(
                              fontSize: 20, color: Colors.black,)),
                      ),


                      Expanded(
                          child: TextFormField(
                            decoration: new InputDecoration(
                              labelText: "Add Your Comment",
                              fillColor: Colors.white,
                              border: new OutlineInputBorder(
                                borderRadius: new BorderRadius.circular(5.0),
                                borderSide: new BorderSide(
                                ),
                              ),
                            ),
                          )
                      ),
                    ],
                  )),
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),

                child: RaisedButton(
                    color: Colors.deepOrange,
                    hoverColor: Colors.blue,
                    child: Text(
                      "SUBMIT",
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.w700),
                    ),
                    elevation: 6.0,
                    onPressed: () => AlertMessage(context),
                    shape: new RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0))
      ),
              ),

              ],
          ),
          ),

          ),
        );

  }
  void AlertMessage(BuildContext context) {
    var alertDialog = AlertDialog(
      title: Text('YOUR RESPONSE'),
      content: const Text('SCUCCESSFULLY SUBMITTED'),
      actions: <Widget>[
        FlatButton(
          child: Text('OK',style: TextStyle(
            fontSize: 20,
          ),),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );

    showDialog(
        context: context,
        builder: (BuildContext context) => alertDialog);
  }
}