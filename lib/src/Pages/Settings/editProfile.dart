import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_login_signup/src/Pages/Auth/loginPage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dropdownfield/dropdownfield.dart';

import 'package:autocomplete_textfield/autocomplete_textfield.dart';


import 'package:toast/toast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_login_signup/src/Utils/Helper.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:math';
import 'dart:convert';
import 'dart:async';

import 'package:flutter_login_signup/src/Pages/homePage.dart';



import 'package:image_cropper/image_cropper.dart';


class EditProfilePage extends StatefulWidget {
  EditProfilePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool isProgressBarVisible = false;
  SharedPreferences prefs;
  String userId;

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

  var suggestionsList = [
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

  List<Color> _occupationColors = [Color(0xFF573555), Colors.yellow];
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
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500))
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

  Widget getPasswordTextFieldWidget() {
      return new TextField(
          onTap: () {
              setState(() {
                  passwordTextEditingController.text = "";
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
                  borderSide: BorderSide(color: passwordColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: passwordColor)),
          ));
  }

  Widget getConfirmPasswordTextFieldWidget() {
      return new TextField(
          onTap: () {
              setState(() {
                  confirmPasswordColor = _confirmPasswordColors[0];
                  confirmPasswordTextEditingController.text = "";
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
                  borderSide: BorderSide(color: passwordColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: passwordColor)),
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
              enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: nameColor)),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: nameColor)),
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
                      borderSide: BorderSide(color: Color(0xFF573555))),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF573555))),
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
                      borderSide: BorderSide(color: motherNameColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: motherNameColor)),
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
                      borderSide: BorderSide(color: familyNameColor)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: familyNameColor)),
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
              enabledBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: emailColor)),
              focusedBorder:
              UnderlineInputBorder(borderSide: BorderSide(color: emailColor)),
          ));
  }

  Widget getTelephoneTextFieldWidget() {
      return new Stack(
          children: <Widget>[
              Container(
                  //    color: Colors.yellow,
                  width: 56,
                  //padding: EdgeInsets.only(left: 44.0),
                  margin: EdgeInsets.only(
                      left: 50.0,
                  ),
                  child: DropdownButton(
                      onTap: (){
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
              Container(
                  // color: Colors.green,
                  width: 400,
                  height: 40,
                  margin: EdgeInsets.only(top: 0.0, left: 100.0),
                  padding: EdgeInsets.only(left: 5.0),
                  child: TextField(
                      onTap: (){
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
                          //  labelText: 'Telephone',
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: telephoneColor,
                              fontWeight: FontWeight.w600),

                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: telephoneColor)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: telephoneColor)),
                      ))),
              Container(
                  //  color: Colors.purple,
                  margin: EdgeInsets.only(top: 0.0, left: 0.0),
                  child: IconButton(
                      icon: new Image.asset(
                          'assets/telephone_icon.png',
                          width: 25.0,
                          height: 25.0,
                      ),
                      onPressed: null,
                  ),
              ),
          ],
      );
  }


  Widget getMobileTextFieldWidget() {
      return new Stack(
          children: <Widget>[
              Container(
                  //    color: Colors.yellow,
                  width: 56,
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
                  margin: EdgeInsets.only(top: 0.0, left: 100.0),
                  padding: EdgeInsets.only(left: 5.0),
                  child: TextField(
                      onTap: (){
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
  }


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
                          borderSide: BorderSide(color: dobColor)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: dobColor)),
                  ))),
      );
  }

  Widget getGenderTextFieldWidget() {
      //double width = MediaQuery.of(context).size.width;

      return new Stack(
          children: <Widget>[
              Container(
                  //    color:Colors.red,
                  width: 88,
                  //  color: Colors.red,
                  padding: EdgeInsets.only(left: 0.0),
                  margin: EdgeInsets.only(
                      left: 44.0,
                  ),
                  child: DropdownButtonHideUnderline(

                      child: DropdownButton(
                          onTap: (){
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                          ),
                          isExpanded: true,
                          iconSize: 25.0,
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
                  width: 50,
                  //  color: Colors.purple,
                  margin: EdgeInsets.only(top: 0.0, left: 0.0),
                  child: IconButton(
                      icon: new Image.asset(
                          'assets/gender_icon.png',
                          width: 25.0,
                          height: 25.0,
                      ),
                      onPressed: null,
                  ),
              ),
              Container(
                  //  color:Colors.green,
                  width: 110,
                  //  color: Colors.blue,
                  padding: EdgeInsets.only(left: 0.0),
                  margin: EdgeInsets.only(
                      left: 165.0,
                  ),
                  child: DropdownButtonHideUnderline(
                      child: DropdownButton(
                          onTap: (){
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
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold),
                          ),
                          isExpanded: true,
                          iconSize: 30.0,
                          style: TextStyle(
                              color: Color(0xFF573555),
                              fontSize: 13,
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
                  //     color: Colors.orange,
                  margin: EdgeInsets.only(top: 0.0, left: 130.0),
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

  Widget getBloodTypeTextFieldWidget() {
      return new Stack(
          children: <Widget>[
              Container(
                  color: Colors.brown,
                  padding: EdgeInsets.only(left: 44.0),
                  margin: EdgeInsets.only(
                      left: 5.0,
                  ),
                  child: DropdownButtonHideUnderline(child: DropdownButton(
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
                  )),
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




  Widget getOccupationTextFieldWidget() {
      return AutoCompleteTextField(
          textCapitalization: TextCapitalization.sentences,
          controller: occupationTextEditingController,
          keyboardType: TextInputType.text,
          style: TextStyle(
              color: Theme.of(context).primaryColor, fontWeight: FontWeight.bold, fontSize: 13),
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

                  borderSide: BorderSide(color: occupationColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: occupationColor))),
          clearOnSubmit: false,
          suggestions: suggestionsList,
          itemFilter: (item, query) {
              return item.toString().toLowerCase().startsWith(query.toLowerCase());
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
                enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: countryColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: countryColor),),),
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
                enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: cityColor)),
                focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: cityColor)),
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
                enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: streetColor)),
                focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: streetColor)),
            ));
    }

    Widget getStateTextFieldWidget() {
        return new TextField(
            controller: streetTextEditingController,
            keyboardType: TextInputType.text,
            textCapitalization: TextCapitalization.sentences,
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
        cursorColor: Color(0xFF573555),
        decoration: InputDecoration(
          labelText: 'Zip',
          labelStyle: TextStyle(color: Color(0xFF573555)),
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

              getGenderTextFieldWidget(),
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
                height: 10,
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


          if (nameTextEditingController.text.length == 0)
              nameColor = _nameColors[1];

          if (fatherNameTextEditingController.text.length == 0)
              fatherNameColor = _fatherNameColors[1];

          if (motherNameTextEditingController.text.length == 0)
              motherNameColor = _motherNameColors[1];

          if (familyNameTextEditingController.text.length == 0)
              familyNameColor = _familyNameColors[1];

          if (dobTextEditingController.text.length == 0) dobColor = _dobColors[1];

          if (occupationTextEditingController.text.length == 0)
              occupationColor = _occupationColors[1];

          if (occupationTextEditingController.text == "Occupation *")
              occupationColor = _occupationColors[1];

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
                                          if (occupationTextEditingController.text.length > 0) {
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
                                                                                  updateUserRecord(userId);
                                                                              } else {
                                                                                  Toast.show("Passwords do not match",
                                                                                      context,
                                                                                      duration: Toast.LENGTH_LONG,
                                                                                      gravity: Toast.BOTTOM);
                                                                              }
                                                                          } else {
                                                                              Toast.show(
                                                                                  "Password should be atleast  8 charaacters",
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
            text: 'UPDATE',
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

  next() {
    /*if (currentStep + 1 != steps.length) {
      //steps[currentStep]

      if (currentStep == 0) {
        if (passwordTextEditingController.text.length >= 8) {
          if (passwordTextEditingController.text ==
              confirmPasswordTextEditingController.text) {
            goTo(currentStep + 1);
          } else {
            Toast.show('Passwords do not match', context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show('Passord should be atleast 8 characters', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      } else if (currentStep == 1) {
        if (nameTextEditingController.text.length >= 4) {
          if (familyNameTextEditingController.text.length >= 4) {
            if (RegExp(
                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(emailTextEditingController.text)) {
              goTo(currentStep + 1);
            } else {
              Toast.show('Invalid Email Address', context,
                  duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
            }
          } else {
            Toast.show('Family Name should be atleast 4 characters', context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show('Name should be atleast 4 characters', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      } else if (currentStep == 2) {
        if (gender.length > 0) {
          // goTo(currentStep + 1);
          if (selectBloodType.length > 0) {
            goTo(currentStep + 1);
          } else {
            Toast.show('Blood Type is Required', context,
                duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
          }
        } else {
          Toast.show('Gender is Required', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        }
      } else if (currentStep == 3) {
        goTo(currentStep + 1);
      }
    } else {
      setState(() => complete = true);

      if (_image != null) {
        saveInfoRequest();
      } else {
        Toast.show('Please upload image', context,
            duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      }
      (_image != null)
          ? saveInfoRequest()
          : Toast.show('Please upload image', context,
              duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }*/

    /* currentStep + 1 != steps.length
            ? goTo(currentStep + 1)
            : setState(() => complete = true); */
  }

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


    getSavedValuesFromSharedPreference();
  }



urlToFile(String imageUrl) async {

    var rng = new Random();
    Directory tempDir = await getTemporaryDirectory();
    String tempPath = tempDir.path;
    File file = new File('$tempPath' + (rng.nextInt(100)).toString() + '.png');
    http.Response response = await http.get(imageUrl);
    await file.writeAsBytes(response.bodyBytes);

    setState((){
        _image = file;
    });
  }



  void getSavedValuesFromSharedPreference() async {
    prefs = await SharedPreferences.getInstance();

    setState(() {
        urlToFile(prefs.getString("photo_url"));
      userId = prefs.getString("user_id");
      nameTextEditingController.text = prefs.getString("name");
      nickNameTextEditingController.text = prefs.getString("nick_name");
      familyNameTextEditingController.text = prefs.getString("family_name");
      fatherNameTextEditingController.text = prefs.getString("father_name");
      motherNameTextEditingController.text = prefs.getString("mother_name");
      dobTextEditingController.text = prefs.getString("dob");
      _genderDropDownValue = prefs.getString("gender");
      _bloodTypeDropDownValue = prefs.getString("blood_type");
      occupationTextEditingController.text = prefs.getString("occupation");



      _maritalStatusDropDownValue = prefs.getString("marital_status");
     // _countryDropDownValue = prefs.getString("marital_status");
      cityTextEditingController.text = prefs.getString("city");
      streetTextEditingController.text = prefs.getString("street");

      _mobileCountryCodeDropDownValue = prefs.getString("mobile_country_code");
      mobileTextEditingController.text = prefs.getString("mobile");
      _phoneCountryCodeDropDownValue = prefs.getString("phone_country_code");
      telephoneTextEditingController.text = prefs.getString("phone");
      passwordTextEditingController.text = "********";
      confirmPasswordTextEditingController.text = "********";
      linkedInUrlTextEditingController.text = prefs.getString("linkedin");

      emailTextEditingController.text = prefs.getString("email");
      countryTextEditingController.text = prefs.getString("country");


    });


  }



  /*   Image Picker Snippet  */

  File _image;

  _imgFromCamera() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.camera, imageQuality: 50);

    if (image != null) {
        _cropImage(image);
    }

  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
        _cropImage(image);
    }
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
    getUserProfilePicture(String requestId) async{
        final http.Response response = await http.post(
            Helper.photo_url+requestId,
            headers: <String, String>{
                'Content-Type': 'application/json; charset=UTF-8',
                'Authorization': Helper.access_token
            },
            body: jsonEncode(<String, String>{
                //'email': userNameTextEditingController.text,
                //'password': passwordTextEditingController.text
            }),
        );



        print(response.body);
        Map data = json.decode(response.body);
        String resp = data['photo_url'];
        return resp;
    }

  void updateUserRecord(String requestId) async {
    setState(() {
      isProgressBarVisible = true;
    });

    var request = http.MultipartRequest(
        "POST",
        //  Uri.parse("http://pitstopsystems.com/iloveae/api/public/register"));
        Uri.parse(Helper.update+"/"+requestId));

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
    request.fields["occupation"] = occupationTextEditingController.text;
    request.fields["second_occupation"] = _secondOccupationDropDownValue;
    request.fields["marital_status"] = _maritalStatusDropDownValue;
    request.fields["country"] = countryTextEditingController.text;
    request.fields["city"] = cityTextEditingController.text;
    request.fields["street"] = streetTextEditingController.text;
    request.fields["mobile_country_code"] = _mobileCountryCodeDropDownValue;
    request.fields["mobile"] = mobileTextEditingController.text;
    request.fields["phone_country_code"] = _phoneCountryCodeDropDownValue;
    request.fields["phone"] = telephoneTextEditingController.text;

    if(passwordTextEditingController.text != '********')
     request.fields["password"] = passwordTextEditingController.text;
    //request.fields["password_confirm"] =
    //  confirmPasswordTextEditingController.text;
    request.fields["linkedin_url"] = linkedInUrlTextEditingController.text;

    //create multipart using filepath, string or bytes
    var pic = await http.MultipartFile.fromPath("photo_url", _image.path);
    //add multipart to request
    request.files.add(pic);

    //   ONE WAY TO SEND AND RECEIVE RESPONSE
        /*var response2 = await request.send();
        var responseData = await response2.stream.toBytes();
        var responseString = String.fromCharCodes(responseData);*/


    /* SECOND WAY TO SEND AND RECEIVE RESPONSE */

    http.Response response =
        await http.Response.fromStream(await request.send());
    print("Result: ${response.statusCode}");






    if ("${response.statusCode}" == "200") {
      Toast.show("Account Updated successfully", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);


      final http.Response response = await http.post(
          Helper.photo_url+requestId,
          headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'Authorization': Helper.access_token
          },
          body: jsonEncode(<String, String>{
              //'email': userNameTextEditingController.text,
              //'password': passwordTextEditingController.text
          }),
      );



      print(response.body);
      Map data = json.decode(response.body);
      String resp = data['photo_url'];



      SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString('photo_url', resp);


          prefs.setString('name', nameTextEditingController.text);
         prefs.setString('nick_name', nickNameTextEditingController.text);
        prefs.setString('family_name', familyNameTextEditingController.text);
         prefs.setString('father_name', fatherNameTextEditingController.text);
         prefs.setString('mother_name', mobileTextEditingController.text);

         prefs.setString('dob', dobTextEditingController.text);
          prefs.setString('gender', _genderDropDownValue);
         prefs.setString('blood_type', _bloodTypeDropDownValue);
        prefs.setString('occupation', occupationTextEditingController.text);

          prefs.setString(
                 'marital_status', _maritalStatusDropDownValue);
        prefs.setString('country', _countryDropDownValue);
        prefs.setString('city', cityTextEditingController.text);
        prefs.setString('street', streetTextEditingController.text);

       prefs.setString('mobile_country_code',
            _mobileCountryCodeDropDownValue);
       prefs.setString('mobile', mobileTextEditingController.text);

       prefs.setString(
           'phone_country_code', _phoneCountryCodeDropDownValue);
       prefs.setString('phone', telephoneTextEditingController.text);

        prefs.setString('email', emailTextEditingController.text);
          prefs.setString('linkedin_url', linkedInUrlTextEditingController.text);

        //prefs.setString('photo_url', "${response.user.photo_url}");



      //      prefs.setBool('isUserLoggedIn', isRememberMeTextBoxChecked);


      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomePage()));




    } else {
      Toast.show("Email Already exists", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }

    setState(() {
      isProgressBarVisible = false;
    });
  }

  var showProgressBar = Visibility(
    child: Image(
        image: AssetImage('assets/progressBar.gif'), width: 50, height: 50),
    maintainSize: true,
    maintainAnimation: true,
    maintainState: true,
    visible: true,
  );



    Future<bool> _onBackPressed() {


        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => HomePage()));


            false;
    }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return WillPopScope(
    onWillPop: _onBackPressed,


        child: Scaffold(
            backgroundColor: Color(0xffc7dceb),
            bottomNavigationBar: new Container(
                height: 20.0,
                color: Color(0xFF573555),
            ),
            appBar: AppBar(
                backgroundColor: Theme.of(context).primaryColor,
                title: Padding(
                    padding: EdgeInsets.only(left: 50),
                    child: Text(
                        'Update Information',
                        style: TextStyle(
                            color: Color(0xFFFFFFFF),
                        ),
                    )),
                leading: IconButton(
                    icon: Icon(Icons.arrow_back_ios),
                    color: Color(0xFFFFFFFF),
                    onPressed: () =>   Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => HomePage())),
                ),
            ),
            body: Stack(
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
                                        borderRadius: BorderRadius.circular(70),
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
                                            borderRadius: BorderRadius.circular(70),
                                        ),
                                        width: 200,
                                        height: 200,
                                        child: Icon(
                                            Icons.camera_alt,
                                            color: Theme.of(context).primaryColor,
                                        ),
                                    ),
                                ),
                            ),
                        ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: height / 3.2),
                        child: SingleChildScrollView(
                            child: Container(
                                color: Color(0xFFdde9f2),
                                padding: EdgeInsets.all(20.0),
                                margin: EdgeInsets.symmetric(horizontal: 50),
                                child: Column(
                                    children: <Widget>[
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
                                        getGenderTextFieldWidget(),
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
                                            thickness: 0.2,
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
                                        SizedBox(
                                            height: 10,
                                        ),
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
                                    ],
                                ),
                            ),
                        ),
                    ),
                ],
            ),
        )
    );


  }
}
