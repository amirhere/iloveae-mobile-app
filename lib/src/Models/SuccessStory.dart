

import 'package:flutter/material.dart';

 class SuccessStory {
    final String title;
    final String description;
    final String thumbnail;

    final List<NetworkImage> networkImagesList;


    SuccessStory({this.title, this.description, this.thumbnail, this.networkImagesList});

    factory SuccessStory.fromJson(Map<String, dynamic> json) {
        return SuccessStory(
            title: json['title'],
            description: json['description'],
            thumbnail: json['thumbnail'],
            networkImagesList: json['success_story_images'],

        );
    }
}
