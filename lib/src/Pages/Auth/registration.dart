import 'package:flutter/material.dart';

import 'dart:io';

import 'package:flutter/foundation.dart';

import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:toast/toast.dart';
import 'package:load/load.dart';

import 'package:image_picker/image_picker.dart';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';

import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:flutter_login_signup/src/Widgets/customAppBar.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:flutter_login_signup/src/Widgets/listViewTileWidget.dart';

class AccountPage extends StatefulWidget {
  AccountPage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  bool isProgressBarVisible = false;

  final ScrollController scrollController = ScrollController();

  List<Step> steps;
  String selectCity = "";

  String status = "";
  List<String> statusTypes = [
    "Active",
    "Not Active",
  ];

  String _countryDropDownValue = "Country *";
  var _countryDropDownListItem = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Anguilla",
    "Antigua &amp; Barbuda",
    "Argentina",
    "Armenia",
    "Aruba",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bermuda",
    "Bhutan",
    "Bolivia",
    "Bosnia &amp; Herzegovina",
    "Botswana",
    "Brazil",
    "British Virgin Islands",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cambodia",
    "Cameroon",
    "Cape Verde",
    "Cayman Islands",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Congo",
    "Cook Islands",
    "Costa Rica",
    "Cote D Ivoire",
    "Croatia",
    "Cruise Ship",
    "Cuba",
    "Cyprus",
    "Czech Republic",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Estonia",
    "Ethiopia",
    "Falkland Islands",
    "Faroe Islands",
    "Fiji",
    "Finland",
    "France",
    "French Polynesia",
    "French West Indies",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Gibraltar",
    "Greece",
    "Greenland",
    "Grenada",
    "Guam",
    "Guatemala",
    "Guernsey",
    "Guinea",
    "Guinea Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hong Kong",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Isle of Man",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jersey",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kuwait",
    "Kyrgyz Republic",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Macau",
    "Macedonia",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Montserrat",
    "Morocco",
    "Mozambique",
    "Namibia",
    "Nepal",
    "Netherlands",
    "Netherlands Antilles",
    "New Caledonia",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "Norway",
    "Oman",
    "Pakistan",
    "Palestine",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Puerto Rico",
    "Qatar",
    "Reunion",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Pierre &amp; Miquelon",
    "Samoa",
    "San Marino",
    "Satellite",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "South Africa",
    "South Korea",
    "Spain",
    "Sri Lanka",
    "St Kitts &amp; Nevis",
    "St Lucia",
    "St Vincent",
    "St. Lucia",
    "Sudan",
    "Suriname",
    "Swaziland",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor L'Este",
    "Togo",
    "Tonga",
    "Trinidad &amp; Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Turks &amp; Caicos",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "Uruguay",
    "Uzbekistan",
    "Venezuela",
    "Vietnam",
    "Virgin Islands (US)",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  String selectMaritalStatus = "";

  List selectedValuesFromOccupationList = [];
  String _occupationDropDownValue = 'Occupation *';
  String _secondOccupationDropDownValue = 'Other Occupation *';
  String _maritalStatusDropDownValue = 'Marital Status *';
  String _genderDropDownValue = 'Gender *';
  String _bloodTypeDropDownValue = 'Blood Type *';
  String _mobileCountryCodeDropDownValue = '+961';
  String _phoneCountryCodeDropDownValue = '+961';

  var _martialStatusDropdownListItem = [
    "Single",
    "Married",
    "Widowed",
    "Divorced",
  ];

  List suggestionList = [
    "Academic librarian",
    "Accountant",
    "Accounting technician",
    "Actuary",
    "Adult nurse",
    "Advertising account executive",
    "Advertising account planner",
    "Advertising copywriter",
    "Advice worker",
    "Advocate (Scotland)",
    "Aeronautical engineer",
    "Agricultural consultant",
    "Agricultural manager",
    "Aid worker/humanitarian worker",
    "Air traffic controller",
    "Airline cabin crew",
    "Amenity horticulturist",
    "Analytical chemist",
    "Animal nutritionist",
    "Animator",
    "Archaeologist",
    "Architect",
    "Architectural technologist",
    "Archivist",
    "Armed forces officer",
    "Aromatherapist",
    "Art therapist",
    "Arts administrator",
    "Auditor",
    "Automotive engineer",
    "Barrister",
    "Barrister’s clerk",
    "Bilingual secretary",
    "Biomedical engineer",
    "Biomedical scientist",
    "Biotechnologist",
    "Brand manager",
    "Broadcasting presenter",
    "Building control officer/surveyor",
    "Building services engineer",
    "Building surveyor",
    "Camera operator",
    "Careers adviser (higher education)",
    "Careers adviser",
    "Careers consultant",
    "Cartographer",
    "Catering manager",
    "Charities administrator",
    "Charities fundraiser",
    "Chemical (process) engineer",
    "Child psychotherapist",
    "Children's nurse",
    "Chiropractor",
    "Civil engineer",
    "Civil Service administrator",
    "Clinical biochemist",
    "Clinical cytogeneticist",
    "Clinical microbiologist",
    "Clinical molecular geneticist",
    "Clinical research associate",
    "Clinical scientist - tissue typing",
    "Clothing and textile technologist",
    "Colour technologist",
    "Commercial horticulturist",
    "Commercial/residential/rural surveyor",
    "Commissioning editor",
    "Commissioning engineer",
    "Commodity broker",
    "Communications engineer",
    "Community arts worker",
    "Community education officer",
    "Community worker",
    "Company secretary",
    "Computer sales support",
    "Computer scientist",
    "Conference organiser",
    "Consultant",
    "Consumer rights adviser",
    "Control and instrumentation engineer",
    "Corporate banker",
    "Corporate treasurer",
    "Counsellor",
    "Courier/tour guide",
    "Court reporter/verbatim reporter",
    "Credit analyst",
    "Crown Prosecution Service lawyer",
    "Crystallographer",
    "Curator",
    "Customs officer",
    "Cyber security specialist",
    "Dance movement therapist",
    "Data analyst",
    "Data scientist",
    "Data visualisation analyst",
    "Database administrator",
    "Debt/finance adviser",
    "Dental hygienist",
    "Dentist",
    "Design engineer",
    "Dietitian",
    "Diplomatic service",
    "Doctor (general practitioner, GP)",
    "Doctor (hospital)",
    "Dramatherapist",
    "Economist",
    "Editorial assistant",
    "Education administrator",
    "Electrical engineer",
    "Electronics engineer",
    "Employment advice worker",
    "Energy conservation officer",
    "Engineering geologist",
    "Environmental education officer",
    "Environmental health officer",
    "Environmental manager",
    "Environmental scientist",
    "Equal opportunities officer",
    "Equality and diversity officer",
    "Ergonomist",
    "Estate agent",
    "European Commission administrators",
    "Exhibition display designer",
    "Exhibition organiser",
    "Exploration geologist",
    "Facilities manager",
    "Field trials officer",
    "Financial manager",
    "Firefighter",
    "Fisheries officer",
    "Fitness centre manager",
    "Food scientist",
    "Food technologist",
    "Forensic scientist",
    "Geneticist",
    "Geographical information systems manager",
    "Geomatics/land surveyor",
    "Government lawyer",
    "Government research officer",
    "Graphic designer",
    "Health and safety adviser",
    "Health and safety inspector",
    "Health promotion specialist",
    "Health service manager",
    "Health visitor",
    "Herbalist",
    "Heritage manager",
    "Higher education administrator",
    "Higher education advice worker",
    "Homeless worker",
    "Horticultural consultant",
    "Hotel manager",
    "Housing adviser",
    "Human resources officer",
    "Hydrologist",
    "Illustrator",
    "Immigration officer",
    "Immunologist",
    "Industrial/product designer",
    "Information scientist",
    "Information systems manager",
    "Information technology/software trainers",
    "Insurance broker",
    "Insurance claims inspector",
    "Insurance risk surveyor",
    "Insurance underwriter",
    "Interpreter",
    "Investment analyst",
    "Investment banker - corporate finance",
    "Investment banker – operations",
    "Investment fund manager",
    "IT consultant",
    "IT support analyst",
    "Journalist",
    "Laboratory technician",
    "Land-based engineer",
    "Landscape architect",
    "Learning disability nurse",
    "Learning mentor",
    "Lecturer (adult education)",
    "Lecturer (further education)",
    "Lecturer (higher education)",
    "Legal executive",
    "Leisure centre manager",
    "Licensed conveyancer",
    "Local government administrator",
    "Local government lawyer",
    "Logistics/distribution manager",
    "Magazine features editor",
    "Magazine journalist",
    "Maintenance engineer",
    "Management accountant",
    "Manufacturing engineer",
    "Manufacturing machine operator",
    "Manufacturing toolmaker",
    "Marine scientist",
    "Market research analyst",
    "Market research executive",
    "Marketing account manager",
    "Marketing assistant",
    "Marketing executive",
    "Marketing manager (social media)",
    "Materials engineer",
    "Materials specialist",
    "Mechanical engineer",
    "Media analyst",
    "Media buyer",
    "Media planner",
    "Medical physicist",
    "Medical representative",
    "Mental health nurse",
    "Metallurgist",
    "Meteorologist",
    "Microbiologist",
    "Midwife",
    "Mining engineer",
    "Mobile developer",
    "Multimedia programmer",
    "Multimedia specialists",
    "Museum education officer",
    "Museum/gallery exhibition officer",
    "Music therapist",
    "Nanoscientist",
    "Nature conservation officer",
    "Naval architect",
    "Network administrator",
    "Nurse",
    "Nutritional therapist",
    "Nutritionist",
    "Occupational therapist",
    "Oceanographer",
    "Office manager",
    "Operational researcher",
    "Orthoptist",
    "Outdoor pursuits manager",
    "Packaging technologist",
    "Paediatric nurse",
    "Paramedic",
    "Patent attorney",
    "Patent examiner",
    "Pension scheme manager",
    "Personal assistant",
    "Petroleum engineer",
    "Pharmacist",
    "Pharmacologist",
    "Pharmacovigilance officer",
    "Photographer",
    "Physiotherapist",
    "Picture researcher",
    "Planning and development surveyor",
    "Planning technician",
    "Plant breeder",
    "Police officer",
    "Political party agent",
    "Political party research officer",
    "Practice nurse",
    "Press photographer",
    "Press sub-editor",
    "Prison officer",
    "Private music teacher",
    "Probation officer",
    "Product development scientist",
    "Production manager",
    "Programme researcher",
    "Project manager",
    "Psychologist (clinical)",
    "Psychologist (educational)",
    "Psychotherapist",
    "Public affairs consultant (lobbyist)",
    "Public affairs consultant (research)",
    "Public house manager",
    "Public librarian",
    "Public relations (PR) officer",
    "QA analyst",
    "Quality assurance manager",
    "Quantity surveyor",
    "Records manager",
    "Recruitment consultant",
    "Recycling officer",
    "Regulatory affairs officer",
    "Research chemist",
    "Research scientist",
    "Restaurant manager",
    "Retail banker",
    "Retail buyer",
    "Retail manager",
    "Retail merchandiser",
    "Retail pharmacist",
    "Sales executive",
    "Sales manager",
    "Scene of crime officer",
    "Secretary",
    "Seismic interpreter",
    "Site engineer",
    "Site manager",
    "Social researcher",
    "Social worker",
    "Software developer",
    "Soil scientist",
    "Solicitor",
    "Speech and language therapist",
    "Sports coach",
    "Sports development officer",
    "Sports therapist",
    "Statistician",
    "Stockbroker",
    "Structural engineer",
    "Systems analyst",
    "Systems developer",
    "Tax inspector",
    "Teacher (nursery/early years)",
    "Teacher (primary)",
    "Teacher (secondary)",
    "Teacher (special educational needs)",
    "Teaching/classroom assistant",
    "Technical author",
    "Technical sales engineer",
    "TEFL/TESL teacher",
    "Television production assistant",
    "Test automation developer",
    "Tour operator",
    "Tourism officer",
    "Tourist information manager",
    "Town and country planner",
    "Toxicologist",
    "Trade union research officer",
    "Trader",
    "Trading standards officer",
    "Training and development officer",
    "Translator",
    "Transportation planner",
    "Travel agent",
    "TV/film/theatre set designer",
    "UX designer",
    "Validation engineer",
    "Veterinary nurse",
    "Veterinary surgeon",
    "Video game designer",
    "Video game developer",
    "Volunteer work organiser",
    "Warehouse manager",
    "Waste disposal officer",
    "Water conservation officer",
    "Water engineer",
    "Web designer",
    "Web developer",
    "Welfare rights adviser",
    "Writer",
    "Youth worker"
  ];
  var _genderDropDownListItem = ["Male", "Female"];
  var _bloodTypeDropDownListItem = [
    "A+",
    "A-",
    "B+",
    "B-",
    "O+",
    "O-",
    "AB+",
    "AB-"
  ];

  var _mobileCountryCodeDropDownListItem = [
    "+1",
    "+20",
    "+210",
    "+211",
    "+212",
    "+213",
    "+214",
    "+215",
    "+216",
    "+217",
    "+218",
    "+219",
    "+220",
    "+221",
    "+222",
    "+223",
    "+224",
    "+225",
    "+226",
    "+227",
    "+228",
    "+229",
    "+230",
    "+231",
    "+232",
    "+233",
    "+234",
    "+235",
    "+236",
    "+237",
    "+238",
    "+239",
    "+240",
    "+241",
    "+242",
    "+243",
    "+244",
    "+245",
    "+246",
    "+247",
    "+248",
    "+249",
    "+250",
    "+251",
    "+252",
    "+253",
    "+254",
    "+255",
    "+256",
    "+257",
    "+258",
    "+259",
    "+260",
    "+261",
    "+262",
    "+263",
    "+264",
    "+265",
    "+266",
    "+267",
    "+268",
    "+269",
    "+270",
    "+271",
    "+272",
    "+273",
    "+274",
    "+275",
    "+276",
    "+277",
    "+278",
    "+279",
    "+280",
    "+281",
    "+282",
    "+283",
    "+284",
    "+285",
    "+286",
    "+287",
    "+288",
    "+289",
    "+290",
    "+291",
    "+292",
    "+293",
    "+294",
    "+295",
    "+296",
    "+297",
    "+298",
    "+299",
    "+30",
    "+31",
    "+32",
    "+33",
    "+34",
    "+350",
    "+351",
    "+352",
    "+353",
    "+354",
    "+355",
    "+356",
    "+357",
    "+358",
    "+359",
    "+36",
    "+370",
    "+371",
    "+373",
    "+374",
    "+377",
    "+38",
    "+380",
    "+381",
    "+385",
    "+387",
    "+387",
    "+389",
    "+39",
    "+39-",
    "+40",
    "+41",
    "+42",
    "+43",
    "+44",
    "+45",
    "+46",
    "+47",
    "+48",
    "+49",
    "+500",
    "+501",
    "+502",
    "+503",
    "+504",
    "+505",
    "+506",
    "+507",
    "+508",
    "+509",
    "+51",
    "+52",
    "+53",
    "+54",
    "+55",
    "+56",
    "+57",
    "+58",
    "+590",
    "+591",
    "+592",
    "+593",
    "+594",
    "+595",
    "+596",
    "+597",
    "+598",
    "+599",
    "+60",
    "+61",
    "+62",
    "+63",
    "+64",
    "+65",
    "+66",
    "+670",
    "+671",
    "+672",
    "+673",
    "+674",
    "+676",
    "+677",
    "+678",
    "+679",
    "+680",
    "+681",
    "+682",
    "+683",
    "+684",
    "+685",
    "+687",
    "+688",
    "+689",
    "+690",
    "+691",
    "+692",
    "+7",
    "+808",
    "+809",
    "+81",
    "+82",
    "+84",
    "+850",
    "+852",
    "+853",
    "+856",
    "+86",
    "+871",
    "+872",
    "+873",
    "+874",
    "+880",
    "+886",
    "+90",
    "+92",
    "+93",
    "+94",
    "+95",
    "+960",
    "+961",
    "+962",
    "+963",
    "+964",
    "+965",
    "+966",
    "+967",
    "+968",
    "+969",
    "+971",
    "+972",
    "+973",
    "+974",
    "+975",
    "+976",
    "+977",
    "+98",
    "+993",
    "+994",
    "+995",
  ];

  var _phoneCountryCodeDropDownListItem = [
    "+1",
    "+20",
    "+210",
    "+211",
    "+212",
    "+213",
    "+214",
    "+215",
    "+216",
    "+217",
    "+218",
    "+219",
    "+220",
    "+221",
    "+222",
    "+223",
    "+224",
    "+225",
    "+226",
    "+227",
    "+228",
    "+229",
    "+230",
    "+231",
    "+232",
    "+233",
    "+234",
    "+235",
    "+236",
    "+237",
    "+238",
    "+239",
    "+240",
    "+241",
    "+242",
    "+243",
    "+244",
    "+245",
    "+246",
    "+247",
    "+248",
    "+249",
    "+250",
    "+251",
    "+252",
    "+253",
    "+254",
    "+255",
    "+256",
    "+257",
    "+258",
    "+259",
    "+260",
    "+261",
    "+262",
    "+263",
    "+264",
    "+265",
    "+266",
    "+267",
    "+268",
    "+269",
    "+270",
    "+271",
    "+272",
    "+273",
    "+274",
    "+275",
    "+276",
    "+277",
    "+278",
    "+279",
    "+280",
    "+281",
    "+282",
    "+283",
    "+284",
    "+285",
    "+286",
    "+287",
    "+288",
    "+289",
    "+290",
    "+291",
    "+292",
    "+293",
    "+294",
    "+295",
    "+296",
    "+297",
    "+298",
    "+299",
    "+30",
    "+31",
    "+32",
    "+33",
    "+34",
    "+350",
    "+351",
    "+352",
    "+353",
    "+354",
    "+355",
    "+356",
    "+357",
    "+358",
    "+359",
    "+36",
    "+370",
    "+371",
    "+373",
    "+374",
    "+377",
    "+38",
    "+380",
    "+381",
    "+385",
    "+387",
    "+387",
    "+389",
    "+39",
    "+39-",
    "+66982",
    "66982",
    "+40",
    "+41",
    "+42",
    "+43",
    "+44",
    "+45",
    "+46",
    "+47",
    "+48",
    "+49",
    "+500",
    "+501",
    "+502",
    "+503",
    "+504",
    "+505",
    "+506",
    "+507",
    "+508",
    "+509",
    "+51",
    "+52",
    "+53",
    "+54",
    "+55",
    "+56",
    "+57",
    "+58",
    "+590",
    "+591",
    "+592",
    "+593",
    "+594",
    "+595",
    "+596",
    "+597",
    "+598",
    "+599",
    "+60",
    "+61",
    "+62",
    "+63",
    "+64",
    "+65",
    "+66",
    "+670",
    "+671",
    "+672",
    "+673",
    "+674",
    "+676",
    "+677",
    "+678",
    "+679",
    "+680",
    "+681",
    "+682",
    "+683",
    "+684",
    "+685",
    "+687",
    "+688",
    "+689",
    "+690",
    "+691",
    "+692",
    "+7",
    "+808",
    "+809",
    "+81",
    "+82",
    "+84",
    "+850",
    "+852",
    "+853",
    "+856",
    "+86",
    "+871",
    "+872",
    "+873",
    "+874",
    "+880",
    "+886",
    "+90",
    "+92",
    "+93",
    "+94",
    "+95",
    "+960",
    "+961",
    "+962",
    "+963",
    "+964",
    "+965",
    "+966",
    "+967",
    "+968",
    "+969",
    "+971",
    "+972",
    "+973",
    "+974",
    "+975",
    "+976",
    "+977",
    "+98",
    "+993",
    "+994",
    "+995",
  ];

  TextEditingController gendersSelected = TextEditingController();

  TextEditingController countrySelected = TextEditingController();

  TextEditingController statusSelected = TextEditingController();

  TextEditingController maritalStatusSelected = TextEditingController();

  TextEditingController bloodTypesSelected = TextEditingController();

  TextEditingController passwordTextEditingController =
      new TextEditingController();

  TextEditingController confirmPasswordTextEditingController =
      new TextEditingController();

  TextEditingController nameTextEditingController = new TextEditingController();

  TextEditingController fatherNameTextEditingController =
      new TextEditingController();

  TextEditingController motherNameTextEditingController =
      new TextEditingController();

  TextEditingController nickNameTextEditingController =
      new TextEditingController();

  TextEditingController familyNameTextEditingController =
      new TextEditingController();

  TextEditingController emailTextEditingController =
      new TextEditingController();

  TextEditingController telephoneTextEditingController =
      new TextEditingController();

  TextEditingController mobileTextEditingController =
      new TextEditingController();

  TextEditingController dobTextEditingController = new TextEditingController();

  TextEditingController genderTextEditingController =
      new TextEditingController();

  TextEditingController bloodTypeTextEditingController =
      new TextEditingController();

  TextEditingController maritalStatusTextEditingController =
      new TextEditingController();

  TextEditingController occupationTextEditingController =
      new TextEditingController();

  TextEditingController linkedInUsernameTextEditingController =
      new TextEditingController();

  TextEditingController linkedInUrlTextEditingController =
      new TextEditingController();

  TextEditingController countryTextEditingController =
      new TextEditingController();

  TextEditingController cityTextEditingController = new TextEditingController();

  TextEditingController streetTextEditingController =
      new TextEditingController();

  TextEditingController zipCodeTextEditingController =
      new TextEditingController();

  TextEditingController stateTextEditingController =
      new TextEditingController();

  List<Color> _nameColors = [Color(0xFF573555), Colors.red];
  Color nameColor;

  List<Color> _fatherNameColors = [Color(0xFF573555), Colors.red];
  Color fatherNameColor;

  List<Color> _motherNameColors = [Color(0xFF573555), Colors.red];
  Color motherNameColor;

  List<Color> _familyNameColors = [Color(0xFF573555), Colors.red];
  Color familyNameColor;

  List<Color> _dobColors = [Color(0xFF573555), Colors.red];
  Color dobColor;

  List<Color> _genderColors = [Color(0xFF573555), Colors.red];
  Color genderColor;

  List<Color> _bloodTypeColors = [Color(0xFF573555), Colors.red];
  Color bloodTypeColor;

  List<Color> _occupationColors = [Color(0xFF573555), Colors.red];
  Color occupationColor;

  List<Color> _maritalStatusColors = [Color(0xFF573555), Colors.red];
  Color maritalStatusColor;

  List<Color> _countryColors = [Color(0xFF573555), Colors.red];
  Color countryColor;

  List<Color> _cityColors = [Color(0xFF573555), Colors.red];
  Color cityColor;

  List<Color> _streetColors = [Color(0xFF573555), Colors.red];
  Color streetColor;

  List<Color> _emailColors = [Color(0xFF573555), Colors.red];
  Color emailColor;

  List<Color> _passwordColors = [Color(0xFF573555), Colors.red];
  Color passwordColor;

  List<Color> _confirmPasswordColors = [Color(0xFF573555), Colors.red];
  Color confirmPasswordColor;

  List<Color> _telephoneColors = [Color(0xFF573555), Colors.red];
  Color telephoneColor;

  List<Color> _mobileColors = [Color(0xFF573555), Colors.red];
  Color mobileColor;

  FocusNode _focus = new FocusNode();

  List fullTaskDetailsList = [];
  List taskDetailsList = [];
  String typedOccupation = "";
  TextEditingController mycontroller = TextEditingController();
  List checkedFlag = List.filled(countryList.length, false);

  void searchMethodWithTest(String text) {
    List result = [];
    print("Text: " + text.length.toString());
    if (mycontroller.text.isNotEmpty) {
      fullTaskDetailsList.forEach((element) {
        text = text.trim();
        print(element['name']);
        typedOccupation = element['name'];

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

  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Color(0xFF573555)),
            ),
            Text('Back',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _submitButton() {
    return Container(
      color: Color(0xff84849d),
      width: MediaQuery.of(context).size.width,
      padding: EdgeInsets.symmetric(vertical: 15),
      alignment: Alignment.center,
      child: Text(
        'Register Now',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: Color(0xfff79c4f),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'd',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Color(0xffe46b10),
          ),
          children: [
            TextSpan(
              text: 'ev',
              style: TextStyle(color: Color(0xFF573555), fontSize: 30),
            ),
            TextSpan(
              text: 'rnz',
              style: TextStyle(color: Color(0xffe46b10), fontSize: 30),
            ),
          ]),
    );
  }

  Widget getPasswordTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            passwordColor = _passwordColors[0];
          });
        },
        controller: passwordTextEditingController,
        obscureText: true,
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        keyboardType: TextInputType.visiblePassword,
        cursorColor: Color(0xFF573555),
        decoration: InputDecoration(
          labelText: 'Password *',
          labelStyle: TextStyle(
            color: passwordColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: IconButton(
            icon: new Image.asset(
              'assets/password_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getConfirmPasswordTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            confirmPasswordColor = _confirmPasswordColors[0];
          });
        },
        controller: confirmPasswordTextEditingController,
        obscureText: true,
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        keyboardType: TextInputType.visiblePassword,
        cursorColor: Color(0xFF573555),
        decoration: InputDecoration(
          labelText: 'Confirm Password *',
          labelStyle: TextStyle(
            color: confirmPasswordColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: IconButton(
            icon: new Image.asset(
              'assets/confirm_password_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getNameTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            nameColor = _nameColors[0];
          });
        },
        controller: nameTextEditingController,
        textCapitalization: TextCapitalization.sentences,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Name *',
          labelStyle: TextStyle(
            color: nameColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/username_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getFatherNameTextFieldWidget() {
    return new Container(
      width: 400,
      margin: EdgeInsets.only(left: 50),
      child: TextField(
          onTap: () {
            setState(() {
              fatherNameColor = _fatherNameColors[0];
            });
          },
          controller: fatherNameTextEditingController,
          textCapitalization: TextCapitalization.sentences,
          keyboardType: TextInputType.text,
          cursorColor: Color(0xFF573555),
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF573555),
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: 'Father Name *',
            labelStyle: TextStyle(
              color: fatherNameColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),

            //  prefixIcon: Icon(Icons.person, color: Color(0xFF573555),),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          )),
    );
  }

  Widget getMotherNameTextFieldWidget() {
    return new Container(
      width: 400,
      margin: EdgeInsets.only(left: 50),
      child: TextField(
          onTap: () {
            setState(() {
              motherNameColor = _motherNameColors[0];
            });
          },
          textCapitalization: TextCapitalization.sentences,
          controller: motherNameTextEditingController,
          keyboardType: TextInputType.text,
          cursorColor: Color(0xFF573555),
          style: TextStyle(
              fontSize: 13,
              color: Color(0xFF573555),
              fontWeight: FontWeight.bold),
          decoration: InputDecoration(
            labelText: 'Mother Name *',
            labelStyle: TextStyle(
              color: motherNameColor,
              fontWeight: FontWeight.w600,
              fontSize: 13,
            ),

            //  prefixIcon: Icon(Icons.person, color: Color(0xFF573555),),
            enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
            focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          )),
    );
  }

  Widget getNickNameTextFieldWidget() {
    return new Container(
      width: 400,
      margin: EdgeInsets.only(left: 50),
      child: Padding(
          padding: EdgeInsets.only(bottom: 0),
          child: TextField(
              textCapitalization: TextCapitalization.sentences,
              controller: nickNameTextEditingController,
              keyboardType: TextInputType.text,
              cursorColor: Color(0xFF573555),
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF573555),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                // contentPadding: EdgeInsets.all(5),
                //isDense: true,
                hintText: "(ex: nehmeh, Hantouch, Rizk,...)",
                labelText: 'Nick Name (if any)',
                border: InputBorder.none,
                labelStyle: TextStyle(
                  color: Color(0xFF573555),
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),

                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF573555))),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xFF573555))),
              ))),
    );
  }

  Widget getFamilyNameTextFieldWidget() {
    return new Container(
        width: 400,
        margin: EdgeInsets.only(left: 50),
        child: TextField(
            onTap: () {
              setState(() {
                familyNameColor = _familyNameColors[0];
              });
            },
            textCapitalization: TextCapitalization.sentences,
            controller: familyNameTextEditingController,
            keyboardType: TextInputType.text,
            style: TextStyle(
                fontSize: 13,
                color: Color(0xFF573555),
                fontWeight: FontWeight.bold),
            cursorColor: Color(0xFF573555),
            decoration: InputDecoration(
              labelText: 'Family Name *',
              labelStyle: TextStyle(
                color: familyNameColor,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide:
                      BorderSide(color: Theme.of(context).primaryColor)),
            )));
  }

  Widget getEmailTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            emailColor = _emailColors[0];
          });
        },
        controller: emailTextEditingController,
        keyboardType: TextInputType.emailAddress,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Email *',
          labelStyle: TextStyle(
            color: emailColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/email_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getTelephoneTextFieldWidget() {
    return Row(
      children: [


        Expanded(
          flex: 1,
          child: IconButton(
            icon: new Image.asset(
              'assets/telephone_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),


        Expanded(
          flex: 2,
          child: DropdownButton(
            onTap: () {
              setState(() {
                telephoneColor = _telephoneColors[0];
              });
            },
            hint: _phoneCountryCodeDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _phoneCountryCodeDropDownValue,
                    style: TextStyle(
                        color: Color(0xFF573555),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
            // isExpanded: true,
            // iconSize: 30.0,

            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: _phoneCountryCodeDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _phoneCountryCodeDropDownValue = val;
                },
              );
            },
          ),
        ),



        Expanded(
          flex: 4,
          child: TextField(
              onTap: () {
                setState(() {
                  telephoneColor = _telephoneColors[0];
                });
              },
              controller: telephoneTextEditingController,
              keyboardType: TextInputType.phone,
              cursorColor: Color(0xFF573555),
              style: TextStyle(
                  fontSize: 13,
                  color: telephoneColor,
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                contentPadding: EdgeInsets.only(left: 5),
                //  labelText: 'Telephone',
                labelStyle: TextStyle(
                    fontSize: 13,
                    color: telephoneColor,
                    fontWeight: FontWeight.w600),

                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: telephoneColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: telephoneColor)),
              )),
        )
      ],
    );
  }






  Widget getMobileTextFieldWidget() {
    return new Row(
      children: [
        Expanded(
          flex: 1,
          child: IconButton(
            icon: new Image.asset(
              'assets/mobile_icon.png',
              width: 40.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),
        /*Expanded(
          flex: 2,
          child: Container(

            child: DropdownButton(
              hint: _mobileCountryCodeDropDownValue == null
                  ? Text('Dropdown')
                  : Text(
                _mobileCountryCodeDropDownValue,
                style: TextStyle(
                    color: Color(0xFF573555),
                    fontSize: 13,
                    fontWeight: FontWeight.w600),
              ),
              // isExpanded: true,
              // iconSize: 30.0,

              style: TextStyle(
                  color: Color(0xFF573555),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
              items: _mobileCountryCodeDropDownListItem.map(
                    (val) {
                  return DropdownMenuItem<String>(
                    value: val,
                    child: Text(val),
                  );
                },
              ).toList(),
              onChanged: (val) {
                setState(
                      () {
                    _mobileCountryCodeDropDownValue = val;
                  },
                );
              },
            ),
          ),
        ),*/


        Expanded(
          flex: 2,
          child: DropdownButton(
            onTap: () {
              setState(() {
                telephoneColor = _telephoneColors[0];
              });
            },
            hint: _mobileCountryCodeDropDownValue == null
                ? Text('Dropdown')
                : Text(
              _mobileCountryCodeDropDownValue,
              style: TextStyle(
                  color: Color(0xFF573555),
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
            // isExpanded: true,
            // iconSize: 30.0,

            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: _mobileCountryCodeDropDownListItem.map(
                  (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                    () {
                  _mobileCountryCodeDropDownValue = val;
                },
              );
            },
          ),
        ),
        Expanded(
          flex: 4,
          child: TextField(
              onTap: () {
                setState(() {
                  mobileColor = _mobileColors[0];
                });
              },
              controller: mobileTextEditingController,
              keyboardType: TextInputType.phone,
              cursorColor: Color(0xFF573555),
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF573555),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: '',
                labelStyle: TextStyle(
                    color: Color(0xFF573555),
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mobileColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mobileColor)),
              )),
        )
      ],
    );
  }

/*
  Widget getMobileTextFieldWidget() {
    return new Stack(
      children: <Widget>[
        Container(
          //    color: Colors.yellow,
          width: 60,
          //padding: EdgeInsets.only(left: 44.0),
          margin: EdgeInsets.only(
            left: 50.0,
          ),
          child: DropdownButton(
            hint: _mobileCountryCodeDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _mobileCountryCodeDropDownValue,
                    style: TextStyle(
                        color: Color(0xFF573555),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
            // isExpanded: true,
            // iconSize: 30.0,

            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: _mobileCountryCodeDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _mobileCountryCodeDropDownValue = val;
                },
              );
            },
          ),
        ),
        Container(
          // color: Colors.green,
          width: 400,
          height: 40,
            margin: EdgeInsets.only(top: 0.0, left: 115.0),
          padding: EdgeInsets.only(left: 5.0),
          child: TextField(
              onTap: () {
                setState(() {
                  mobileColor = _mobileColors[0];
                });
              },
              controller: mobileTextEditingController,
              keyboardType: TextInputType.phone,
              cursorColor: Color(0xFF573555),
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF573555),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: '',
                labelStyle: TextStyle(
                    color: Color(0xFF573555),
                    fontWeight: FontWeight.w600,
                    fontSize: 13),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mobileColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: mobileColor)),
              )),
        ),
        Container(
          //  color: Colors.purple,
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          child: IconButton(
            icon: new Image.asset(
              'assets/mobile_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }*/




  Widget getStatusTextFieldWidget() {
    return new DropDownField(
      controller: stateTextEditingController,
      hintText: "Status",
      icon: Icon(
        Icons.person_outline,
        color: Color(0xFF573555),
      ),
      enabled: true,
      items: statusTypes,
      onValueChanged: (value) {
        setState(() {
          status = value;
        });
      },
    );
  }

  Widget getDOBTextFieldWidget() {
    return new GestureDetector(
      onTap: () {
        setState(() {
          dobColor = _dobColors[0];
        });

        showDatePicker(
                context: context,
                builder: (BuildContext context, Widget child) {
                  return Theme(
                    data: ThemeData.light().copyWith(
                      primaryColor: const Color(0xFF573555),
                      accentColor: const Color(0xFF573555),
                      colorScheme:
                          ColorScheme.light(primary: const Color(0xFF573555)),
                      buttonTheme:
                          ButtonThemeData(textTheme: ButtonTextTheme.primary),
                    ),
                    child: child,
                  );
                },
                initialDate: DateTime.now(),
                lastDate: DateTime.now(),
                firstDate: DateTime(1900))
            .then((date) {
          setState(() {
            dobTextEditingController.text = date.day.toString() +
                "-" +
                date.month.toString() +
                "-" +
                date.year.toString();
          });
        });
      },
      child: AbsorbPointer(
          child: TextField(
              onTap: () {
                setState(() {
                  dobColor = _dobColors[0];
                });
              },
              controller: dobTextEditingController,
              keyboardType: TextInputType.datetime,
              cursorColor: Color(0xFF573555),
              style: TextStyle(
                  fontSize: 13,
                  color: Color(0xFF573555),
                  fontWeight: FontWeight.bold),
              decoration: InputDecoration(
                labelText: 'Date Of Birth *',
                labelStyle: TextStyle(
                    fontSize: 13, color: dobColor, fontWeight: FontWeight.w600),
                prefixIcon: new IconButton(
                  icon: new Image.asset(
                    'assets/dob_icon.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  onPressed: null,
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide:
                        BorderSide(color: Theme.of(context).primaryColor)),
              ))),
    );
  }

  Widget getGenderTextFieldWidget(double width) {
    //double width = MediaQuery.of(context).size.width;

    return new Stack(
      children: <Widget>[
        Container(
          //  color:Colors.red,
          width: width * 0.18,
          //  color: Colors.red,
          padding: EdgeInsets.only(left: 0.0),
          margin: EdgeInsets.only(
            left: width * 0.1,
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            onTap: () {
              setState(() {
                genderColor = _genderColors[0];
              });
            },
            hint: _genderDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _genderDropDownValue,
                    style: TextStyle(
                        color: genderColor,
                        fontSize: width * 0.028,
                        fontWeight: FontWeight.bold),
                  ),
            isExpanded: true,
            // iconSize: 25.0,
            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.bold),
            items: _genderDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _genderDropDownValue = val;
                },
              );
            },
          )),
        ),
        Container(
          width: width * 0.1,
          //     color: Colors.purple,
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          child: IconButton(
            icon: new Image.asset(
              'assets/gender_icon.png',
              width: width * 0.07,
              height: width * 0.07,
            ),
            onPressed: null,
          ),
        ),
        Container(
          //  color:Colors.green,
          // width: width * 0.30,
          //    color: Colors.blue,
          padding: EdgeInsets.only(left: 0.0),
          margin: EdgeInsets.only(
            left: width * 0.38,
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            onTap: () {
              setState(() {
                bloodTypeColor = _bloodTypeColors[0];
              });
            },
            hint: _bloodTypeDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _bloodTypeDropDownValue,
                    style: TextStyle(
                        color: bloodTypeColor,
                        fontSize: width * 0.025,
                        fontWeight: FontWeight.bold),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: width * 0.035,
                fontWeight: FontWeight.bold),
            items: _bloodTypeDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _bloodTypeDropDownValue = val;
                },
              );
            },
          )),
        ),
        Container(
          width: width * 0.1,

          //  color: Colors.orange,
          margin: EdgeInsets.only(top: 0.0, left: width * 0.28),
          child: IconButton(
            icon: new Image.asset(
              'assets/blood_icon.png',
              width: width * 0.07,
              height: width * 0.07,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }

  Widget getBloodTypeTextFieldWidget() {
    return new Stack(
      children: <Widget>[
        Container(
          color: Colors.brown,
          padding: EdgeInsets.only(left: 44.0),
          margin: EdgeInsets.only(
            left: 5.0,
          ),
          child: DropdownButton(
            hint: _bloodTypeDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _bloodTypeDropDownValue,
                    style: TextStyle(
                        color: Color(0xFF573555),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: _bloodTypeDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _bloodTypeDropDownValue = val;
                },
              );
            },
          ),
        ),
        Container(
          color: Color(0xFF573555),
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          child: IconButton(
            icon: new Image.asset(
              'assets/blood_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }

  Widget getMaritalTextFieldWidget() {
    return new Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 44.0),
          margin: EdgeInsets.only(
            left: 5.0,
          ),
          child: DropdownButtonHideUnderline(
              child: DropdownButton(
            onTap: () {
              setState(() {
                maritalStatusColor = _maritalStatusColors[0];
              });
            },
            hint: _maritalStatusDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _maritalStatusDropDownValue,
                    style: TextStyle(
                        color: maritalStatusColor,
                        fontSize: 13,
                        fontWeight: FontWeight.bold
                        //fontWeight: FontWeight.w600
                        ),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
              color: Color(0xFF573555),
              fontSize: 13,
              fontWeight: FontWeight.bold,
            ),
            items: _martialStatusDropdownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _maritalStatusDropDownValue = val;
                },
              );
            },
          )),
        ),
        Container(
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          child: IconButton(
            icon: new Image.asset(
              'assets/marital_status_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }

  /* Widget getOccupationTextFieldWidget() {
    return Stack(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {});
          },
          child: Container(
            child: AutoCompleteTextField(
              textCapitalization: TextCapitalization.sentences,
              controller: occupationTextEditingController,
              keyboardType: TextInputType.text,
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontWeight: FontWeight.bold,
                  fontSize: 13),
              decoration: InputDecoration(
                labelText: 'Occupation *',
                labelStyle: TextStyle(
                  color: occupationColor,
                  fontSize: 13,
                  fontWeight: FontWeight.bold,
                ),
                prefixIcon: IconButton(
                  icon: new Image.asset(
                    'assets/occupation_icon.png',
                    width: 25.0,
                    height: 25.0,
                  ),
                  onPressed: null,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Theme.of(context).primaryColor),
                ),
              ),
              clearOnSubmit: false,
              suggestions: suggestionList,
              itemFilter: (item, query) {
                return item
                    .toString()
                    .toLowerCase()
                    .startsWith(query.toLowerCase());
              },
              itemSorter: (a, b) {
                return a.compareTo(b);
              },
              itemSubmitted: (item) {
                occupationTextEditingController.text = item;
              },
              itemBuilder: (context, item) {
                return Container(
                  padding: EdgeInsets.all(20),
                  child: Row(
                    children: <Widget>[
                      Text(
                        item,
                      )
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
*/

  Widget getOccupationTextFieldWidget() {
    return SingleChildScrollView(
      child: Center(
        child: Column(
          children: [
            SizedBox(height: 8),
            TextField(
                onTap: () {
                  setState(() {
                    //mycontroller.text = '';
                    occupationColor = _occupationColors[0];
                  });
                },
                focusNode: _focus,
                controller: mycontroller,
                onChanged: (value) {
                  searchMethodWithTest(mycontroller.text.toLowerCase());
                },
                style: TextStyle(
                    fontSize: 13,
                    color: Color(0xFF573555),
                    fontWeight: FontWeight.bold),
                cursorColor: Color(0xFF573555),
                decoration: InputDecoration(
                  prefixIcon: IconButton(
                    icon: new Image.asset(
                      'assets/occupation_icon.png',
                      width: 25.0,
                      height: 25.0,
                    ),
                    onPressed: null,
                  ),
                  labelText: 'Select Occupation',
                  labelStyle: TextStyle(
                    color: occupationColor,
                    fontWeight: FontWeight.w600,
                    fontSize: 13,
                  ),
                  enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Theme.of(context).primaryColor)),
                )),

            (selectedValuesFromOccupationList.length > 0)
                ? Text(
                    "Selected: " + selectedValuesFromOccupationList.toString(),
                    style: TextStyle(fontSize: 11),
                  )
                : SizedBox(),

            //  for ( var i in selectedValuesFromOccupationList ) Padding(padding: EdgeInsets.only(right:100), child: Text(i.toString()),),
            //   Text("Searched for: ${mycontroller.text}"),

            (_focus.hasFocus)
                ? Container(
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
                                  if (value) {
                                    selectedValuesFromOccupationList.add(name);
                                  } else {
                                    if (selectedValuesFromOccupationList
                                        .contains(name)) {
                                      selectedValuesFromOccupationList
                                          .remove(name);
                                    }
                                  }

                                  print(selectedValuesFromOccupationList);

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
                                  searchMethodWithTest(
                                      mycontroller.text.toLowerCase());
                                }),
                            title: Text(
                              (taskDetailsList[index]["name"] != null)
                                  ? taskDetailsList[index]["name"]
                                  : 'hola',
                              style: TextStyle(
                                fontSize: 12.0,
                              ),
                            ),
                          );
                        }),
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }

  Widget getListViewWidget(double height, double width, var dataArray) {
    return ListView.builder(
      itemCount: dataArray == null ? 0 : dataArray.length,
      itemBuilder: (BuildContext context, int index) {
        return GestureDetector(
            onTap: () {},
            child: ListViewTileWidget(
              height: height,
              width: width,
              dataArray: dataArray,
              index: index,
            )

            /* Expanded(
            child: Card(
              child: Row(
                children: <Widget>[
                  Container(
                    height: height / 9,
                    width: width / 4,
                    child: Image(
                      image: NetworkImage(dataArray[index]["thumbnail"]),
                      fit: BoxFit.fill,

                      // backgroundImage: NetworkImage(userData['thumbnail']),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Column(
                      children: <Widget>[
                        ConstrainedBox(
                          constraints: BoxConstraints(
                            minWidth: 280.0,
                            maxWidth: 280.0,
                            minHeight: 10.0,
                            maxHeight: 50.0,
                          ),
                          child: Text(
                            dataArray[index]["description"],

                            style: TextStyle(fontWeight: FontWeight.bold),

                            //overflow: TextOverflow.clip,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 3, left: width * 0.40),
                          child: Text(
                            Jiffy(dataArray[index]["created_at"]).fromNow(),

                            style: TextStyle(fontWeight: FontWeight.w100),

                            //overflow: TextOverflow.clip,
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),*/

            );
      },
    );
  }

/*
  Widget getOccupationTextFieldWidget() {
    return new Stack(
      children: <Widget>[
        Container(
          width: 110,
          //    color: Colors.red,
          padding: EdgeInsets.only(left: 0.0),
          margin: EdgeInsets.only(
            left: 44.0,
          ),
          child: DropdownButton(
            hint: _occupationDropDownValue == null
                ? Text('Dropdown')
                : Text(
                    _occupationDropDownValue,
                    style: TextStyle(
                        color: Color(0xFF573555),
                        fontSize: 13,
                        fontWeight: FontWeight.w600),
                  ),
            isExpanded: true,
            iconSize: 30.0,
            style: TextStyle(
                color: Color(0xFF573555),
                fontSize: 13,
                fontWeight: FontWeight.w600),
            items: _occupationDropDownListItem.map(
              (val) {
                return DropdownMenuItem<String>(
                  value: val,
                  child: Text(val),
                );
              },
            ).toList(),
            onChanged: (val) {
              setState(
                () {
                  _occupationDropDownValue = val;
                },
              );
            },
          ),
        ),

      ],
    );
  }
*/

  Widget getLinkedInUsernameTextFieldWidget() {
    return new TextField(
        controller: linkedInUsernameTextEditingController,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        decoration: InputDecoration(
          labelText: 'LinkedIn Username',
          labelStyle: TextStyle(
            color: Color(0xFF573555),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.link,
            color: Color(0xFF573555),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
        ));
  }

  Widget getLinkedInUrlTextFieldWidget() {
    return new TextField(
        //  controller: emailTextEditingController,
        controller: linkedInUrlTextEditingController,
        keyboardType: TextInputType.url,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Linkedin url',
          labelStyle: TextStyle(
            color: Color(0xFF573555),
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: IconButton(
            icon: new Image.asset(
              'assets/linkedin_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
        ));
  }

  Widget getCountryTextFieldWidget() {
    return AutoCompleteTextField(
      textCapitalization: TextCapitalization.sentences,
      controller: countryTextEditingController,
      keyboardType: TextInputType.text,
      style: TextStyle(
          color: countryColor, fontWeight: FontWeight.bold, fontSize: 13),
      decoration: InputDecoration(
        labelText: 'Country *',
        labelStyle: TextStyle(
            color: countryColor, fontSize: 13, fontWeight: FontWeight.bold),
        prefixIcon: IconButton(
          icon: new Image.asset(
            'assets/country_icon.png',
            width: 25.0,
            height: 25.0,
          ),
          onPressed: null,
        ),
        enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
        ),
      ),
      clearOnSubmit: false,
      suggestions: _countryDropDownListItem,
      itemFilter: (item, query) {
        return item.toString().toLowerCase().startsWith(query.toLowerCase());
      },
      itemSorter: (a, b) {
        return a.compareTo(b);
      },
      itemSubmitted: (item) {
        countryTextEditingController.text = item;
      },
      itemBuilder: (context, item) {
        return Container(
          padding: EdgeInsets.all(20),
          child: Row(
            children: <Widget>[
              Text(
                item,
              )
            ],
          ),
        );
      },
    );
  }

  /*Widget getCountryTextFieldWidget() {
    return new Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(left: 44.0),
          margin: EdgeInsets.only(
            left: 5.0,
          ),
          child: DropdownButtonHideUnderline(child: DropdownButton(
              hint: _countryDropDownValue == null
                  ? Text('Dropdown')
                  : Text(
                  _countryDropDownValue,
                  style: TextStyle(
                      color: Color(0xFF573555),
                      fontSize: 13,
                      fontWeight: FontWeight.bold),
              ),
              isExpanded: true,
              iconSize: 30.0,
              style: TextStyle(
                  color: Color(0xFF573555),
                  fontSize: 13,
                  fontWeight: FontWeight.bold
                  // fontWeight: FontWeight.w600
              ),
              items: _countryDropDownListItem.map(
                      (val) {
                      return DropdownMenuItem<String>(
                          value: val,
                          child: Text(val),
                      );
                  },
              ).toList(),
              onChanged: (val) {
                  setState(
                          () {
                          _countryDropDownValue = val;
                      },
                  );
              },
          )),
        ),
        Container(
          margin: EdgeInsets.only(top: 0.0, left: 0.0),
          child: IconButton(
            icon: new Image.asset(
              'assets/country_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
        ),
      ],
    );
  }
*/
  Widget getCityTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            cityColor = _cityColors[0];
          });
        },
        textCapitalization: TextCapitalization.sentences,
        controller: cityTextEditingController,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'City *',
          labelStyle: TextStyle(
            color: cityColor,
            fontWeight: FontWeight.bold,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/city_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getStreetTextFieldWidget() {
    return new TextField(
        onTap: () {
          setState(() {
            streetColor = _streetColors[0];
          });
        },
        textCapitalization: TextCapitalization.sentences,
        controller: streetTextEditingController,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'Street *',
          labelStyle: TextStyle(
            color: streetColor,
            fontWeight: FontWeight.w600,
            fontSize: 13,
          ),
          prefixIcon: new IconButton(
            icon: new Image.asset(
              'assets/street_icon.png',
              width: 25.0,
              height: 25.0,
            ),
            onPressed: null,
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Theme.of(context).primaryColor)),
        ));
  }

  Widget getStateTextFieldWidget() {
    return new TextField(
        textCapitalization: TextCapitalization.sentences,
        controller: streetTextEditingController,
        keyboardType: TextInputType.text,
        cursorColor: Color(0xFF573555),
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        decoration: InputDecoration(
          labelText: 'State',
          labelStyle: TextStyle(
            color: Color(0xFF573555),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFF573555),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFF573555))),
        ));
  }

  Widget getZipTextFieldWidget() {
    return new TextField(
        controller: zipCodeTextEditingController,
        keyboardType: TextInputType.text,
        style: TextStyle(
            fontSize: 13,
            color: Color(0xFF573555),
            fontWeight: FontWeight.bold),
        cursorColor: Color(0xFF573555),
        decoration: InputDecoration(
          labelText: 'Zip',
          labelStyle: TextStyle(
            color: Color(0xFF573555),
            fontSize: 13,
          ),
          prefixIcon: Icon(
            Icons.lock,
            color: Color(0xFF573555),
          ),
          enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFdde9f2))),
          focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Color(0xFFdde9f2))),
        ));
  }

  Widget getBasicDetailsWidget() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      color: Color(0xffdde9f2),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: 10,
            ),
            //  getNameTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getFatherNameTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getMotherNameTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getNickNameTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getFamilyNameTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getEmailTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getTelephoneTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
            getMobileTextFieldWidget(),
            SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }

  Widget getPersonalDetailsWidget() {
    return Container(
      color: Color(0xFFdde9f2),
      child: Padding(
          padding: EdgeInsets.only(left: 20, right: 20),
          child: Column(
            children: <Widget>[
              getDOBTextFieldWidget(),
              SizedBox(
                height: 10,
              ),

              // getGenderTextFieldWidget(),
              SizedBox(
                height: 10,
              ),

              // getGenderTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getBloodTypeTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getMaritalTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getOccupationTextFieldWidget(),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom + 800,
              ),
              getLinkedInUsernameTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
              getLinkedInUrlTextFieldWidget(),
              SizedBox(
                height: 10,
              ),
            ],
          )),
    );
  }

  Widget getRegistrationButtonWidget() {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context)
            .unfocus(); // hides keyboard so that the toast messages can be seen.

        if (nameTextEditingController.text.length == 0)
          nameColor = _nameColors[1];

        if (fatherNameTextEditingController.text.length == 0)
          fatherNameColor = _fatherNameColors[1];

        if (motherNameTextEditingController.text.length == 0)
          motherNameColor = _motherNameColors[1];

        if (familyNameTextEditingController.text.length == 0)
          familyNameColor = _familyNameColors[1];

        if (dobTextEditingController.text.length == 0) dobColor = _dobColors[1];

        if (selectedValuesFromOccupationList.length == 0)
          occupationColor = _occupationColors[1];

        /* if (occupationTextEditingController.text == "Occupation *")
          occupationColor = _occupationColors[1];*/

        if (countryTextEditingController.text.length == 0) {
          setState(() {
            countryColor = _countryColors[1];
          });
        }

        if (countryTextEditingController.text == 'Country *') {
          setState(() {
            countryColor = _countryColors[1];
          });
        }

        if (streetTextEditingController.text.length == 0) {
          streetColor = _streetColors[1];
        }

        if (cityTextEditingController.text.length == 0) {
          cityColor = _cityColors[1];
        }

        if (_maritalStatusDropDownValue == "Marital Status *") {
          maritalStatusColor = _maritalStatusColors[1];
        }

        if (_genderDropDownValue == "Gender *") {
          genderColor = _genderColors[1];
        }

        if (_bloodTypeDropDownValue == "Blood Type *") {
          bloodTypeColor = _bloodTypeColors[1];
        }

        if (!(RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
            .hasMatch(emailTextEditingController.text))) {
          emailColor = _emailColors[1];
        }

        if (passwordTextEditingController.text.length < 8) {
          passwordColor = _passwordColors[1];
        }

        if (confirmPasswordTextEditingController.text.length < 8) {
          confirmPasswordColor = _confirmPasswordColors[1];
        }

        if (telephoneTextEditingController.text.length < 7) {
          telephoneColor = _telephoneColors[1];
        }

        if (mobileTextEditingController.text.length < 7) {
          mobileColor = _mobileColors[1];
        }

        if (_image != null) {
          if (nameTextEditingController.text.length >= 4) {
            if (fatherNameTextEditingController.text.length >= 4) {
              if (motherNameTextEditingController.text.length >= 4) {
                if (familyNameTextEditingController.text.length >= 4) {
                  if (dobTextEditingController.text.length > 0) {
                    if (_genderDropDownValue.length != 8) {
                      if (_bloodTypeDropDownValue.length <= 3) {
                        if (selectedValuesFromOccupationList.length > 0) {
                          if (_maritalStatusDropDownValue.length != 16) {
                            if (countryTextEditingController.text.length > 0) {
                              if (cityTextEditingController.text.length > 0) {
                                if (streetTextEditingController.text.length >
                                    0) {
                                  if (telephoneTextEditingController
                                          .text.length >=
                                      7) {
                                    if (mobileTextEditingController
                                            .text.length >=
                                        7) {
                                      if (RegExp(
                                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                          .hasMatch(emailTextEditingController
                                              .text)) {
                                        if (passwordTextEditingController
                                                .text.length >=
                                            8) {
                                          if (passwordTextEditingController
                                                  .text ==
                                              confirmPasswordTextEditingController
                                                  .text) {
                                            saveInfoRequest();
                                          } else {
                                            Toast.show("Passwords do not match",
                                                context,
                                                duration: Toast.LENGTH_LONG,
                                                gravity: Toast.BOTTOM);
                                          }
                                        } else {
                                          Toast.show(
                                              "password length should be at least 8 characters",
                                              context,
                                              duration: Toast.LENGTH_LONG,
                                              gravity: Toast.BOTTOM);
                                        }
                                      } else {
                                        Toast.show(
                                            "Invalid Email Address", context,
                                            duration: Toast.LENGTH_LONG,
                                            gravity: Toast.BOTTOM);
                                      }
                                    } else {
                                      Toast.show(
                                          "Mobile field required", context,
                                          duration: Toast.LENGTH_LONG,
                                          gravity: Toast.BOTTOM);
                                    }
                                  } else {
                                    Toast.show(
                                        "Telephone field required", context,
                                        duration: Toast.LENGTH_LONG,
                                        gravity: Toast.BOTTOM);
                                  }
                                } else {
                                  Toast.show("Street field required", context,
                                      duration: Toast.LENGTH_LONG,
                                      gravity: Toast.BOTTOM);
                                }
                              } else {
                                Toast.show("City field required", context,
                                    duration: Toast.LENGTH_LONG,
                                    gravity: Toast.BOTTOM);
                              }
                            } else {
                              Toast.show("Country field required", context,
                                  duration: Toast.LENGTH_LONG,
                                  gravity: Toast.BOTTOM);
                            }
                          } else {
                            Toast.show("Marital Status field required", context,
                                duration: Toast.LENGTH_LONG,
                                gravity: Toast.BOTTOM);
                          }
                        } else {
                          Toast.show("Occupation field required", context,
                              duration: Toast.LENGTH_LONG,
                              gravity: Toast.BOTTOM);
                        }
                      } else {
                        Toast.show("Blood Type field required", context,
                            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                      }
                    } else {
                      Toast.show("Gender Required", context,
                          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                    }
                  } else {
                    Toast.show("Date of Birth Required", context,
                        duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
                  }
                } else {
                  Toast.show(
                      "Family Name length should be atleast 4 characters",
                      context,
                      duration: Toast.LENGTH_LONG,
                      gravity: Toast.BOTTOM);
                }
              } else {
                Toast.show(
                    "Mother name should be atleast 4 characters long", context,
                    duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
              }
            } else {
              Toast.show(
                  "Father name should be atleast 4 characters long", context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          } else {
            setState(() {
              nameColor = _nameColors[1];
            });

            Toast.show("Name length should be atleast 4 characters", context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show("Please upload photo", context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      },
      child: new Container(
        color: Color(0xff84849d),
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        child: RichText(
          text: new TextSpan(
            text: 'REGISTRATION',
            style: new TextStyle(
              fontWeight: FontWeight.w900,
              color: Color(0xFF573555),
            ),
          ),
        ),
      ),
    );
  }

  /*   Stepper Functionality Snippet    */

  int currentStep = 0;
  bool complete = false;

  next() {}

  cancel() {
    if (currentStep > 0) {
      goTo(currentStep - 1);
    }
  }

  goTo(int step) {
    setState(() {
      currentStep = step;
    });
  }

  @override
  void initState() {
    super.initState();

    nameColor = _nameColors[0];
    fatherNameColor = _fatherNameColors[0];
    motherNameColor = _motherNameColors[0];
    familyNameColor = _familyNameColors[0];
    dobColor = _dobColors[0];
    genderColor = _genderColors[0];
    bloodTypeColor = _bloodTypeColors[0];
    maritalStatusColor = _maritalStatusColors[0];
    occupationColor = _occupationColors[0];
    cityColor = _cityColors[0];
    streetColor = _streetColors[0];
    countryColor = _countryColors[0];
    emailColor = _emailColors[0];
    passwordColor = _passwordColors[0];
    confirmPasswordColor = _confirmPasswordColors[0];
    telephoneColor = _telephoneColors[0];
    mobileColor = _mobileColors[0];

    _focus.addListener(_onFocusChange);

    fullTaskDetailsList = countryList;
    taskDetailsList = fullTaskDetailsList;
    super.initState();
  }

  void _onFocusChange() {
    debugPrint("Focus: " + _focus.hasFocus.toString());
  }

  /*   Image Picker Snippet  */
  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
      _cropImage(image);
    }

    /*setState(() {
      _image = image;
    });*/
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);
    if (image != null) {
      _cropImage(image);
    }

    /* setState(() {
      _image = image;
    });*/
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _cropImage(image) async {
    File cropped = await ImageCropper.cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: 1.0, ratioY: 1.0));

    if (cropped != null) {
      setState(() {
        _image = cropped;
      });
    }
  }

  /* Http Requests */

  void saveInfoRequest() async {
    showLoadingDialog();

    var request = http.MultipartRequest(
        "POST",
        //  Uri.parse("http://pitstopsystems.com/iloveae/api/public/register"));
        Uri.parse(Helper.register));
    //add text fields
    request.fields["name"] = nameTextEditingController.text;
    request.fields["nick_name"] = nickNameTextEditingController.text;
    request.fields["family_name"] = familyNameTextEditingController.text;
    request.fields["father_name"] = fatherNameTextEditingController.text;
    request.fields["mother_name"] = motherNameTextEditingController.text;

    request.fields["email"] = emailTextEditingController.text;
    request.fields["dob"] = dobTextEditingController.text;
    request.fields["gender"] = _genderDropDownValue;
    request.fields["blood_type"] = _bloodTypeDropDownValue;
    request.fields["occupation"] = 'this is occupation';
    request.fields["second_occupation"] = "this is occupation";

    request.fields["marital_status"] = _maritalStatusDropDownValue;
    request.fields["country"] = countryTextEditingController.text;
    request.fields["city"] = cityTextEditingController.text;
    request.fields["street"] = streetTextEditingController.text;
    request.fields["mobile_country_code"] = _mobileCountryCodeDropDownValue;
    request.fields["mobile"] = mobileTextEditingController.text;
    request.fields["phone_country_code"] = _phoneCountryCodeDropDownValue;
    request.fields["phone"] = telephoneTextEditingController.text;
    request.fields["password"] = passwordTextEditingController.text;
    request.fields["password_confirm"] =
        confirmPasswordTextEditingController.text;
    request.fields["linkedin_url"] = linkedInUrlTextEditingController.text;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("photo_url", _image.path);
    //add multipart to request
    request.files.add(pic);

    /*   ONE WAY TO SEND AND RECEIVE RESPONSE
        var response = await request.send();
        var responseData = await response.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);
        print(responseString);
    */

    /* SECOND WAY TO SEND AND RECEIVE RESPONSE */

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");

    if ("${response.statusCode}" == "200") {
      Toast.show("Account Created successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);

      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => LoginPage()));
    } else {
      Toast.show("Email Already exists", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    hideLoadingDialog();
  }

  var showProgressBar = Visibility(
    child: Image(
        image: AssetImage('assets/progressBar.gif'), width: 50, height: 50),
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: true,
  );

  void filterSearchResults(String query) {
    List<String> dummySearchList = List<String>();
    _countryDropDownListItem.addAll(_countryDropDownListItem);
    if (query.isNotEmpty) {
      List<String> dummyListData = List<String>();
      dummySearchList.forEach((item) {
        if (item.contains(query)) {
          dummyListData.add(item);
        }
      });
      setState(() {
        _countryDropDownListItem.clear();
        _countryDropDownListItem.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        _countryDropDownListItem.clear();
        _countryDropDownListItem.addAll(_countryDropDownListItem);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: Color(0xffc7dceb),
      bottomNavigationBar: new Container(
        height: 20.0,
        color: Color(0xFF573555),
      ),
      appBar: CustomAppBar(
        title: "Registration Form",
        height: height,
        width: width / 8,
      ),
      body: new GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(new FocusNode()),
        child: Stack(
          children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 0),
              child: SingleChildScrollView(
                child: Container(
                  //   color: Color(0xFFdde9f2),
                  padding: EdgeInsets.all(20.0),
                  margin: EdgeInsets.symmetric(horizontal: 35),
                  child: Column(
                    children: <Widget>[
                      Container(
                        height: height / 3.5,

                        //   width: 500,
                        color: Color(0xffc7dceb),
                        child: Center(
                            child: GestureDetector(
                                onTap: () {
                                  _showPicker(context);
                                },
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundColor: Color(0xff573555),
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(70),
                                          child: Image.file(
                                            _image,
                                            width: 200,
                                            height: 200,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF84849d),
                                            borderRadius:
                                                BorderRadius.circular(70),
                                          ),
                                          width: 200,
                                          height: 200,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color:
                                                Theme.of(context).primaryColor,
                                          ),
                                        ),
                                ))),
                      ),
                      Container(
                        color: Color(0xFFdde9f2),
                        padding: EdgeInsets.symmetric(horizontal: 15),
                        child: Column(
                          children: <Widget>[
                            /*   Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextField(
                                    onChanged: (value) {
                                        filterSearchResults(value);
                                    },
                                    controller: occupationTextEditingController,
                                    decoration: InputDecoration(
                                        labelText: "Search",
                                        hintText: "Search",
                                        prefixIcon: Icon(Icons.search),
                                        border: OutlineInputBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(25.0)))),
                                ),
                            ),
                            Expanded(
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: _countryDropDownListItem.length,
                                    itemBuilder: (context, index) {
                                        return ListTile(
                                            title: Text('${_countryDropDownListItem[index]}'),
                                        );
                                    },
                                ),
                            ),
*/
                            getNameTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getFatherNameTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getMotherNameTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getNickNameTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getFamilyNameTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getDOBTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getGenderTextFieldWidget(width),
                            Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            getOccupationTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getMaritalTextFieldWidget(),
                            Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                              thickness: 1,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            getCountryTextFieldWidget(),
                            Divider(
                              height: 1,
                              color: Theme.of(context).primaryColor,
                              thickness: 0.3,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            getCityTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getStreetTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getTelephoneTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getMobileTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getLinkedInUrlTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getEmailTextFieldWidget(),
                            SizedBox(
                              height: 20,
                            ),
                            getPasswordTextFieldWidget(),
                            SizedBox(
                              height: 10,
                            ),
                            getConfirmPasswordTextFieldWidget(),
                            (isProgressBarVisible)
                                ? showProgressBar
                                : //,

                                SizedBox(
                                    height: 10,
                                  ),
                            SizedBox(
                              height: 10,
                            ),
                            getRegistrationButtonWidget(),
                            SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

const countryList = [
  {"name": "Academic librarian", "checked": false},
  {"name": "Accountant", "checked": false},
  {"name": "Accounting technician", "checked": false},
  {"name": "Actuary", "checked": false},
  {"name": "Adult nurse", "checked": false},
  {"name": "Advertising account executive", "checked": false},
  {"name": "Advertising account planner", "checked": false},
  {"name": "Advertising copywriter", "checked": false},
  {"name": "Advice worker", "checked": false},
  {"name": "Advocate (Scotland)", "checked": false},
  {"name": "Aeronautical engineer", "checked": false},
  {"name": "Agricultural consultant", "checked": false},
  {"name": "Agricultural manager", "checked": false},
  {"name": "Aid worker/humanitarian worker", "checked": false},
  {"name": "Air traffic controller", "checked": false},
  {"name": "Airline cabin crew", "checked": false},
  {"name": "Amenity horticulturist", "checked": false},
  {"name": "Analytical chemist", "checked": false},
  {"name": "Animal nutritionist", "checked": false},
  {"name": "Animator", "checked": false},
  {"name": "Archaeologist", "checked": false},
  {"name": "Architect", "checked": true},
  {"name": "Architectural technologist", "checked": false},
  {"name": "Archivist", "checked": false},
  {"name": "Armed forces officer", "checked": false},
  {"name": "Aromatherapistr", "checked": false},
  {"name": "Art therapist", "checked": false},
  {"name": "Arts administrator", "checked": false},
  {"name": "Auditor", "checked": false},
  {"name": "Automotive engineer", "checked": false},
  {"name": "Barrister", "checked": false},
  {"name": "Barrister’s clerk", "checked": false},
  {"name": "Bilingual secretary", "checked": false},
  {"name": "Biomedical engineer", "checked": false},
  {"name": "Biomedical scientist", "checked": false},
  {"name": "Biotechnologist", "checked": false},
  {"name": "Brand manager", "checked": false},
  {"name": "Broadcasting presenter", "checked": false},
  {"name": "Building control officer/surveyor", "checked": false},
  {"name": "Building services engineer", "checked": false},
  {"name": "Building surveyor", "checked": false},
  {"name": "Camera operator", "checked": false},
  {"name": "Careers adviser (higher education)", "checked": false},
  {"name": "Careers consultant", "checked": false},
  {"name": "Careers adviser", "checked": false},
  {"name": "Careers consultant", "checked": false},
  {"name": "Cartographer", "checked": false},
  {"name": "Catering manager", "checked": false},
  {"name": "Charities administrator", "checked": false},
  {"name": "Catering manager", "checked": false},
  {"name": "Charities administrator", "checked": false},
  {"name": "Charities fundraiser", "checked": false},
  {"name": "Chemical (process) engineer", "checked": false},
  {"name": "Child psychotherapist", "checked": false},
  {"name": "Children's nurse", "checked": false},
  {"name": "Chiropractor", "checked": false},
  {"name": "Civil engineer", "checked": false},
  {"name": "Civil Service administrator", "checked": false},
  {"name": "Clinical biochemist", "checked": false},
  {"name": "Clinical cytogeneticist", "checked": false},
  {"name": "Clinical microbiologist", "checked": false},
  {"name": "Clinical molecular geneticist", "checked": false},
  {"name": "Clinical research associate", "checked": false},
  {"name": "Clinical scientist - tissue typing", "checked": false},
  {"name": "Clothing and textile technologist", "checked": false},
  {"name": "Colour technologist", "checked": false},
  {"name": "Commercial horticulturist", "checked": false},
  {"name": "Commercial/residential/rural surveyor", "checked": false},
  {"name": "Commissioning editor", "checked": false},
  {"name": "Commissioning engineer", "checked": false},
  {"name": "Commodity broker", "checked": false},
  {"name": "Communications engineer", "checked": false},
  {"name": "Community arts worker", "checked": false},
  {"name": "Community education officer", "checked": false},
  {"name": "Community worker", "checked": false},
  {"name": "Company secretary", "checked": false},
  {"name": "Computer sales support", "checked": false},
  {"name": "Computer scientist", "checked": false},
  {"name": "Conference organiser", "checked": false},
  {"name": "Consultant", "checked": false},
  {"name": "Consumer rights adviser", "checked": false},
  {"name": "Control and instrumentation engineer", "checked": false},
  {"name": "Corporate banker", "checked": false},
  {"name": "Corporate treasurer", "checked": false},
  {"name": "Counsellor", "checked": false},
  {"name": "Courier/tour guide", "checked": false},
  {"name": "Court reporter/verbatim reporter", "checked": false},
  {"name": "Credit analyst", "checked": false},
  {"name": "Crown Prosecution Service lawyer", "checked": false},
  {"name": "Crystallographer", "checked": false},
  {"name": "Curator", "checked": false},
  {"name": "Customs officer", "checked": false},
  {"name": "Cyber security specialist", "checked": false},
  {"name": "Dance movement therapist", "checked": false},
  {"name": "Data analyst", "checked": false},
  {"name": "Data scientist", "checked": false},
  {"name": "Data visualisation analyst", "checked": false},
  {"name": "Database administrator", "checked": false},
  {"name": "Debt/finance adviser", "checked": false},
  {"name": "Dental hygienist", "checked": false},
  {"name": "Dentist", "checked": false},
  {"name": "Dentist", "checked": false},
  {"name": "Design engineer", "checked": false},
  {"name": "Dietitian", "checked": false},
  {"name": "Diplomatic service", "checked": false},
  {"name": "Doctor (hospital)", "checked": false},
  {"name": "Dramatherapist", "checked": false},
  {"name": "Economist", "checked": false},
  {"name": "Editorial assistant", "checked": false},
  {"name": "Education administrator", "checked": false},
  {"name": "Electrical engineer", "checked": false},
  {"name": "Employment advice worker", "checked": false},
  {"name": "Energy conservation officer", "checked": false},
  {"name": "Engineering geologist", "checked": false},
  {"name": "Environmental education officer", "checked": false},
  {"name": "Environmental health officer", "checked": false},
  {"name": "Environmental scientist", "checked": false},
  {"name": "Environmental scientist", "checked": false},
  {"name": "Equal opportunities officer", "checked": false},
  {"name": "Equality and diversity officer", "checked": false},
  {"name": "Ergonomist", "checked": false},
  {"name": "Estate agent", "checked": false},
  {"name": "European Commission administrators", "checked": false},
  {"name": "Exhibition display designer", "checked": false},
  {"name": "Exhibition organiser", "checked": false},
  {"name": "Exploration geologist", "checked": false},
  {"name": "Facilities manager", "checked": false},
  {"name": "Field trials officer", "checked": false},
  {"name": "Financial manager", "checked": false},
  {"name": "Firefighter", "checked": false},
  {"name": "Fisheries officer", "checked": false},
  {"name": "Fitness centre manager", "checked": false},
  {"name": "Food scientist", "checked": false},
  {"name": "Food technologist", "checked": false},
  {"name": "Forensic scientist", "checked": false},
  {"name": "Geneticist", "checked": false},
  {"name": "Geographical information systems manager", "checked": false},
  {"name": "Geomatics/land surveyor", "checked": false},
  {"name": "Government lawyer", "checked": false},
  {"name": "Government research officer", "checked": false},
  {"name": "Graphic designer", "checked": false},
  {"name": "Health and safety adviser", "checked": false},
  {"name": "Health and safety inspector", "checked": false},
  {"name": "Health promotion specialist", "checked": false},
  {"name": "Health service manager", "checked": false},
  {"name": "Health visitor", "checked": false},
  {"name": "Herbalist", "checked": false},
  {"name": "Heritage manager", "checked": false},
  {"name": "Higher education administrator", "checked": false},
  {"name": "Higher education advice worker", "checked": false},
  {"name": "Homeless worker", "checked": false},
  {"name": "Horticultural consultant", "checked": false},
  {"name": "Hotel manager", "checked": false},
  {"name": "Housing adviser", "checked": false},
  {"name": "Human resources officer", "checked": false},
  {"name": "Hydrologist", "checked": false},
  {"name": "Illustrator", "checked": false},
  {"name": "Immigration officer", "checked": false},
  {"name": "Immunologist", "checked": false},
  {"name": "Industrial/product designer", "checked": false},
  {"name": "Information scientist", "checked": false},
  {"name": "Information systems manager", "checked": false},
  {"name": "Information technology/software trainers", "checked": false},
  {"name": "Insurance broker", "checked": false},
  {"name": "Insurance claims inspector", "checked": false},
  {"name": "Insurance risk surveyor", "checked": false},
  {"name": "Insurance underwriter", "checked": false},
  {"name": "Interpreter", "checked": false},
  {"name": "Investment analyst", "checked": false},
  {"name": "Investment banker - corporate finance", "checked": false},
  {"name": "Investment banker – operations", "checked": false},
  {"name": "Investment fund manager", "checked": false},
  {"name": "IT consultant", "checked": false},
  {"name": "IT support analyst", "checked": false},
  {"name": "Journalist", "checked": false},
  {"name": "Laboratory technician", "checked": false},
  {"name": "Land-based engineer", "checked": false},
  {"name": "Landscape architect", "checked": false},
  {"name": "Learning disability nurse", "checked": false},
  {"name": "Learning mentor", "checked": false},
  {"name": "Lecturer (adult education)", "checked": false},
  {"name": "Lecturer (further education)", "checked": false},
  {"name": "Lecturer (higher education)", "checked": false},
  {"name": "Legal executive", "checked": false},
  {"name": "Leisure centre manager", "checked": false},
  {"name": "Licensed conveyancer", "checked": false},
  {"name": "Local government administrator", "checked": false},
  {"name": "Local government lawyer", "checked": false},
  {"name": "Logistics/distribution manager", "checked": false},
  {"name": "Magazine features editor", "checked": false},
  {"name": "Magazine journalist", "checked": false},
  {"name": "Maintenance engineer", "checked": false},
  {"name": "Management accountant", "checked": false},
  {"name": "Manufacturing engineer", "checked": false},
  {"name": "Manufacturing machine operator", "checked": false},
  {"name": "Manufacturing toolmaker", "checked": false},
  {"name": "Marine scientist", "checked": false},
  {"name": "Market research executive", "checked": false},
  {"name": "Marketing account manager", "checked": false},
  {"name": "Marketing assistant", "checked": false},
  {"name": "Marketing executive", "checked": false},
  {"name": "Marketing manager (social media)", "checked": false},
  {"name": "Materials engineer", "checked": false},
  {"name": "Materials specialist", "checked": false},
  {"name": "Mechanical engineer", "checked": false},
  {"name": "Media analyst", "checked": false},
  {"name": "Medical physicist", "checked": false},
  {"name": "Medical representative", "checked": false},
  {"name": "Metallurgist", "checked": false},
  {"name": "Meteorologist", "checked": false},
  {"name": "Microbiologist", "checked": false},
  {"name": "Midwife", "checked": false},
  {"name": "Mining engineer", "checked": false},
  {"name": "Mobile developer", "checked": false},
  {"name": "Multimedia programmer", "checked": false},
  {"name": "Multimedia specialists", "checked": false},
  {"name": "Museum education officer", "checked": false},
  {"name": "Museum/gallery exhibition officer", "checked": false},
  {"name": "Music therapist", "checked": false},
  {"name": "Nanoscientist", "checked": false},
  {"name": "Nature conservation officer", "checked": false},
  {"name": "Naval architect", "checked": false},
  {"name": "Network administrator", "checked": false},
  {"name": "Nutritional therapist", "checked": false},
  {"name": "Nutritionist", "checked": false},
  {"name": "Occupational therapist", "checked": false},
  {"name": "Oceanographer", "checked": false},
  {"name": "Office manager", "checked": false},
  {"name": "Operational researcher", "checked": false},
  {"name": "Orthoptist", "checked": false},
  {"name": "Outdoor pursuits manager", "checked": false},
  {"name": "Packaging technologist", "checked": false},
  {"name": "Paramedic", "checked": false},
  {"name": "Patent attorney", "checked": false},
  {"name": "Patent examiner", "checked": false},
  {"name": "Pension scheme manager", "checked": false},
  {"name": "Personal assistant", "checked": false},
  {"name": "Petroleum engineer", "checked": false},
  {"name": "Pharmacist", "checked": false},
  {"name": "Pharmacologist", "checked": false},
  {"name": "Pharmacovigilance officer", "checked": false},
  {"name": "Photographer", "checked": false},
  {"name": "Physiotherapist", "checked": false},
  {"name": "Picture researcher", "checked": false},
  {"name": "Planning and development surveyor", "checked": false},
  {"name": "Planning technician", "checked": false},
  {"name": "Plant breeder", "checked": false},
  {"name": "Police officer", "checked": false},
  {"name": "Political party agent", "checked": false},
  {"name": "Political party research officer", "checked": false},
  {"name": "Practice nurse", "checked": false},
  {"name": "Press photographer", "checked": false},
  {"name": "Press sub-editor", "checked": false},
  {"name": "Prison officer", "checked": false},
  {"name": "Private music teacher", "checked": false},
  {"name": "Probation officer", "checked": false},
  {"name": "Product development scientist", "checked": false},
  {"name": "Production manager", "checked": false},
  {"name": "Programme researcher", "checked": false},
  {"name": "Project manager", "checked": false},
  {"name": "Psychologist (clinical)", "checked": false},
  {"name": "Psychologist (educational)", "checked": false},
  {"name": "Psychotherapist", "checked": false},
  {"name": "Public affairs consultant (lobbyist)", "checked": false},
  {"name": "Public affairs consultant (research)", "checked": false},
  {"name": "Public house manager", "checked": false},
  {"name": "Public librarian", "checked": false},
  {"name": "Public relations (PR) officer", "checked": false},
  {"name": "QA analyst", "checked": false},
  {"name": "Quality assurance manager", "checked": false},
  {"name": "Quantity surveyor", "checked": false},
  {"name": "Records manager", "checked": false},
  {"name": "Recruitment consultant", "checked": false},
  {"name": "Recycling officer", "checked": false},
  {"name": "Regulatory affairs officer", "checked": false},
  {"name": "Research chemist", "checked": false},
  {"name": "Research scientist", "checked": false},
  {"name": "Restaurant manager", "checked": false},
  {"name": "Retail banker", "checked": false},
  {"name": "Retail buyer", "checked": false},
  {"name": "Retail manager", "checked": false},
  {"name": "Retail merchandiser", "checked": false},
  {"name": "Retail pharmacist", "checked": false},
  {"name": "Sales executive", "checked": false},
  {"name": "Sales manager", "checked": false},
  {"name": "Scene of crime officer", "checked": false},
  {"name": "Secretary", "checked": false},
  {"name": "Seismic interpreter", "checked": false},
  {"name": "Site engineer", "checked": false},
  {"name": "Site manager", "checked": false},
  {"name": "Social researcher", "checked": false},
  {"name": "Social worker", "checked": false},
  {"name": "Software developer", "checked": false},
  {"name": "Soil scientist", "checked": false},
  {"name": "Solicitor", "checked": false},
  {"name": "Speech and language therapist", "checked": false},
  {"name": "Sports coach", "checked": false},
  {"name": "Sports development officer", "checked": false},
  {"name": "Sports therapist", "checked": false},
  {"name": "Statistician", "checked": false},
  {"name": "Stockbroker", "checked": false},
  {"name": "Structural engineer", "checked": false},
  {"name": "Systems analyst", "checked": false},
  {"name": "Systems developer", "checked": false},
  {"name": "Tax inspector", "checked": false},
  {"name": "Teacher (nursery/early years)", "checked": false},
  {"name": "Teacher (primary)", "checked": false},
  {"name": "Teacher (secondary)", "checked": false},
  {"name": "Teacher (special educational needs)", "checked": false},
  {"name": "Teaching/classroom assistant", "checked": false},
  {"name": "Technical author", "checked": false},
  {"name": "Technical sales engineer", "checked": false},
  {"name": "TEFL/TESL teacher", "checked": false},
  {"name": "Television production assistant", "checked": false},
  {"name": "Test automation developer", "checked": false},
  {"name": "Tour operator", "checked": false},
  {"name": "Tourism officer", "checked": false},
  {"name": "Tourist information manager", "checked": false},
  {"name": "Town and country planner", "checked": false},
  {"name": "Toxicologist", "checked": false},
  {"name": "Trade union research officer", "checked": false},
  {"name": "Trader", "checked": false},
  {"name": "Trading standards officer", "checked": false},
  {"name": "Training and development officer", "checked": false},
  {"name": "Translator", "checked": false},
  {"name": "Transportation planner", "checked": false},
  {"name": "Transportation planner", "checked": false},
  {"name": "Travel agent", "checked": false},
  {"name": "TV/film/theatre set designer", "checked": false},
  {"name": "UX designer", "checked": false},
  {"name": "Validation engineer", "checked": false},
  {"name": "Veterinary surgeon", "checked": false},
  {"name": "Video game designer", "checked": false},
  {"name": "Video game developer", "checked": false},
  {"name": "Volunteer work organiser", "checked": false},
  {"name": "Warehouse manager", "checked": false},
  {"name": "Waste disposal officer", "checked": false},
  {"name": "Water conservation officer", "checked": false},
  {"name": "Water engineer", "checked": false},
  {"name": "Web designer", "checked": false},
  {"name": "Web developer", "checked": false},
  {"name": "Welfare rights adviser", "checked": false},
  {"name": "Writer", "checked": false},
  {"name": "Youth worker", "checked": false},
];
