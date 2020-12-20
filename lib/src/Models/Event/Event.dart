import 'package:flutter_login_signup/src/Models/Event/EventImage.dart';


class Event {
  int id;
  String title;
  String thumbnail;
  String date;
  String description;
  String isLiked;

  List<EventImages> eventImages;

  Event(
      {this.id,
        this.title,
        this.thumbnail,
        this.date,
        this.description,
        this.isLiked,

        this.eventImages
      });

  Event.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    date = json['date'];
    description = json['description'];
    isLiked =  json['isLiked'];

    if (json['event_images'] != null) {
      eventImages = new List<EventImages>();
      json['event_images'].forEach((v) {
        eventImages.add(new EventImages.fromJson(v));
      });
    }

  }


  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['thumbnail'] = this.thumbnail;
    data['date'] = this.date;
    data['description'] = this.description;
    data['isLiked'] = this.isLiked;

    if (this.eventImages != null) {
      data['event_images'] = this.eventImages.map((v) => v.toJson()).toList();
    }
    return data;
  }
}




