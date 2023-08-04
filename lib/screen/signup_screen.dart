import 'package:AdvertiseMe/firebase/adrepository.dart';
import 'package:AdvertiseMe/firebase/authentication.dart';
import 'package:AdvertiseMe/firebase/user_repository.dart';
import 'package:AdvertiseMe/models/user.dart';
import 'package:AdvertiseMe/utils/route_names.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../providers/obscurepasswordprovider.dart';


class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp)
    {
      Provider.of<ObscurePasswordProvider>(context,listen: false).obscurepassword=true;
    }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 20.0),
        alignment: Alignment.center,
        child: SingleChildScrollView(
          child:Form(
    key: _formKey,child :Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 240,
                child: SvgPicture.asset(
                  'lib/assets/signup.svg',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name.';
                  }
                  // You can add more complex validation checks if needed.
                  return null; // Return null if the input is valid.
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email.';
                  }
                  // You can add more complex validation checks if needed.
                  return null; // Return null if the input is valid.
                },
              ),
              SizedBox(height: 10),
              Selector<ObscurePasswordProvider,bool>(selector: (p0, p1) => p1.obscurepassword,
                  builder: (context,obscurePassword,child) {
                  return TextFormField(
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password.';
                      }
                      // You can add more complex validation checks if needed.
                      return null; // Return null if the input is valid.
                    },
                  );
                }
              ),
              SizedBox(height: 20),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      String name = _nameController.text;
      String email = _emailController.text;
      String password = _passwordController.text;
      try {
        UserModel user = UserModel(name, email, '','','');
        FirebaseAuthModel firebaseauth = FirebaseAuthModel();
        User? user1 = await firebaseauth
            .signUpWithEmailAndPassword(email, password);
        UserRepository userrepository = UserRepository();
        userrepository.registerUser(user);
        if (user1 != null) {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Signup Success')));
        }
      }
      catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$e')));
      }
    }
                  },
                  child: Text('Signup'),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Already have an account?'),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Login'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ));
  }
}

