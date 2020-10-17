import 'dart:math';

class MathUtil {
  static int randomWithMax(int max) {
    Random random = new Random();
    return random.nextInt(max) + 1;
  }
}