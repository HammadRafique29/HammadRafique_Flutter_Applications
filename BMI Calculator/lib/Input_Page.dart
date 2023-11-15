import 'package:bmi_calculator/Constantfile.dart';
import 'package:flutter/material.dart';
import 'IconTextfile.dart';
import 'Containerfile.dart';
import 'Resultfile.dart';
import 'Calculatorfile.dart';
enum Gender{
  male,
  female,
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
    Gender? selectGender;
    int sliderHeight=180;
    int sliderWeight=60;
    int sliderAge=20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('BMI CALCULATOR'),
        backgroundColor: Color(0xFF111328),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:<Widget> [
          Expanded(child: Row(
            children:<Widget>[
              Expanded(
                child: RepeatContainerCode(
                  onPressed: ()
                  {
                    setState(() {
                      selectGender=Gender.male;
                    });
                  },
                  colors: selectGender==Gender.male?activeColor:deActiveColor,
                  cardWidget: RepeatTextandIconWidget(
                    iconData: Icons.male,
                    label: "Male",
                  ),
                ),
              ),
              Expanded(
                child: RepeatContainerCode(
                  onPressed: ()
                  {
                    setState(() {
                      selectGender=Gender.female;
                    });
                  },
                  colors: selectGender==Gender.female?activeColor:deActiveColor,
                  cardWidget: RepeatTextandIconWidget(
                    iconData: Icons.female,
                    label: "FeMale",
                  ),
                ),
              ),
            ],
          ),
          ),
          Expanded(child: RepeatContainerCode(
            colors: Color(0xFF1D1E33),
            cardWidget: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Height",
                  style: KLabelstyle,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      sliderHeight.toString(),
                      style:KNumberstyle,
                    ),
                    Text(
                      "Cm",
                      style: KLabelstyle,
                    ),

                  ],
                ),
                Slider(
                  value: sliderHeight.toDouble(),
                  min: 120.0,
                  max: 220.0,
                  activeColor: Color(0xFFEB1555),
                  inactiveColor: Color(0xFF8D8E98),
                  onChanged: (double newValue){
                    setState(() {
                      sliderHeight=newValue.round();
                    });
                  },
                ),
              ],
            )
          ),),
          Expanded(child: Row(
            children:<Widget>[
              Expanded(child: RepeatContainerCode(
                colors: Color(0xFF1D1E33),
                cardWidget: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Weight",
                      style: KLabelstyle,
                    ),
                    Text(
                      sliderWeight.toString(),
                      style: KNumberstyle,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIcon(
                          iconData: Icons.remove,
                          onPress:(){
                            setState(() {
                              sliderWeight--;
                            });
                          }

                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RoundIcon(
                            iconData: Icons.add,
                            onPress:(){
                              setState(() {
                                sliderWeight++;
                              });
                            }
                        ),

                      ],

                    ),
                  ],

                ),
              ),),
              Expanded(child: RepeatContainerCode(
                colors: Color(0xFF1D1E33),
                cardWidget:Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Age",
                      style: KLabelstyle,
                    ),
                    Text(
                      sliderAge.toString(),
                      style: KNumberstyle,

                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RoundIcon(
                            iconData: Icons.remove,
                            onPress:(){
                              setState(() {
                                sliderAge--;
                              });
                            }

                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        RoundIcon(
                            iconData: Icons.add,
                            onPress:(){
                              setState(() {
                                sliderAge++;
                              });
                            }
                        ),

                      ],

                    ),
                  ],

                ),
              ),),
            ],
          ),),
          GestureDetector(
            onTap: (){
              CaclulatorBrain calc = CaclulatorBrain(height: sliderHeight, weight: sliderWeight);
              Navigator.push(context, MaterialPageRoute(builder: (context)=>ResultScreen(
                bmiResult: calc.calculateBMI(),
                resultText: calc.getResult(),
                interpretation: calc.getInterpretation(),
              )));

            },
            child: Container(
              child: Center(
                child:
                Text('Calculate',style: KLargeButtonstyle,),
              ),
              color: Color(0xFFEB1555),
              margin: EdgeInsets.only(top: 10.0),
              width: double.infinity,
              height: 80.0,
            ),
          ),

        ],
      )
     
    );
  }
}

class RoundIcon extends StatelessWidget {
  RoundIcon({required this.iconData,required this.onPress});
  final IconData iconData;
  final VoidCallback? onPress;
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      child:Icon(iconData),
      onPressed:onPress,
      elevation: 6.0,
      constraints: BoxConstraints.tightFor(
        height: 56.0,
        width: 56.0,
      ),
      shape: CircleBorder(),
      fillColor:Color(0xFF4C4F5E),
    );
  }
}


