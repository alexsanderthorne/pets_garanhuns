import 'package:firebase_core/firebase_core.dart';

class FirebaseOptionsProvider {
  static FirebaseOptions getOptions() {
    return const FirebaseOptions(
      apiKey: "AIzaSyCYQMu45I_sJfLS1VKDVScFrbspU2wA1yY",
      authDomain: "my-pets-40e79.firebaseapp.com",
      databaseURL: "https://my-pets-40e79-default-rtdb.firebaseio.com",
      projectId: "my-pets-40e79",
      storageBucket: "my-pets-40e79.appspot.com",
      messagingSenderId: "396373262447",
      appId: "1:396373262447:web:fc5740bc81ea1911dfcd9a"
    );
  }
}
