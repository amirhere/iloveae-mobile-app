import 'package:flutter/material.dart';



class StacyPage extends StatefulWidget {
    StacyPage({Key key, this.title}) : super(key: key);
    final String title;

    @override
    _StacyPageState createState() => new _StacyPageState();
}




class _StacyPageState extends State<StacyPage> {

    FocusNode _focus = new FocusNode();

    List fullTaskDetailsList = [];
    List taskDetailsList = [];
    List selectedValuesFromList = [];
    TextEditingController mycontroller = TextEditingController();
    List checkedFlag = List.filled(countryList.length, false);
    void searchMethodWithTest(String text) {
        List result = [];
        print("Text: " + text.length.toString());
        if (mycontroller.text.isNotEmpty) {
            fullTaskDetailsList.forEach((element) {
                text = text.trim();
                if (element["name"].toLowerCase().contains(text)) {
                    result.add(element);
                }
            });
            print(taskDetailsList.toString());
            setState(() {
                taskDetailsList = result;
            });
            return;
        } else {
            setState(() {
                taskDetailsList = fullTaskDetailsList;
            });
            return;
        }
    }

    @override
    void initState() {

        _focus.addListener(_onFocusChange);

        fullTaskDetailsList = countryList;
        taskDetailsList = fullTaskDetailsList;
        super.initState();
    }


    void _onFocusChange(){
        debugPrint("Focus: "+_focus.hasFocus.toString());
    }




    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text((widget.title != null)?widget.title: "wifi"),
            ),
            body: SingleChildScrollView(
                child: Center(
                    child: Column(
                        children: [


                            SizedBox(height: 100),
                            TextField(
                                focusNode: _focus,
                                controller: mycontroller,
                                onChanged: (value) {
                                    searchMethodWithTest(mycontroller.text.toLowerCase());
                                },
                                decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(10),
                                    hintText: "Search For Countries",
                                ),
                            ),
                            Text("Searched for: ${mycontroller.text}"),

                    (_focus.hasFocus)?
                            Container(
                                width: double.infinity,
                                height: 200.0,
                                child: ListView.builder(
                                    itemCount: taskDetailsList.length,
                                    itemBuilder: (context, index) {
                                        return ListTile(
                                            leading: Checkbox(
                                                value: taskDetailsList[index]["checked"],
                                                onChanged: (value) {
                                                    String name = taskDetailsList[index]["name"];
                                                    print(name);

                                                    if(value){
                                                        selectedValuesFromList.add(name);
                                                    }else{

                                                        if(selectedValuesFromList.contains(name)){
                                                             selectedValuesFromList.remove(name);
                                                        }

                                                    }

                                                    print(selectedValuesFromList);


                                                    List temp = [];
                                                    fullTaskDetailsList.forEach((element) {
                                                        if (element["name"] == name) {
                                                            temp.add({
                                                                "name": name,
                                                                "checked": !element["checked"]
                                                            });
                                                        } else {
                                                            temp.add(element);
                                                        }
                                                    });
                                                    setState(() {
                                                        fullTaskDetailsList = temp;
                                                    });
                                                    searchMethodWithTest(mycontroller.text.toLowerCase());
                                                },
                                            ),
                                            title: Text(
                                                (taskDetailsList[index]["name"] !=null) ? taskDetailsList[index]["name"]:'hola',
                                                style: TextStyle(
                                                    fontSize: 20.0,
                                                ),
                                            ),
                                        );
                                    }),
                            ):SizedBox()
                        ],
                    ),
                ),
            ),
            // This trailing comma makes auto-formatting nicer for build methods.
        );
    }
}






const countryList = [

    {"name": "Afghanistan", "checked": true},
    {"name": "Albania", "checked": false},
    {"name": "Algeria", "checked": false},
    {"name": "American Samoa", "checked": false},
    {"name": "Andorra", "checked": false},
    {"name": "Angola", "checked": false},
    {"name": "Anguilla", "checked": false},
    {"name": "Antarctica", "checked": false},
    {"name": "Antigua and Barbuda", "checked": false},
    {"name": "Argentina", "checked": false},
    {"name": "Armenia", "checked": false}

];

