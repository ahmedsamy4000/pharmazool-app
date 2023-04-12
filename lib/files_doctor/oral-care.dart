import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pharmazool/components/constants.dart';
import 'package:pharmazool/files_doctor/home_doctor_screen.dart';

class OralCare extends StatefulWidget {
  const OralCare({Key? key}) : super(key: key);

  @override
  _OralCareState createState() => _OralCareState();
}

class _OralCareState extends State<OralCare> {
  bool isSwitched = false;
  goToIndexPage(int index) {
    if (index == 0) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenDoctor()),);
    } else if (index == 1) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenDoctor()),);
    } else if (index == 2) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenDoctor()),);
    } else if (index == 3) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreenDoctor()),);
    }
  }
  var _currentIndex = 0;
  double _currentSliderValue = 20;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
        bottomNavigationBar: Theme(
          data: ThemeData(
            canvasColor: Colors.teal,
          ),
          child: BottomNavigationBar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
              goToIndexPage(index);
            },
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.black,
            showSelectedLabels: true,
            showUnselectedLabels: true,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
              BottomNavigationBarItem(icon: Icon(Icons.history), label: "History"),
              BottomNavigationBarItem(icon: Icon(Icons.qr_code_rounded), label: "Bar Code"),
              BottomNavigationBarItem(icon: Icon(Icons.receipt), label: "Receipt"),
            ],
          ),
        ),
        appBar:AppBar(
          backgroundColor: Colors.teal,
          title: const Text("Oral Care"),
          centerTitle: true,
          leading: GestureDetector(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeScreenDoctor()));
            },
            child: const Icon(
              Icons.arrow_back_rounded,  // add custom icons also
            ),
          ),

        ),
        body:Scaffold(
            body: Column(
              children: [
                InkWell(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>const OralCare()));
                  },
                  child: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(0),color: Colors.white,),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          padding: EdgeInsets.all(8), // Border width
                          decoration: BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                          child: ClipOval(
                            child: SizedBox.fromSize(
                              size: Size.fromRadius(48), // Image radius
                              child: Image.asset('assets/images/oral-care1.png', fit: BoxFit.cover),
                            ),
                          ),
                        )

                      ],),
                  ),
                ),
                SizedBox(height: 30,),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          height: 40.0,
                          child: TextField(
                            style: TextStyle(
                              fontSize: 12,
                            ),
                            decoration: InputDecoration(
                              hintText: 'search',
                              hintStyle: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                              ),
                              filled: true,
                              fillColor: Colors.teal,
                              border: OutlineInputBorder(
                                borderSide: BorderSide.none,
                                borderRadius: BorderRadius.circular(30.0),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 8,
                              ),
                              suffixIcon: SvgPicture.asset(
                                'assets/icons/search.svg',
                                color: Colors.white,
                                fit: BoxFit.scaleDown,
                              ),
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(height: 20,),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(70),
                        topRight: Radius.circular(70),
                        topLeft: Radius.circular(70),
                        bottomLeft: Radius.circular(70),
                      ),
                      side: BorderSide(width: 5, color: Colors.teal)),
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      leading: Image.asset('assets/images/panadol.png',height: 90,width: 90,),
                      title: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Center(child: Text('Panadol Extra',style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold,fontSize: 18))),
                      ),
                      subtitle: Slider(
                          value: _currentSliderValue,
                          max: 100,
                          divisions: 5,
                          label: _currentSliderValue.round().toString(),
                          onChanged: (double value) {
                            setState(() {
                              _currentSliderValue = value;
                            });
                          }),
                      trailing: Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          setState(() {
                            isSwitched = value;
                            print(isSwitched);
                          });
                        },
                        activeTrackColor: Colors.lightGreenAccent,
                        activeColor: Colors.green,
                      ),

                    ),
                  ),
                ),

              ],
            )


        )
    );
  }
}
