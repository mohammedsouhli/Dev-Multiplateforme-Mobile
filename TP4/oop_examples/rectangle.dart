// Exemple 3 : Classe simple avec méthodes de calcul

class Rectangle {
  int longueur;
  int largeur;

  Rectangle(this.longueur, this.largeur);

  int surface() {
    return longueur * largeur;
  }

  int perimetre() {
    return 2 * (longueur + largeur);
  }
}

void main() {
  var r = Rectangle(10, 5);
  print("La surface du rectangle est : ${r.surface()}");
  print("Le périmètre du rectangle est : ${r.perimetre()}");
}
