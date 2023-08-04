class UserModel {

  String _name;
  String? email="";
  String _imageUrl;
  String _phoneno;
  String _whatsappno;

  UserModel(this._name, this.email, this._imageUrl, this._phoneno,this._whatsappno);

  String get phoneno => _phoneno;

  set phoneno(String value) {
    _phoneno = value;
  }



  String get name => _name;

  set name(String value) {
    _name = value;
  }



  String get imageUrl => _imageUrl;

  set imageUrl(String value) {
    _imageUrl = value;
  }

  String get whatsappno => _whatsappno;

  set whatsappno(String value) {
    _whatsappno = value;
  }

}