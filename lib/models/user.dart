// User model this is the data structure of a user in the application
class User {
  String First_name;
  String Last_name;
  String Location;
  String Password;
  String Pet;              //Here are the attributes assigned to the user model
  double Pet_picture;      //Pet_pictue and Profile_picture are being considered
  String Phone_number;     //to change to string. Are kept as a double as that
  double Profile_picture;  //would be like a url or identifier number in 
  String email;            //supabase


  // init all fields
  User({      
    required this.First_name,
    required this.Last_name,
    required this.Location,
    required this.Password,
    required this.Pet,
    required this.Pet_picture,
    required this.Phone_number,
    required this.Profile_picture,
    required this.email,
  });

  User.fromJson(Map<String, Object?> json)
      : this(
          First_name: json['First_name']! as String,
          Last_name: json['Last_name']! as String,
          Location: json['Location']! as String,
          Password: json['Password']! as String,
          Pet: json['Pet']! as String,
          Pet_picture: json['Pet_picture']! as double,
          Phone_number: json['Phone_number']! as String,
          Profile_picture: json['Profile_picture']! as double,
          email: json['email']! as String,
        );


  //Method creates copies of current user object with other possible updates
  User copyWith({
    String? First_name,
    String? Last_name,
    String? Location,
    String? Password,
    String? Pet,
    double? Pet_picture,
    String? Phone_number,
    double? Profile_picture,
    String? email,
  }) {
    return User(
        First_name: First_name ?? this.First_name,
        Last_name: Last_name ?? this.Last_name,
        Location: Location ?? this.Location,
        Password: Password ?? this.Password,
        Pet: Pet ?? this.Pet,
        Pet_picture: Pet_picture ?? this.Pet_picture,
        Phone_number: Phone_number ?? this.Phone_number,
        Profile_picture: Profile_picture ?? this.Profile_picture,
        email: email ?? this.email);
  }

  // Converts User object to JSON format for storing in database
  Map<String, Object?> toJson() {
    return {
      'First_name': First_name,
      'Last_name': Last_name,
      'Location': Location,
      'Password': Password,
      'Pet': Pet,
      'Pet_picture': Pet_picture,
      'Phone_number': Phone_number,
      'Profile_picture': Profile_picture,
      'email': email,
    };
  }
}
