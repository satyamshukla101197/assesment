import 'dart:collection';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';



import 'constants.dart';

extension widgetFunction on Widget {
  dismissKeyboard() {
    FocusManager.instance.primaryFocus!.unfocus();
  }

  showSuccessToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  showErrorToast(
      {required final BuildContext context, required final String message}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.BOTTOM,
      fontSize: 16.0,
    );
  }

  showProgressDialog(BuildContext context) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
            child: Center(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(4),
                ),
                height: 60,
                width: 60,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                ),
              ),
            ),
            onWillPop: () {
              return Future.value(false);
            });
      },
    );
  }


}

extension MyDioError on DioError {
  String getErrorFromDio() {
    if (this.type == DioErrorType.connectTimeout ||
        this.type == DioErrorType.receiveTimeout ||
        this.type == DioErrorType.sendTimeout) {
      return Constants.ERROR_NO_INTERNET;
    }
    if (this.response != null &&
        response!.data != null &&
        response!.data! is Map) {
      //print(response!.data.toString());
      try {
        if (response!.data["message"] is List) {
          return ""
              .toErrorMessage(List<String>.from(response!.data["message"]));
        } else if (response!.data["error"] is LinkedHashMap) {
          final Map<String, dynamic> errorMap = response!.data["error"];
          if (errorMap.containsKey("errors") && errorMap["errors"] is String) {
            return errorMap["errors"];
          } else if (errorMap.containsKey("errors") &&
              errorMap["errors"] is List) {
            final List<dynamic> errors = errorMap["errors"] as List<dynamic>;
            return "".toErrorMessage(List<String>.from(errors));
          }
        } else if (response!.data["error"] is String) {
          return response!.data["error"];
        }
      } on Exception {
        return Constants.ERROR_UNKNOWN;
      }
    }
    return Constants.ERROR_UNKNOWN;
  }

  String getErrorType() {
    if (this.type == DioErrorType.connectTimeout ||
        this.type == DioErrorType.receiveTimeout ||
        this.type == DioErrorType.sendTimeout) {
      return Constants.ERROR_TYPE_TIMEOUT;
    }
    if (this.response != null &&
        response!.data != null &&
        response!.data! is Map) {
      try {
        if (response!.data["error"] is LinkedHashMap) {
          final Map<String, dynamic> errorMap = response!.data["error"];
          if (errorMap.containsKey("type") && errorMap["type"] is String) {
            return errorMap["type"];
          }
        }
      } on Exception {
        return Constants.ERROR_UNKNOWN;
      }
    }
    return Constants.ERROR_UNKNOWN;
  }
}

extension errorMerge on String {
  toErrorMessage(List<String> data) {
    var error = "";
    data.forEach((element) {
      error += element + "\n";
    });
    if (error.endsWith("\n")) {
      error = error.substring(0, error.length - 1);
    }
    return error;
  }

  bool isValidEmail() {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(this);
  }

  bool isValidNumber() {
    return this.length == 10 && this.isNumber();
  }

  bool isNumber() {
    return RegExp(r'^[1-9]\d*$').hasMatch(this);
  }

  bool isVideo(String mediaType) {
    return mediaType.contains("video");
  }

  String sentenceCase() {
    return this
        .replaceAll(RegExp(' +'), ' ')
        .split(" ")
        .map((str) => str.inCaps)
        .join(" ");
  }

  String get inCaps =>
      this.length > 0 ? '${this[0].toUpperCase()}${this.substring(1)}' : '';

  String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
    DateTime notificationDate = DateTime.parse(dateString);
    print(notificationDate.hour);
    final date2 = DateTime.now();
    final difference = date2.difference(notificationDate);

    if (difference.inDays > 8) {
      return dateString;
    } else if ((difference.inDays / 7).floor() >= 1) {
      return (numericDates) ? '1 week ago' : 'Last week';
    } else if (difference.inDays >= 2) {
      return '${difference.inDays} days ago';
    } else if (difference.inDays >= 1) {
      return (numericDates) ? '1 day ago' : 'Yesterday';
    } else if (difference.inHours >= 2) {
      return '${difference.inHours} hours ago';
    } else if (difference.inHours >= 1) {
      return (numericDates) ? '1 hour ago' : 'An hour ago';
    } else if (difference.inMinutes >= 2) {
      return '${difference.inMinutes} minutes ago';
    } else if (difference.inMinutes >= 1) {
      return (numericDates) ? '1 mins ago' : 'A minute ago';
    } else if (difference.inSeconds >= 3) {
      return '${difference.inSeconds} seconds ago';
    } else {
      return 'Just now';
    }
  }
}
