// ignore: file_names
import 'dart:math';

class CaclulatorBrain{
  final int height;
  final int weight;
  CaclulatorBrain({required this.height,required this.weight});
  double _bmi = 0;

  String calculateBMI(){
    _bmi = weight / pow(height/100,2);
    return _bmi.toStringAsFixed(1);
  }

  String getResult(){
    if (_bmi >= 25) {
      return 'Overweight';
    } else if (_bmi > 18.5){
      return 'Normal';
    }else {
      return'Underweight';
    }
  }

  String getInterpretation(){
    if (_bmi >= 25){
      return 'You are Faty man. Try to excercise regularly.Join gym.';
    }else if (_bmi > 18.5){
      return 'You have normal body weight. Try for muscles gain.';
    }else {
      return'You are skinny, eat a lot of fruits and food to make body normal.';
    }
  }
}