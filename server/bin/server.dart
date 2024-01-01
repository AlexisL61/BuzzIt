import 'dart:io';

import 'package:server/server.dart' as server;

List<String> envVariablesRequired = [
  "SERVER_URL",
  "SERVER_PORT"
];

void main(List<String> arguments) {
  // Verifying env variables
  List<String> missingVariables = envVariablesRequired.where((element) => !Platform.environment.containsKey(element)).toList();
  if (missingVariables.isNotEmpty) {
    print("Missing env variables: ${missingVariables.join(", ")}");
    exit(1);
  }

  server.BuzzerServer();
}
