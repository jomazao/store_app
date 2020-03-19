import 'package:shared_preferences/shared_preferences.dart';

Future<bool>  insertarFavorito(int id) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  List<int> favoritos = await getFavoritos();
  print(favoritos);
  if (favoritos.any((fav) => fav == id)) {
    print("Ya existe");
    return false;
  } else {
    favoritos.add(id);
    guardarFavoritos(favoritos
        .map((fav) => fav.toString())
        .reduce((acc, fav) => acc + ',' + fav));
    return true;
  }
}

Future<bool> eliminarFavorito(int id) async {
  List<int> favoritos = await getFavoritos();

  if (favoritos.remove(id)) {
    if (favoritos.length == 0) {
      guardarFavoritos("");
      return true;
    }
    guardarFavoritos(favoritos
        .map((fav) => fav.toString())
        .reduce((acc, fav) => acc + ',' + fav));
    return true;
  } else {
    return false;
  }
}

Future<List<int>> getFavoritos() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String favoritosTexto = prefs.getString("favoritos");

  if (favoritosTexto == null || favoritosTexto == "") {
    return new List();
  }
  return favoritosTexto.split(',').map((fav)=>int.parse(fav));

}

guardarFavoritos(String favoritos) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString("favoritos", favoritos);
}

Future<bool> esFavorito(int id) async {
  List<int> favoritos = await getFavoritos();
  return favoritos.any((sitioId) => id == sitioId);
}
