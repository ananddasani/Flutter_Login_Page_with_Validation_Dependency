import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';
import 'package:login_validation_using_dependency/login_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //glbal key for form field
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String userPassword = "";

  //function to validate check onPressed
  void validate() {
    if (_formKey.currentState!.validate())
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => LoggedIn()));
    else
      debugPrint("Mistake");
  }

  // create a reusable instance of multivalidator
  final passwordValidator = MultiValidator(
    [
      RequiredValidator(errorText: "Password Can't Be Empty"),
      MaxLengthValidator(15, errorText: "Password Can be of Length 15 Atmost"),
      MinLengthValidator(8,
          errorText: "Password Must be of Atleast 8 Characters"),
      PatternValidator(r'(?=.*?[#?!@$%^&*-_])',
          errorText: "Passwords must have at least one special character")
    ],
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Form Field Validator"),
      ),
      body: Center(
        child: myForm(),
      ),
    );
  }

  Form myForm() {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Email",
              ),
              // validator: EmailValidator(errorText: "Not a valid Email"), //Single validator
              validator: MultiValidator(
                [
                  RequiredValidator(errorText: "Email Can't Be Empty"),
                  EmailValidator(errorText: "Not a Valid Email"),
                ],
              ),

              /*
              CUSTOM VALIDATOR
              validator: (value) {
                if (value!.isEmpty) return "Email is Required";
              },
              */
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Password",
                ),
                obscureText: true,
                validator: passwordValidator
                /*
              CUSTOM VALIDATOR
              validator: (value) {
                if (value!.isEmpty)
                  return "Password can't be empty";
                else if (value.length < 6)
                  return "Password must be of atleast 6 character";
              },
              */
                ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: "Re-Enter Password",
              ),
              onChanged: (_val) => userPassword = _val,
              obscureText: true,
              validator: (val) =>
                  MatchValidator(errorText: "Password Doesn't match")
                      .validateMatch(val!, userPassword),
            ),
          ),
          SizedBox(height: 16),
          MaterialButton(
            color: Colors.blue,
            elevation: 10,
            child: Text("Submit", style: TextStyle(color: Colors.white)),
            onPressed: validate,
          ),
        ],
      ),
    );
  }
}
