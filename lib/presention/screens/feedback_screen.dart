import 'package:fcih_app/business_logic/feedback/feedback_cubit.dart';
import 'package:fcih_app/constants/size_config.dart';
import 'package:fcih_app/constants/strings.dart';
import 'package:fcih_app/presention/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';

class FeedbackScreen extends StatelessWidget {
  const FeedbackScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var cubit = FeedbackCubit.cubit(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: const BackButton(
          color: primaryColor,
        ),
        title: Text('Feedback',
            style: Theme.of(context)
                .textTheme
                .subtitle1!
                .copyWith(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Container(
        //  alignment: Alignment.center,
        child: SingleChildScrollView(
          child: Form(
            key: cubit.globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                const Text(
                  "We wanna know what you thought of your experience at Fcih App so we 'd like to hear your feedback  and Suggestions.",
                  textAlign: TextAlign.center,
                  softWrap: true,
                ),
                SizedBox(
                  height: getProportionateScreenHeight(40),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    validation: cubit.validateName,
                    hintText: 'Your name',
                    maxLines: 1,
                    controller: cubit.name,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Email',
                    maxLines: 1,
                    validation: cubit.validateEmail,
                    controller: cubit.email,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: CustomTextField(
                    hintText: 'Comment',
                    controller: cubit.comment,
                    maxLines: 10,
                    validation: cubit.validateComment,
                  ),
                ),
                Center(
                  child: SizedBox(
                    width: getProportionateScreenWidth(
                        platformGetter() == PlatForm.android ? 200 : 50),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: MaterialButton(
                          onPressed: () {
                            cubit.submit(context);
                          },
                          color: primaryColor,
                          minWidth: SizeConfig.screenWidth,
                          child: Text(
                            'Send',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: getProportionScreenration(
                                    platformGetter() == PlatForm.android
                                        ? 20
                                        : 60)),
                          )),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
