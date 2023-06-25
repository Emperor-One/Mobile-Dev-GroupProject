import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CreateLeaguePage extends StatelessWidget {
  const CreateLeaguePage({super.key});

  @override
  Widget build(BuildContext context) {
    double dividerWidth = MediaQuery.of(context).size.width * 0.954;
    double containerWidth = MediaQuery.of(context).size.width * 0.861;
    double containerHeight = MediaQuery.of(context).size.height * 0.31;
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: <Widget>[
            
            const SizedBox(
              height: 20.0,
            ),
            Container(
              color: const Color.fromARGB(77, 132, 156, 220),
              width: containerWidth,
              padding: const EdgeInsets.all(10.0),
              child:
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const Text(
                  "League Info",
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  child: Divider(
                    color: Colors.white,
                  ),
                ),
                const Text(
                  "Fill in the information box and preferences, then hit the ‘Create League’ button ",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontFamily: "Inter",
                    fontSize: 15,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Center(
                  child: SizedBox(
                    width: containerWidth * 0.892,
                    height: containerHeight * 0.148,
                    child: TextField(
                      style: TextStyle(color: Colors.white),
                      // cursorColor: Colors.white,
                      decoration: InputDecoration(
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.transparent),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        filled: true,
                        fillColor: const Color.fromARGB(77, 132, 156, 220),
                        contentPadding: const EdgeInsets.all(0.0),
                        hintText: "League Name",
                        hintStyle: const TextStyle(
                          color: Color.fromARGB(115, 255, 255, 255),
                        ),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                // SizedBox(
                //   height: containerHeight * 0.06,
                // ),
                
                Row(
                  
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                      "Private",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(
                      width: 25.0,
                    ),
                    Switch(value: false, onChanged: (newValue) {})
                  ],
                ),
                Center(
                  child: SizedBox(
                    width: containerWidth * 0.892,
                    child: ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.white),
                        foregroundColor: MaterialStateProperty.all(Colors.black),
                        shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(19.0))),
                      ),
                      child: const Text(
                        "Create League",
                        style: TextStyle(
                          fontFamily: "Inter",
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      onPressed: () {
                        GoRouter.of(context).push("/create/addTeamCreate");
                      },
                    ),
                  ),
                ),
              ],),
            ),
          ],
        ),
      ),
    );
  }
}
