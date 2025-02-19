//
// Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
//  http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

import 'package:amplify_auth_cognito/amplify_auth_cognito.dart';
import 'package:amplify_core/amplify_core.dart';
import 'package:amplify_flutter/amplify.dart';
import 'package:flutter/material.dart';

// ignore_for_file: public_member_api_docs
class ConfirmResetWidget extends StatefulWidget {
  final Function showResult;
  final Function changeDisplay;
  final Function setError;
  final VoidCallback backToSignIn;

  ConfirmResetWidget(
      this.showResult, this.changeDisplay, this.setError, this.backToSignIn);

  @override
  _ConfirmWidgetState createState() => _ConfirmWidgetState();
}

class _ConfirmWidgetState extends State<ConfirmResetWidget> {
  final usernameController = TextEditingController();
  final newPasswordController = TextEditingController();
  final confirmationCodeController = TextEditingController();

  void _confirmReset() async {
    try {
      await Amplify.Auth.confirmResetPassword(
          username: usernameController.text.trim(),
          newPassword: newPasswordController.text.trim(),
          confirmationCode: confirmationCodeController.text.trim());
      widget.showResult('Password Confirmed');
      widget.changeDisplay('SHOW_SIGN_IN');
    } on AmplifyException catch (e) {
      widget.setError(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Expanded(
          // wrap your Column in Expanded
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.all(10.0)),
              TextFormField(
                  controller: usernameController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.verified_user),
                    hintText: 'Your old username',
                    labelText: 'Username *',
                  )),
              TextFormField(
                  controller: newPasswordController,
                  obscureText: true,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.question_answer),
                    hintText: 'Your new password',
                    labelText: 'New Password *',
                  )),
              TextFormField(
                  controller: confirmationCodeController,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.confirmation_number),
                    hintText: 'The confirmation code we sent you',
                    labelText: 'Confirmation Code *',
                  )),
              const Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                onPressed: _confirmReset,
                child: const Text('Confirm Password Reset'),
              ),
              const Padding(padding: EdgeInsets.all(10.0)),
              ElevatedButton(
                key: Key('goto-signin-button'),
                onPressed: widget.backToSignIn,
                child: const Text('Back to Sign In'),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
