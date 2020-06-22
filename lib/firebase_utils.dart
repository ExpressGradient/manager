import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<FirebaseUser> signInManager() async {
  final GoogleSignInAccount _googleSignInAccount = await _googleSignIn.signIn();
  final GoogleSignInAuthentication _googleSignInAuth = await _googleSignInAccount.authentication;
  final AuthCredential _authCredential = GoogleAuthProvider.getCredential(
    idToken: _googleSignInAuth.idToken,
    accessToken: _googleSignInAuth.accessToken
  );
  final AuthResult _authResult = await _firebaseAuth.signInWithCredential(_authCredential);
  print("Successful Auth Occurred => ${_authResult.user.uid}");
  return _authResult.user;
} 

Future<void> signOutManager() async {
  await _googleSignIn.signOut();
  await _firebaseAuth.signOut();
  print("Successful Sign Out");
}

Future<void> createUserRecord(FirebaseUser firebaseUser) async {
  final CollectionReference _userCollection = Firestore.instance.collection("users");
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  String token = await _firebaseMessaging.getToken();

  await _userCollection.document(firebaseUser.uid).setData({
    "uid": firebaseUser.uid,
    "displayName": firebaseUser.displayName,
    "phoneNumber": firebaseUser.phoneNumber,
    "email": firebaseUser.email,
    "photoUrl": firebaseUser.photoUrl,
    "token": token
  }).then((result) => print("Successful Account Creation Occurred")).catchError((error) => print("Error on creating user record"));
}

Future<void> createProject(String projectName, String projectDescription, List<String> teamMates, String firstTaskDate, String secondTaskDate, String thirdTaskDate, String finalTaskDate) async {
  final CollectionReference _projectCollection = Firestore.instance.collection("projects");

  final FirebaseUser _firebaseUser = await _firebaseAuth.currentUser();
  teamMates.add(_firebaseUser.email);

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  String token = await _firebaseMessaging.getToken();

  await _projectCollection.document(projectName).setData({
    "projectName": projectName,
    "projectDescription": projectDescription,
    "teamMates": teamMates,
    "firstTaskDate": firstTaskDate,
    "secondTaskDate": secondTaskDate,
    "thirdTaskDate": thirdTaskDate,
    "finalTaskDate": finalTaskDate,
    "token": token
  }).then((result) => print("Successfully created a project")).catchError((error) => print("Error in creating a project" + error));
}

Future<List<DocumentSnapshot>> getProjects() async {
  final CollectionReference _projectCollection = Firestore.instance.collection('projects');

  final FirebaseUser _firebaseUser = await _firebaseAuth.currentUser();
  String _userEmail = _firebaseUser.email;

  List<DocumentSnapshot> _userProjects = [];

  QuerySnapshot _snapshot = await _projectCollection.getDocuments();
  _snapshot.documents.forEach((_document) {
    if(_document['teamMates'].contains(_userEmail)) {
      _userProjects.add(_document);
    }
  });

  print(_userProjects[0].data);

  return _userProjects;
}


//TODO remove all the debug logs