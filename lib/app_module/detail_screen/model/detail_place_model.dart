class DetailAboutPlace {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  String? formattedAddress;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? name;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
  double? rating;
  String? reference;
  List<Reviews>? reviews;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  bool? wheelchairAccessibleEntrance;

  DetailAboutPlace({
    this.addressComponents,
    this.adrAddress,
    this.businessStatus,
    this.formattedAddress,
    this.geometry,
    this.icon,
    this.iconBackgroundColor,
    this.iconMaskBaseUri,
    this.name,
    this.photos,
    this.placeId,
    this.plusCode,
    this.rating,
    this.reference,
    this.reviews,
    this.types,
    this.url,
    this.userRatingsTotal,
    this.utcOffset,
    this.vicinity,
    this.wheelchairAccessibleEntrance,
  });

  DetailAboutPlace.fromJson(Map<String, dynamic> json) {
    print("nnnnnnnnnnnnnnnnnnnnnnnnnn ${json["name"]}");
    try {
      if (json['address_components'] != null) {
        addressComponents = (json['address_components'] as List)
            .map((v) => AddressComponents.fromJson(v))
            .toList();
      }
      adrAddress = json['adr_address'];
      businessStatus = json['business_status'];
      formattedAddress = json['formatted_address'];
      geometry =
          json['geometry'] != null ? Geometry.fromJson(json['geometry']) : null;
      icon = json['icon'];
      iconBackgroundColor = json['icon_background_color'];
      iconMaskBaseUri = json['icon_mask_base_uri'];
      name = json['name'];
      if (json['photos'] != null) {
        photos =
            (json['photos'] as List).map((v) => Photos.fromJson(v)).toList();
      }
      placeId = json['place_id'];
      plusCode = json['plus_code'] != null
          ? PlusCode.fromJson(json['plus_code'])
          : null;
      rating = json['rating']?.toDouble();
      reference = json['reference'];
      if (json['reviews'] != null) {
        reviews =
            (json['reviews'] as List).map((v) => Reviews.fromJson(v)).toList();
      }
      types = json['types']?.cast<String>();
      url = json['url'];
      userRatingsTotal = json['user_ratings_total'];
      utcOffset = json['utc_offset'];
      vicinity = json['vicinity'];
      wheelchairAccessibleEntrance = json['wheelchair_accessible_entrance'];
    } catch (e) {
      print('Error parsing DetailAboutPlace: $e');
    }
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    try {
      longName = json['long_name'];
      shortName = json['short_name'];
      types = json['types']?.cast<String>();
    } catch (e) {
      print('Error parsing AddressComponents: $e');
    }
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    try {
      location =
          json['location'] != null ? Location.fromJson(json['location']) : null;
      viewport =
          json['viewport'] != null ? Viewport.fromJson(json['viewport']) : null;
    } catch (e) {
      print('Error parsing Geometry: $e');
    }
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    try {
      lat = json['lat']?.toDouble();
      lng = json['lng']?.toDouble();
    } catch (e) {
      print('Error parsing Location: $e');
    }
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    try {
      northeast = json['northeast'] != null
          ? Location.fromJson(json['northeast'])
          : null;
      southwest = json['southwest'] != null
          ? Location.fromJson(json['southwest'])
          : null;
    } catch (e) {
      print('Error parsing Viewport: $e');
    }
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    try {
      height = json['height'];
      htmlAttributions = json['html_attributions']?.cast<String>();
      photoReference = json['photo_reference'];
      width = json['width'];
    } catch (e) {
      print('Error parsing Photos: $e');
    }
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    try {
      compoundCode = json['compound_code'];
      globalCode = json['global_code'];
    } catch (e) {
      print('Error parsing PlusCode: $e');
    }
  }
}

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  int? rating;
  String? relativeTimeDescription;
  String? text;
  int? time;
  bool? translated;

  Reviews(
      {this.authorName,
      this.authorUrl,
      this.language,
      this.originalLanguage,
      this.profilePhotoUrl,
      this.rating,
      this.relativeTimeDescription,
      this.text,
      this.time,
      this.translated});

  Reviews.fromJson(Map<String, dynamic> json) {
    try {
      authorName = json['author_name'];
      authorUrl = json['author_url'];
      language = json['language'];
      originalLanguage = json['original_language'];
      profilePhotoUrl = json['profile_photo_url'];
      rating = json['rating'];
      relativeTimeDescription = json['relative_time_description'];
      text = json['text'];
      time = json['time'];
      translated = json['translated'];
    } catch (e) {
      print('Error parsing Reviews: $e');
    }
  }
}
