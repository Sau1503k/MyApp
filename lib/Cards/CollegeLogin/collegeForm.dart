import 'package:MyApp/Cards/CollegeLogin/CollegeClass.dart';
import 'package:flutter/material.dart';

import 'controller.dart';


class CollegeForm extends StatefulWidget {
  @override
  _CollegeFormState createState() => _CollegeFormState();
}

class _CollegeFormState extends State<CollegeForm> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey= GlobalKey<ScaffoldState>();
  TextEditingController collegenamecontroller=TextEditingController();
  TextEditingController collegeEmailController=TextEditingController();
  TextEditingController handlernamecontroller=TextEditingController();
  TextEditingController handleremailcontroller=TextEditingController();
  TextEditingController handlerphonenumcontroller=TextEditingController();
  TextEditingController handlerpositioncontroller=TextEditingController();
  TextEditingController handlercurrentyearcontroller=TextEditingController();
  String CollegeType;

  List collegetype=['Engineering',"IIT's",'Medical',"NIT's","other Colleges"];
  void _submitform(){
    if(_formkey.currentState.validate()){
      CollegeDetails feedbackform = CollegeDetails(collegenamecontroller.text,
          collegeEmailController.text,
          handlernamecontroller.text,
          handleremailcontroller.text,
      handlerphonenumcontroller.text,
      handlerpositioncontroller.text,
      handlercurrentyearcontroller.text,
      CollegeType);
      FormController formController=FormController((String response){
        print("$response sssssssssssssssss");
        if(response==FormController.STATUS_SUCCESS){
          _showsnackbar("Feedback Submitted");
          collegenamecontroller.clear();
          collegeEmailController.clear();
          handlernamecontroller.clear();
          handlerphonenumcontroller.clear();
          handleremailcontroller.clear();
          handlerpositioncontroller.clear();
          handlercurrentyearcontroller.clear();
          setState(() {
            CollegeType=null;
          });



        }else{
          _showsnackbar("Error Occured");

        }
      });
      _showsnackbar("Submitting Feedback");
      formController.submitform(feedbackform);
    }
  }
  _showsnackbar(String Message){
    final snackbar=SnackBar(content: Text(Message));
    _scaffoldkey.currentState.showSnackBar(snackbar);

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      body: SingleChildScrollView(
        child: Form(key: _formkey,
        child: Container(
          child: Padding(
            padding: const EdgeInsets.only(left:8.0,right:8,top: 30),
            child: Column(
              children: [ Center(child: Text("College Details",style:TextStyle(fontSize: 30,fontWeight: FontWeight.bold),)),
                TextFormField(
                controller: collegenamecontroller,
                validator: (value){
                  if(value.isEmpty){
                    return "Enter Valid CollegeName";
                  }else{
                    return null;
                  }
                },
                decoration: InputDecoration(
                    labelText: "CollegeName"
                ),
              ),
                TextFormField(
                  controller: collegeEmailController,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid EmailId";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Email-Id"
                  ),
                ),
                Container(width: MediaQuery.of(context).size.width,
                  child: Center(
                    child: DropdownButton(
                      hint: Text("Select SubCategory"),
                      value: CollegeType,
                      onChanged: (newvalue){
                        setState(() {
                          CollegeType=newvalue;
                        });
                      },
                      items:collegetype.map((valueItem){
                        return DropdownMenuItem(child: Text(valueItem),
                          value: valueItem,);
                      }).toList(),

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                Text("Details of Person Who will be Handling this Account",style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                TextFormField(
                  controller: handlernamecontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Name";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "name"
                  ),
                ),
                TextFormField(
                  controller: handleremailcontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Email-id";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Email-Id"
                  ),
                ),
                TextFormField(
                  controller: handlerphonenumcontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid PhoneNum";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Phone no."
                  ),
                ),
                TextFormField(
                  controller: handlerpositioncontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Position";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Position in College"
                  ),
                ),
                TextFormField(
                  controller:handlercurrentyearcontroller,
                  validator: (value){
                    if(value.isEmpty){
                      return "Enter Valid Current Year";
                    }else{
                      return null;
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Current Year"
                  ),
                ),
                RaisedButton(onPressed:(){
                  _submitform();
                }
                    , child: Text("Submit"))

              ],
            ),
          ),
        ),),
      ),
    );
  }
}
