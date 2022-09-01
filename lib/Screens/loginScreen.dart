import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:onwords_invoice/Screens/Customer_Details_Screen.dart';
import 'package:onwords_invoice/Screens/forgot_password_page.dart';
import 'package:shared_preferences/shared_preferences.dart';



FirebaseAuth auth = FirebaseAuth.instance;

class LoginScreenPage extends StatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  State<LoginScreenPage> createState() => _LoginScreenPageState();
}

class _LoginScreenPageState extends State<LoginScreenPage> {
  TextEditingController email = TextEditingController();
  TextEditingController pass = TextEditingController();
  bool isHidden = true;
  late SharedPreferences logData;


  void _togglePasswordView() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  @override
  void dispose() {
    email.dispose();
    pass.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
         height: height*1.0,
         width: width*1.0,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: height*0.10,
              ),
              Center(child: Text("Sign In",style: TextStyle(fontSize: height*0.020,fontWeight: FontWeight.bold),)),
              SizedBox(
                height: height*0.030,
              ),
              Image.asset('assets/login.png',scale: 0.5,),
              Container(
                // color: Colors.black,
                height: height*0.18,
                width: width*0.9,
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    TextField(
                      textInputAction: TextInputAction.next,
                      controller: email,
                      cursorColor: Colors.orange,
                      style: Theme.of(context).textTheme.bodyText2,
                      keyboardType: TextInputType.emailAddress,
                      maxLines: null,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.person_outline,color: Colors.orange,size: 30.0,),
                        enabledBorder : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Email-Id",
                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.014,
                    ),
                    TextField(
                      textInputAction: TextInputAction.done,
                      controller: pass,
                      obscureText: isHidden,
                      cursorColor: Colors.orange,
                      style: Theme.of(context).textTheme.bodyText2,
                      decoration: InputDecoration(
                        icon: const Icon(Icons.lock_outline_rounded,color: Colors.orange,size: 30.0,),
                        suffix: InkWell(
                          onTap: _togglePasswordView,
                          child: Icon(
                            isHidden
                                ? Icons.visibility
                                : Icons.visibility_off, color: Colors.grey,
                          ),
                        ),
                        errorBorder: InputBorder.none,
                        disabledBorder : InputBorder.none,
                         enabledBorder : const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                        border: InputBorder.none ,
                        filled: true,
                        fillColor: Colors.transparent,
                        hintText: "Password",
                        hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
                        focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: height * 0.030,
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      onTap: (){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>const ForgotPasswordPage()));
                      },
                      child: Text("forgot password ?" ,style: TextStyle(fontSize: height*0.012,color: Colors.blueAccent),)),
                  SizedBox(
                    width: width*0.10,
                  )
                ],
              ),
              SizedBox(
                height: height * 0.030,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.orange),
                  padding: MaterialStateProperty.all(EdgeInsets.all(10.0))
                ),
                  onPressed: () async {
                    logData = await SharedPreferences.getInstance();
                    try {
                      await auth.signInWithEmailAndPassword(email: email.text.replaceAll(' ', ''),password: pass.text.replaceAll(' ', '')).then((value)
                      {
                        logData.setBool('login', true);
                        logData.setString('ownerName', 'Onwords Smart Solutions');
                        logData.setString('ownerStreet', 'Pollachi');
                        logData.setString('ownerAddress', 'Coimbatore');
                        logData.setString('ownerWebsite', 'www.onwords.in');
                        logData.setString('ownerEmail', 'cs@onwords.in');
                        logData.setString('ownerGst', '33BTUPN5784J1ZT');
                        logData.setInt('ownerPhone', int.parse('7708630275'));
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                const CustomerDetails()));

                      });



                    } catch (e) {
                      // print(e);
                      setState(() {
                        var loginState = "Incorrect Password or Email";
                        final snackBar = SnackBar(
                          content: Text(loginState),
                          backgroundColor: Colors.red,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      });
                    }


                   }, child: Text('     Sign In     ',style: TextStyle(fontSize: height*0.018,color: Colors.white),)
              ),
              SizedBox(
                height: height * 0.090,
              ),
              Image.asset('assets/logo1.png',height: height * 0.06,),

            ],
          ),
        ),
      ),
    );
  }
}
