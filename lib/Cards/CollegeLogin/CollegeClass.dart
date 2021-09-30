class CollegeDetails{
  String _collegename;
  String _emailid;
  String _handlername;
  String _handleremail;
  String _handlernum;
  String _handlerposition;
  String _handlercurrentyear;
  String _collegetype;

  CollegeDetails(this._collegename,
      this._emailid,
      this._handlername,
      this._handleremail,
      this._handlernum,
      this._handlerposition,
      this._handlercurrentyear,
      this._collegetype);
  String toParams() =>"?collegename=$_collegename&"
      "emailid=$_emailid&"
      "handlername=$_handlername&"
      "handleremail=$_handleremail&"
      "handlernum=$_handlernum&"
      "handlerposition=$_handlerposition&"
      "handlercurrentyear=$_handlercurrentyear&"
      "collegetype=$_collegetype";

}