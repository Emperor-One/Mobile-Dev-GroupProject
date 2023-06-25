import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddTeamCreate extends StatelessWidget {
  const AddTeamCreate({super.key});

  @override
  Widget build(BuildContext context) {
    const Color containerColor = Color.fromARGB(77, 132, 156, 220);
    const Color playerContainerColor = Color.fromARGB(140, 132, 156, 220);

    double containerWidth = MediaQuery.of(context).size.width * 0.915;
    double containerHeight = MediaQuery.of(context).size.height * 0.08;

    double dividerWidth = MediaQuery.of(context).size.width * 0.954;

    // Hard coding it like this causes issues for bigger screens
    double fieldWidth = 328.0;
    double fieldHeight = 354.1;

    double playerContainerWidth = MediaQuery.of(context).size.width * 0.248;
    double playerContainerHeight = MediaQuery.of(context).size.height * 0.14;

    return Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: GestureDetector(
              onTap: () => GoRouter.of(context).pop(),
              child: Icon(
                Icons.arrow_back_ios_new,
                size: 30,
              ),
            ),
          ),
          title: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Text(
              "Add Team",
            ),
          ),
        ),
        body: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Center(
                child: SizedBox(
                  height: 35.0,
                  width: dividerWidth,
                  child: const Divider(
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                // padding: const EdgeInsets.all( 8.0),
                width: containerWidth,
                height: containerHeight,
                color: containerColor,
                child: ListTile(
                  leading: Icon(
                    Icons.info_outline,
                    color: IconTheme.of(context).color,
                  ),
                  title: Text(
                    "You are one step away from creating your own league! Just select your team and hit the ‘Add team’ button.",
                    textAlign: TextAlign.justify,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  horizontalTitleGap: 10.0,
                  minLeadingWidth: 24.0,
                  contentPadding: EdgeInsets.symmetric(horizontal: 4.0),
                ),
              ),
              SizedBox(
                height: 80.0,
              ),
              Container(
                width: fieldWidth,
                height: fieldHeight,
                // padding: EdgeInsets.only(top: 25.0),
                // margin: EdgeInsets.only(bottom: 11.0),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      alignment: Alignment.center,
                      image: AssetImage("images/field.png"),
                      fit: BoxFit.contain),
                ),
                child: Column(
                  children: <Widget>[
                    // const SizedBox(
                    //   height: 25.0,
                    // ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.0),
                            right: Radius.circular(15.0),
                          ),
                          onTap: () => GoRouter.of(context)
                              .push("/create/addTeamCreate/addPlayer"),
                          child: Container(
                            width: playerContainerWidth,
                            height: playerContainerHeight,
                            decoration: BoxDecoration(
                              color: playerContainerColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(15.0),
                                right: Radius.circular(15.0),
                              ),
                            ),
                            child: Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Select"), Text("GK")],
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.0),
                            right: Radius.circular(15.0),
                          ),
                          onTap: () => GoRouter.of(context)
                              .push("/create/addTeamCreate/addPlayer"),
                          child: Container(
                              width: playerContainerWidth,
                              height: playerContainerHeight,
                              decoration: BoxDecoration(
                                  color: playerContainerColor,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15.0),
                                    right: Radius.circular(15.0),
                                  )),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Select"), Text("Reserve")],
                              ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 16.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.0),
                            right: Radius.circular(15.0),
                          ),
                          onTap: () => GoRouter.of(context)
                              .push("/create/addTeamCreate/addPlayer"),
                          child: Container(
                              width: playerContainerWidth,
                              height: playerContainerHeight,
                              decoration: BoxDecoration(
                                  color: playerContainerColor,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15.0),
                                    right: Radius.circular(15.0),
                                  )),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Select"), Text("Back")],
                              ))),
                        ),
                        InkWell(
                          borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(15.0),
                            right: Radius.circular(15.0),
                          ),
                          onTap: () => GoRouter.of(context)
                              .push("/create/addTeamCreate/addPlayer"),
                          child: Container(
                              width: playerContainerWidth,
                              height: playerContainerHeight,
                              decoration: BoxDecoration(
                                  color: playerContainerColor,
                                  borderRadius: BorderRadius.horizontal(
                                    left: Radius.circular(15.0),
                                    right: Radius.circular(15.0),
                                  )),
                              child: Center(
                                  child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [Text("Select"), Text("Midfield")],
                              ))),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10.0,
                    ),
                    InkWell(
                      borderRadius: BorderRadius.horizontal(
                        left: Radius.circular(15.0),
                        right: Radius.circular(15.0),
                      ),
                      onTap: () => GoRouter.of(context)
                          .push("/create/addTeamCreate/addPlayer"),
                      child: Container(
                          width: playerContainerWidth,
                          height: playerContainerHeight,
                          decoration: BoxDecoration(
                              color: playerContainerColor,
                              borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(15.0),
                                right: Radius.circular(15.0),
                              )),
                          child: Center(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [Text("Select"), Text("Forward")],
                          ))),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.0,
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
                      "Add Team",
                      style: TextStyle(
                        fontFamily: "Inter",
                        fontSize: 15,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
