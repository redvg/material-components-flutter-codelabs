// Copyright 2018-present the Flutter authors. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
// http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

import 'package:flutter/material.dart';

import 'colors.dart';

class PrimaryColorOverride extends StatelessWidget {

  const PrimaryColorOverride({Key key, this.color, this.child})
      : super(key: key);

  final Color color;
  
  final Widget child;

  @override
  Widget build(BuildContext context) {
    
    return Theme(
      
      child: child,
      
      data: Theme.of(context).copyWith(primaryColor: color),
    );
  }
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {

    final _usernameTextController = TextEditingController();

    final _passwordTextContoroller = TextEditingController();

    return new Scaffold(
      
      body: new SafeArea(
        
        child: new ListView(
          
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          
          children: <Widget>[
            
            const SizedBox(height: 80.0),
            
            new Column(
              
              children: <Widget>[
                
                new Image.asset('assets/diamond.png'),
                
                const SizedBox(height: 16.0),
                
                const Text('SHRINE'),
              ],
            ),
            
            const SizedBox(height: 120.0),

            PrimaryColorOverride(

              color: kShrineBrown900,

              child: TextField(

                        controller: _usernameTextController,
                        
                        decoration: InputDecoration(
                          
                          filled: false,
                          
                          labelText: 'username',)),
            ),
            
            SizedBox(height: 12.0,),

            
            //TODO: wrap in PrimaryColorOverride as per above
            TextField(

              controller: _passwordTextContoroller,
              
              decoration: InputDecoration(
                
                filled: false,
                
                labelText: 'password',),
                
              obscureText: true,),

            ButtonBar(
              
              children: <Widget>[

                FlatButton(

                  shape: BeveledRectangleBorder(

                    borderRadius: BorderRadius.all(Radius.circular(7.0)),
                  ),
                  
                  child: Text('cancel'),
                  
                  onPressed: (){

                    _usernameTextController.clear();

                    _passwordTextContoroller.clear();

                  },),

                RaisedButton(

                  elevation: 10.0,

                  shape: BeveledRectangleBorder(

                    borderRadius: BorderRadius.all(Radius.circular(7.0))
                  ),

                  child: Text('next'),

                  onPressed: (){

                    Navigator.pop(context);
                  },
                ),
              ],)
          ],
        ),
      ),
    );
  }
}
