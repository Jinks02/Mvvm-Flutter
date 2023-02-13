import 'package:flutter/material.dart';
import 'package:mvvm_flutter/res/components/round_button.dart';
import 'package:mvvm_flutter/utils/routes/routes_name.dart';
import 'package:mvvm_flutter/utils/utils.dart';
import 'package:mvvm_flutter/view_model/auth_view_model.dart';
import 'package:provider/provider.dart';
class LoginView extends StatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  Utils _utils = Utils();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  FocusNode _emailFocusNode =
      FocusNode(); // to shift focus from one textfield to other after submitting
  FocusNode _passwordFocusNode = FocusNode();

  ValueNotifier<bool> _obsecurePasswordVisibility = ValueNotifier<bool>(true);


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _emailFocusNode.dispose();
    _passwordFocusNode.dispose();
    _obsecurePasswordVisibility.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    final _authViewModel = Provider.of<AuthViewModel>(context);

    final height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("login"),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              focusNode: _emailFocusNode,
              onFieldSubmitted: (value) {
                _utils.changeTextFieldFocus(
                    context, _emailFocusNode, _passwordFocusNode);
              },
              decoration: const InputDecoration(
                // hintText: 'Email',
                labelText: 'Email',
                prefixIcon: Icon(Icons.email_outlined),
              ),
            ),
            ValueListenableBuilder(
              valueListenable: _obsecurePasswordVisibility,
              builder: (context, value, child) {
                return TextFormField(
                  controller: _passwordController,
                  obscureText: _obsecurePasswordVisibility.value,
                  obscuringCharacter: "*",
                  focusNode: _passwordFocusNode,
                  decoration: InputDecoration(
                      // hintText: 'Password',
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock_open_outlined),
                      suffixIcon: InkWell(
                        onTap: () {
                          _obsecurePasswordVisibility.value =
                              !_obsecurePasswordVisibility.value;
                        },
                        child: Icon(_obsecurePasswordVisibility.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined),
                      )),
                );
              },
            ),
            SizedBox(
              height: height * 0.08,
            ),
            RoundButton(title: 'Login', onPressed: (){

              // if u dont wanna use form widget to validate then:

              if(_emailController.text.isEmpty){
                _utils.showErrorFlushBarMessage('Email?', context);
              }
              else if(_passwordController.text.isEmpty){
                _utils.showSnackBar('password?', context);
              }
              else if(_passwordController.text.length < 6){
                _utils.showToastMessage('password must be 6 digit');
              }
              else{
                Map data ={
                  'email' : _emailController.text,
                  'password' : _passwordController.text
                };
               _authViewModel.handleLoginApiFromAuthRepo(context,data);
                debugPrint('api time');
              }
            },loading: _authViewModel.getLoginLoading,),
            SizedBox(
              height: height* 0.08,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children:  [
                Text("Don't have an account?"),
                SizedBox(width: 10,),
                InkWell(
                  onTap: (){
                    Navigator.pushNamed(context, RoutesName.signUp);
                  },
                  child: Text("Sign Up",
                  style: TextStyle(decoration: TextDecoration.underline),),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
