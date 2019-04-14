import 'package:flutter/material.dart';
import 'Simple.dart';

class PlayerManager
{
    Map<String, String> _player = {
        "1234567": "Patrick",
        "abdcdef": "Daniel",
        "asdfaff": "Ole",
        "adfafas": "Pascal",
        "adsfdee": "Thomas",
        "aaaaaaa": "Jörg"
    };

    Map<String, String> get player => _player;

    String id2Player(String id)
    {
        return _player[ id ];
    }
}