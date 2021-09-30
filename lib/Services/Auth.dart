import 'package:firebase_auth/firebase_auth.dart';

import 'user.dart';

class AuthMethod{
  final FirebaseAuth _auth=FirebaseAuth.instance;
  user  _userfromfirebaseUser(User user1){
    return user !=null? user(UserId:user1.uid) :null;
  }
  Future signInwithEmailandPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.signInWithEmailAndPassword(email: email, password: password);
      User firebaseuser = result.user;
      return _userfromfirebaseUser(firebaseuser);


    }catch(e){
      print(e.toString());
      return null;

    }
  }
  Future signUpwithEmailandPassword(String email,String password)async{
    try{
      UserCredential result=await _auth.createUserWithEmailAndPassword(email: email, password: password);
      User firebaseuser = result.user;
      return _userfromfirebaseUser(firebaseuser);

    }catch(e){
      print(e.toString());
    }

  }
  Future resetpass(String email)async{
    try{
      return await _auth.sendPasswordResetEmail(email: email);

    }catch(e){
      print(e.toString());
    }
  }
  Future signout()async{
    try{
      return await _auth.signOut();

    }catch(e){

    }
  }

}