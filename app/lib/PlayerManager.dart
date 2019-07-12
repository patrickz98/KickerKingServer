import 'package:flutter/material.dart';
import 'Simple.dart';

class PlayerManager
{
    Map<String, String> _player = {
        "1234567": "Patrick",
        "asdfaff": "Thorben",
        "adfafas": "Vlad",
        "adsfdee": "Sönke",
        "abdcdef": "Daniel",
    };

    Map<String, String> get player => _player;

    String id2Player(String id)
    {
        return _player[ id ];
    }
}