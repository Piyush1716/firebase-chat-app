import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication{
  //instance of auth and firestore
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // get current user
  User? getCurrentUser() => _auth.currentUser;

  // signin
  Future<User?> signin (String email, pass) async{
    try{
      // create user
      UserCredential user = await _auth.signInWithEmailAndPassword(email: email, password: pass);

      // save user data into separeate doc if user do not exits in users collection
      await _firestore.collection('users').doc(user.user!.uid).set({
        'email' : user.user!.email,
        'uid' : user.user!.uid
      });

      return user.user;
    }catch(e){
      return null;
    }
  }

  // signup
  Future<UserCredential> signup(String email, pass, cnfpass) async{
    if(email!='' && pass != '' && cnfpass != '' && pass==cnfpass){
      try{
        // create user
        UserCredential user = await _auth.createUserWithEmailAndPassword(email: email, password: pass);

        // save user data in to separeate doc
        await _firestore.collection('users').doc(user.user!.uid).set({
          'email' : user.user!.email,
          'uid' : user.user!.uid
        });

        return user;
      }
      on FirebaseAuthException catch(e){
        throw Exception(e.code);
      }
    }
    else{ throw Exception('empty or not matched');}
  }

  // logout
  Future<void> signout() async{
    return await _auth.signOut();
  }

}