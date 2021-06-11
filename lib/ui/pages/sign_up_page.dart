part of 'pages.dart';

class SignUpPage extends StatefulWidget {
  final RegistrasionData registrasionData;

  SignUpPage(this.registrasionData);
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController namaController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController retypePasswordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    namaController.text = widget.registrasionData.name;
    emailController.text = widget.registrasionData.email;
  }

  @override
  Widget build(BuildContext context) {
    context
        .read<ThemeBloc>()
        .add(ChangeTheme(ThemeData().copyWith(primaryColor: accentColor1)));

    return WillPopScope(
      onWillPop: () async {
        context.read<PageBloc>().add(GoToSplashPage());

        return;
      },
      child: Scaffold(
        body: Container(
          color: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: defaultMargin),
          child: ListView(
            children: [
              Column(
                children: [
                  Container(
                    margin: EdgeInsetsDirectional.only(top: 20, bottom: 22),
                    height: 56,
                    child: Stack(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: GestureDetector(
                            onTap: () {
                              context.read<PageBloc>().add(GoToSplashPage());
                            },
                            child: Icon(Icons.arrow_back, color: Colors.black),
                          ),
                        ),
                        Center(
                            child: Text(
                          "Create New Account",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    width: 90,
                    height: 104,
                    child: Stack(
                      children: [
                        Container(
                          height: 90,
                          width: 90,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: (widget
                                              .registrasionData.profileImage ==
                                          null)
                                      ? AssetImage("assets/user_pic.png")
                                      : FileImage(
                                          widget.registrasionData.profileImage),
                                  fit: BoxFit.cover)),
                        ),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: GestureDetector(
                            onTap: () async {
                              if (widget.registrasionData.profileImage ==
                                  null) {
                                widget.registrasionData.profileImage =
                                    await getImage();
                              } else {
                                widget.registrasionData.profileImage = null;
                              }
                              setState(() {});
                            },
                            child: Container(
                              height: 28,
                              width: 28,
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  image: DecorationImage(
                                      image: AssetImage((widget.registrasionData
                                                  .profileImage ==
                                              null)
                                          ? "assets/btn_add_photo.png"
                                          : "assets/btn_del_photo.png"))),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 36),
                  TextField(
                      controller: namaController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Full Name",
                          hintText: "Full Name")),
                  SizedBox(height: 16),
                  TextField(
                      controller: emailController,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Email",
                          hintText: "Email")),
                  SizedBox(height: 16),
                  TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Password",
                          hintText: "Password")),
                  SizedBox(height: 16),
                  TextField(
                      controller: retypePasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)),
                          labelText: "Confirm Password",
                          hintText: "Confirm Password")),
                  SizedBox(height: 30),
                  FloatingActionButton(
                      child: Icon(Icons.arrow_forward),
                      backgroundColor: mainColor,
                      elevation: 0,
                      onPressed: () {
                        if (!(namaController.text.trim() != "" &&
                            emailController.text.trim() != "" &&
                            passwordController.text.trim() != "" &&
                            retypePasswordController.text.trim() != "")) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Please fill all the fields",
                          )..show(context);
                        } else if (passwordController.text !=
                            retypePasswordController.text) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Mismatch password and confrimed password",
                          )..show(context);
                        } else if (passwordController.text.length < 6) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Password's length min 6 characters",
                          )..show(context);
                        } else if (!EmailValidator.validate(
                            emailController.text)) {
                          Flushbar(
                            duration: Duration(milliseconds: 1500),
                            flushbarPosition: FlushbarPosition.TOP,
                            backgroundColor: Color(0xFFFF5C83),
                            message: "Wrong formatted email address",
                          )..show(context);
                        } else {
                          widget.registrasionData.name = namaController.text;
                          widget.registrasionData.email = emailController.text;
                          widget.registrasionData.password =
                              passwordController.text;

                          context
                              .read<PageBloc>()
                              .add(GoToPreferencePage(widget.registrasionData));
                        }
                      }),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
