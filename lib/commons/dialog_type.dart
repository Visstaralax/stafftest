enum DialogType{
  connectivity,
  knowError,
  none
}

class DialogContent{

  var title = "";
  var message = "";
  var nameButton = "";

  DialogContent(this.title, this.message, this.nameButton);
  DialogContent.empty(){
    DialogContent("","", "");
  }
}

class DialogData{
  static final connectivityError = DialogContent(
      "Conexión",
      "No tienes conexión a internet",
      "Aceptar");

  static final knowError = DialogContent(
      "Error",
      "Ha ocurrido un error inesperado",
      "Aceptar");
}