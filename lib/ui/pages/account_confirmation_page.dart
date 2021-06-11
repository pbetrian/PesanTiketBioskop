part of 'pages.dart';

class AccountConfirmationPage extends StatefulWidget {
  final RegistrasionData registrasionData;

  AccountConfirmationPage(this.registrasionData);

  @override
  _AccountConfirmationPageState createState() =>
      _AccountConfirmationPageState();
}

class _AccountConfirmationPageState extends State<AccountConfirmationPage> {
  bool isSignInUp = false;
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        context
            .read<PageBloc>()
            .add(GoToPreferencePage(widget.registrasionData));
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
                          "Confirm\nNew Account",
                          style: blackTextFont.copyWith(fontSize: 20),
                          textAlign: TextAlign.center,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsetsDirectional.only(bottom: 20),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            image:
                                (widget.registrasionData.profileImage == null)
                                    ? AssetImage("assets/user_pic.png")
                                    : FileImage(
                                        widget.registrasionData.profileImage),
                            fit: BoxFit.cover)),
                  ),
                  Text("Welcome",
                      style: blackTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  Text("${widget.registrasionData.name}",
                      style: blackTextFont.copyWith(
                          fontSize: 16, fontWeight: FontWeight.w300)),
                  SizedBox(height: 110),
                  (isSignInUp)
                      ? SpinKitFadingCircle(color: Color(0xFF3E9D9D), size: 45)
                      : SizedBox(
                          width: 250,
                          height: 45,
                          child: RaisedButton(
                              color: Color(0xFF3E9D9D),
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Text("Create My Account",
                                  style: whiteTextFont.copyWith(fontSize: 16)),
                              onPressed: () async {
                                setState(() {
                                  isSignInUp = true;
                                });

                                imageFileToUpload =
                                    widget.registrasionData.profileImage;

                                SignInSignUpResult result =
                                    await AuthServices.signUp(
                                        widget.registrasionData.email,
                                        widget.registrasionData.password,
                                        widget.registrasionData.name,
                                        widget.registrasionData.selectedGenres,
                                        widget.registrasionData.selectedLang);

                                if (result.user == null) {
                                  setState(() {
                                    isSignInUp = false;
                                  });

                                  Flushbar(
                                    duration: Duration(milliseconds: 1500),
                                    flushbarPosition: FlushbarPosition.TOP,
                                    backgroundColor: Color(0xFFFF5C83),
                                    message: result.message,
                                  )..show(context);
                                }
                              }))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
