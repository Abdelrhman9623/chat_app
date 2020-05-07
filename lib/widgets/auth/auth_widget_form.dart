import 'dart:io';

import 'package:chat_app/widgets/pickers/user_image_pickers.dart';
import 'package:flutter/material.dart';
class AuthForm extends StatefulWidget {
  AuthForm(this.submitFn, this.isLoading);
  final bool isLoading;
  final void Function(
    String email,
    String username,
    String password,
    bool isLogin,
    File image,
    BuildContext context,
  ) submitFn;
  @override
  _AuthFormState createState() => _AuthFormState();
}
class _AuthFormState extends State<AuthForm> {
  final _formKey = GlobalKey<FormState>();
  var _isLogin = true;
  String _emailAdress = '';
  String _userName = '';
  String _password = '';
  File _userImageFile;
  void _pickedImage(File image) {
    _userImageFile = image;
  }
  void _trySubmit() {
  final isValid = _formKey.currentState.validate();
  FocusScope.of(context).unfocus();
  if(_userImageFile == null && !_isLogin) {
    Scaffold.of(context).showSnackBar(
      SnackBar(
        content: Text('Please Pick Your Image'),
      ),
    );
    return;
  }
  if (isValid) {
    _formKey.currentState.save();
    widget.submitFn(
      _emailAdress.trim(),
      _userName.trim(),
      _password.trim(),
      _isLogin,
      _userImageFile,
      context,
    );
    // print(_userName);
    // send this data to server
  }
}
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        margin: const EdgeInsets.all((15)),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                 if(!_isLogin) 
                  ImagePickeruser(
                    _pickedImage
                  ), 
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      key: ValueKey('email'),
                      validator: (val) {
                        if(val.isEmpty || !val.contains('@')) {
                          return 'Please Enter Your Valid Email Adress .. ';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        labelText: 'Email Address'
                      ),
                      onSaved: (val) {
                        _emailAdress = val;
                      },
                    ),
                  ),
                  if(!_isLogin)
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      key: ValueKey('username'),
                      validator: (val) {
                        if(val.isEmpty || val.length < 4) {
                          return 'Please Enter at lest 4 characters';
                        }
                        return null;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'username'
                      ),
                      onSaved: (val) {
                        _userName = val;
                      },
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    child: TextFormField(
                      key: ValueKey('password'),
                      validator: (val) {
                        if(val.isEmpty || val.length <= 7) {
                          return 'Please Enetr Your Valid Password at lest 8 characters log';
                        }
                        return null;
                      },
                      obscureText: true,
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                        labelText: 'Password',
                      ),
                      onSaved: (val) {
                        _password = val;
                      },
                    ),
                  ),
                  SizedBox(height: 15,),
                  widget.isLoading ? 
                  Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Color(0xffe8e8e8),
                    ),
                  ) :
                  RaisedButton(
                    child: Text(
                      _isLogin ?
                      'login'.toUpperCase() :
                      'signup'.toUpperCase()
                    ),
                    onPressed: _trySubmit,
                  ),
                  FlatButton(
                    textColor: Theme.of(context).primaryColor,
                    child: Text(
                      _isLogin ?
                      'creat new account'.toUpperCase() : 'I have already acount'.toUpperCase(),
                    ),
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}