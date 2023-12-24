import 'package:chat_app/models/chat_messages.dart';
import 'package:chat_app/screens/chat_screen.dart';
import 'package:chat_app/utils/string_constants.dart';
import 'package:chat_app/utils/text_styles.dart';
import 'package:chat_app/utils/validations.dart';
import 'package:chat_app/widgets/button_widget.dart';

import 'package:chat_app/widgets/textformfield.dart';
import 'package:flutter/material.dart';
import '../utils/color_constants.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, this.title});
  final String? title;
  @override
  State<LoginScreen> createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  GlobalKey<FormState> loginkey = GlobalKey<FormState>();
  bool passwordVisiblity = true;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

// radio button
  static String? selectedOption = "sender";


  void chatPerson(String value) {
    setState(() {
      selectedOption = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blue3887BE,
      body: buildBody(),
    );
  }

  Widget buildBody() {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 100, horizontal: 20),
        child: Form(
          key: loginkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringConstants.welcomeBack,
                  style: TextStyles.textStyleFont36Weight700
                      .copyWith(color: ColorConstants.white)),
              const SizedBox(
                height: 25,
              ),
              TextFormFieldWidget(
                controller: emailController,
                obscureText: false,
                hint: StringConstants.userNameOrEmail,
                prefixIcon: Icons.person,
                validator: (val) {
                  return Validations.isEmailValid(val);
                },
              ),
              const SizedBox(
                height: 25,
              ),
              TextFormFieldWidget(
                controller: passwordController,
                hint: StringConstants.password,
                prefixIcon: Icons.lock,
                obscureText: passwordVisiblity,
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      passwordVisiblity = !passwordVisiblity;
                    });
                  },
                  icon: Icon(
                      passwordVisiblity
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: ColorConstants.white),
                ),
                validator: (val) {
                  return Validations.isPasswordValid(val);
                },
              ),

              // Radio button <<<<<<<<<<<<<<<<<<<
              Container(
                margin: const EdgeInsets.symmetric(vertical: 25),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                    color: ColorConstants.blue38419D,
                    borderRadius: BorderRadius.circular(10)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(StringConstants.userType,
                        style: TextStyles.textStyleFont14Weight400),
                    ListTile(
                      title: const Text(StringConstants.sender,
                          style: TextStyles.textStyleFont14Weight400),
                      leading: Radio(
                        activeColor: ColorConstants.white,
                        value:"sender",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                      ),
                    ),
                    ListTile(
                      title: const Text(StringConstants.receiver,
                          style: TextStyles.textStyleFont14Weight400),
                      leading: Radio(
                        activeColor: ColorConstants.white,
                        value: "receiver",
                        groupValue: selectedOption,
                        onChanged: (value) {
                          setState(() {
                            selectedOption = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
              ),

              ButtonWidget(
                text: StringConstants.login,
                onPressed: () {
                  print(selectedOption); // to check value of radio btton
                  if (loginkey.currentState!.validate()) {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ChatScreen(
                            currentUser: selectedOption,
                       
                          ),
                        ));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
