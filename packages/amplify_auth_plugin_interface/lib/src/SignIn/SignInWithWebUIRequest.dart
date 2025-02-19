/*
 * Copyright 2021 Amazon.com, Inc. or its affiliates. All Rights Reserved.
 *
 * Licensed under the Apache License, Version 2.0 (the "License").
 * You may not use this file except in compliance with the License.
 * A copy of the License is located at
 *
 *  http://aws.amazon.com/apache2.0
 *
 * or in the "license" file accompanying this file. This file is distributed
 * on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
 * express or implied. See the License for the specific language governing
 * permissions and limitations under the License.
 */

import 'package:amplify_auth_plugin_interface/amplify_auth_plugin_interface.dart';
import 'package:flutter/foundation.dart';

import './AuthProvider.dart';

class SignInWithWebUIRequest {
  AuthProvider? provider;
  SignInWithWebUIOptions? options;
  SignInWithWebUIRequest({this.provider, this.options});
  Map<String, dynamic> serializeAsMap() {
    final Map<String, dynamic> pendingRequest = <String, dynamic>{};
    if (this.provider != null) {
      pendingRequest["authProvider"] = describeEnum(provider!);
    }
    if (options != null) {
      pendingRequest['options'] = options?.serializeAsMap();
    }
    return pendingRequest;
  }
}
