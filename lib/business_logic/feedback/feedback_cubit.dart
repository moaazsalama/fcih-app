import 'package:fcih_app/data/web_services/google_sheets_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_styled_toast/flutter_styled_toast.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  static FeedbackCubit cubit(context) =>
      BlocProvider.of<FeedbackCubit>(context);
  final TextEditingController name = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController comment = TextEditingController();
  final GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  String? validateName(String? name) {
    if (name!.isEmpty) {
      return "Enter your name please.";
    }
    return null;
  }

  String? validateEmail(String? email) {
    if (email!.isEmpty) {
      return "Enter your email please.";
    } else if (!email.contains('@') && !email.contains('.com')) {
      return "UnVaild Email";
    } else {
      return null;
    }
  }

  String? validateComment(String? comment) {
    if (comment!.isEmpty) {
      return "Enter your comment please.";
    } else if (comment.length < 14) {
      return "Too Short Comment";
    } else {
      return null;
    }
  }

  void submit(BuildContext context) async {
    if (globalKey.currentState!.validate()) {
      print(name.text + email.text + comment.text);
      var bool = await UserSheetApi.insertComment(
          name.text, email.text, comment.text, DateTime.now());
      if (bool) {
        Navigator.pop(context);
        showToast(
          'Feedback Sended \nThanks for your Opinion.',
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.bottom,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 2),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
        );
      } else {
        showToast(
          'Check Your Network',
          context: context,
          animation: StyledToastAnimation.scale,
          reverseAnimation: StyledToastAnimation.fade,
          position: StyledToastPosition.center,
          animDuration: const Duration(seconds: 1),
          duration: const Duration(seconds: 4),
          curve: Curves.elasticOut,
          reverseCurve: Curves.linear,
        );
      }
    }
  }

  FeedbackCubit() : super(FeedbackInitial());
}
