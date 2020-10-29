import 'package:flutter/material.dart';
import 'package:hello_firebase/services/auth.dart';
import 'package:hello_firebase/shared/loading.dart';

class SignIn extends StatefulWidget {
  
  final Function toggleView;
  SignIn({this.toggleView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // text field state
  String email = '';
  String pass = '';
  String error = '';

  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff028090),
        elevation: 0.0,
        title: Center(child:Text('Entrar'),)
      ),
      body: Container(
        padding: EdgeInsets.only(top: 50.0, right: 40.0, left: 40.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Email',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Color(0xff00A896), width: 2.0)
                  ),
                ),
                validator: (val)=> val.isEmpty ? 'Introduce un email.' : null,
                keyboardType: TextInputType.emailAddress,
                onChanged: (val){
                  setState(() => email = val);
                },
              ),
              SizedBox(height: 20.0,),
              TextFormField(
                decoration: InputDecoration(
                  hintText: 'Contraseña',
                  contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Colors.grey, width: 2.0)
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(32.0),
                    borderSide: BorderSide(color: Color(0xff00A896), width: 2.0)
                  ),
                  
                  suffixIcon: GestureDetector(
                    onTap: () {
                      setState(() {
                        _obscureText = !_obscureText;
                      });
                    },
                    child: Icon(
                      _obscureText ? Icons.visibility : Icons.visibility_off,
                      semanticLabel:
                          _obscureText ? 'show password' : 'hide password',
                      color: Colors.grey,
                    ),
                  ),
                ),
                validator: (val)=> val.length < 6 ? 'Introduce una contraseña de +6 carácteres.' : null,
                obscureText: _obscureText,
                onChanged: (val){
                  setState(() => pass = val);
                },
              ),
              SizedBox(height: 20.0,),
              RaisedButton(
                color: Color(0xff00A896),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Text('ENTRAR', style: TextStyle(color: Colors.white),),
                onPressed: () async {
                  if(_formKey.currentState.validate()){
                    setState(() => loading = true);
                    dynamic result  = await _auth.signInWithEmailAndPassword(email, pass);
                    if (result == null){
                      setState(() {
                        error = 'Email o contraseña incorrectos.';
                        loading = false;
                      });
                    }
                  }
                },
              ),

              SizedBox(height: 10.0,),

              Text(error, style: TextStyle(color: Colors.red, fontSize: 15.0),),

              FlatButton(
                onPressed:(){
                  widget.toggleView();
                },
                child: Text('¿Aún no tienes cuenta? Registrate ya.',
                    style: TextStyle(color: Colors.black54)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}