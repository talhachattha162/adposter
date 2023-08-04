import 'package:AdvertiseMe/providers/obscurepasswordprovider.dart';
import 'package:AdvertiseMe/screen/view_ad_screen.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../firebase/authentication.dart';





class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    try {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        Provider
            .of<ObscurePasswordProvider>(context, listen: false)
            .obscurepassword = true;
        check();
      });
    }
    catch(e){

    }
  }



check()  {
  FirebaseAuthModel firebaseAuthModel=FirebaseAuthModel();
  if(firebaseAuthModel.getCurrentUser()!.uid!=null){
    Navigator.pushNamedAndRemoveUntil(context, RouteNames.home,(route) => false,);
  }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 250,
                  child: SvgPicture.asset(
                    'lib/assets/login.svg',
                  ),
                ),
                SizedBox(height: 20),
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email.';
                    }
                    // You can add more complex validation checks if needed.
                    return null; // Return null if the input is valid.
                  },
                  keyboardType: TextInputType.emailAddress,
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                ),
                SizedBox(height: 10),
                Selector<ObscurePasswordProvider,bool>(selector: (p0, p1) => p1.obscurepassword,
                  builder: (context,obscurePassword,child) {
                    return TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your password.';
                        }
                        return null; // Return null if the input is valid.
                      },
                      controller: _passwordController,
                      obscureText: obscurePassword,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        prefixIcon: Icon(Icons.lock),
                        suffixIcon: IconButton(
                          icon: Icon(
                            obscurePassword ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            Provider.of<ObscurePasswordProvider>(context,listen: false).obscurepassword=!Provider.of<ObscurePasswordProvider>(context,listen: false).obscurepassword;

                          },
                        ),
                      ),
                    );
                  }
                ),
                SizedBox(height: 30),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () async {
    if (_formKey.currentState!.validate()) {
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        FirebaseAuthModel firebaseauth = FirebaseAuthModel();
        User? user1 = await firebaseauth
            .signInWithEmailAndPassword(email, password);
        if (user1 != null) {
          Navigator.pushNamedAndRemoveUntil(context, RouteNames.home,(route) => false,);
        }
      }
      catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e')));
      }
    }
                    },

                    child: Text('Signin'),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, RouteNames.signup);
                      },
                      child: Text('Sign up',style: TextStyle(fontSize:13 ),),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
