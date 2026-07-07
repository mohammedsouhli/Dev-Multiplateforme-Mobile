// Exemple 2 : Constructeur nommé et surcharge d'opérateur

import 'dart:math' as math;

class Point {
  num x, y;

  Point(this.x, this.y);

  Point.origin()
      : x = 0,
        y = 0;

  void affiche() {
    print("[$x,$y]");
  }

  num distance(Point p) {
    var dx = x - p.x;
    var dy = y - p.y;
    return math.sqrt(dx * dx + dy * dy);
  }

  Point operator +(Point p) => Point(x + p.x, y + p.y);
}

void main() {
  var p1 = Point(2, 5);
  print("p1.x = ${p1.x}");
  print("p1.y = ${p1.y}");
  p1.affiche();

  var p2 = Point.origin();
  p2.affiche();

  var distance = p1.distance(p2);
  print("Distance entre p1 et p2 : $distance");

  var p3 = p1 + p2;
  p3.affiche();
}
