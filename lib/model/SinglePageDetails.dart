
class SinglePageDetails {
  Result? result;
  String? status;

  SinglePageDetails({this.result, this.status});

  SinglePageDetails.fromJson(Map<String, dynamic> json) {
    // if (json['html_attributions'] != null) {
    //   htmlAttributions = <Null>[];
    //   json['html_attributions'].forEach((v) {
    //     htmlAttributions!.add(new Null.fromJson(v));
    //   });
    // }
    result =
    json['result'] != null ? new Result.fromJson(json['result']) : null;
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.htmlAttributions != null) {
    //   data['html_attributions'] =
    //       this.htmlAttributions!.map((v) => v.toJson()).toList();
    // }
    if (this.result != null) {
      data['result'] = this.result!.toJson();
    }
    data['status'] = this.status;
    return data;
  }
}

class Result {
  List<AddressComponents>? addressComponents;
  String? adrAddress;
  String? businessStatus;
  bool? curbsidePickup;
  CurrentOpeningHours? currentOpeningHours;
  bool? delivery;
  bool? dineIn;
  EditorialSummary? editorialSummary;
  String? formattedAddress;
  String? formattedPhoneNumber;
  Geometry? geometry;
  String? icon;
  String? iconBackgroundColor;
  String? iconMaskBaseUri;
  String? internationalPhoneNumber;
  String? name;
  CurrentOpeningHours? openingHours;
  List<Photos>? photos;
  String? placeId;
  PlusCode? plusCode;
  int? priceLevel;
  dynamic rating;
  String? reference;
  bool? reservable;
  List<Reviews>? reviews;
  bool? servesBeer;
  bool? servesBreakfast;
  bool? servesBrunch;
  bool? servesDinner;
  bool? servesLunch;
  bool? servesVegetarianFood;
  bool? servesWine;
  bool? takeout;
  List<String>? types;
  String? url;
  int? userRatingsTotal;
  int? utcOffset;
  String? vicinity;
  String? website;
  bool? wheelchairAccessibleEntrance;

  Result(
      {this.addressComponents,
        this.adrAddress,
        this.businessStatus,
        this.curbsidePickup,
        this.currentOpeningHours,
        this.delivery,
        this.dineIn,
        this.editorialSummary,
        this.formattedAddress,
        this.formattedPhoneNumber,
        this.geometry,
        this.icon,
        this.iconBackgroundColor,
        this.iconMaskBaseUri,
        this.internationalPhoneNumber,
        this.name,
        this.openingHours,
        this.photos,
        this.placeId,
        this.plusCode,
        this.priceLevel,
        this.rating,
        this.reference,
        this.reservable,
        this.reviews,
        this.servesBeer,
        this.servesBreakfast,
        this.servesBrunch,
        this.servesDinner,
        this.servesLunch,
        this.servesVegetarianFood,
        this.servesWine,
        this.takeout,
        this.types,
        this.url,
        this.userRatingsTotal,
        this.utcOffset,
        this.vicinity,
        this.website,
        this.wheelchairAccessibleEntrance});

  Result.fromJson(Map<String, dynamic> json) {
    if (json['address_components'] != null) {
      addressComponents = <AddressComponents>[];
      json['address_components'].forEach((v) {
        addressComponents!.add(new AddressComponents.fromJson(v));
      });
    }
    adrAddress = json['adr_address'];
    businessStatus = json['business_status'];
    curbsidePickup = json['curbside_pickup'];
    currentOpeningHours = json['current_opening_hours'] != null
        ? new CurrentOpeningHours.fromJson(json['current_opening_hours'])
        : null;
    delivery = json['delivery'];
    dineIn = json['dine_in'];
    editorialSummary = json['editorial_summary'] != null
        ? new EditorialSummary.fromJson(json['editorial_summary'])
        : null;
    formattedAddress = json['formatted_address'];
    formattedPhoneNumber = json['formatted_phone_number'];
    geometry = json['geometry'] != null
        ? new Geometry.fromJson(json['geometry'])
        : null;
    icon = json['icon'];
    iconBackgroundColor = json['icon_background_color'];
    iconMaskBaseUri = json['icon_mask_base_uri'];
    internationalPhoneNumber = json['international_phone_number'];
    name = json['name'];
    openingHours = json['opening_hours'] != null
        ? new CurrentOpeningHours.fromJson(json['opening_hours'])
        : null;
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    placeId = json['place_id'];
    plusCode = json['plus_code'] != null
        ? new PlusCode.fromJson(json['plus_code'])
        : null;
    priceLevel = json['price_level'];
    rating = json['rating'];
    reference = json['reference'];
    reservable = json['reservable'];
    if (json['reviews'] != null) {
      reviews = <Reviews>[];
      json['reviews'].forEach((v) {
        reviews!.add(new Reviews.fromJson(v));
      });
    }
    servesBeer = json['serves_beer'];
    servesBreakfast = json['serves_breakfast'];
    servesBrunch = json['serves_brunch'];
    servesDinner = json['serves_dinner'];
    servesLunch = json['serves_lunch'];
    servesVegetarianFood = json['serves_vegetarian_food'];
    servesWine = json['serves_wine'];
    takeout = json['takeout'];
    types = json['types'].cast<String>();
    url = json['url'];
    userRatingsTotal = json['user_ratings_total'];
    utcOffset = json['utc_offset'];
    vicinity = json['vicinity'];
    website = json['website'];
    wheelchairAccessibleEntrance = json['wheelchair_accessible_entrance'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.addressComponents != null) {
      data['address_components'] =
          this.addressComponents!.map((v) => v.toJson()).toList();
    }
    data['adr_address'] = this.adrAddress;
    data['business_status'] = this.businessStatus;
    data['curbside_pickup'] = this.curbsidePickup;
    if (this.currentOpeningHours != null) {
      data['current_opening_hours'] = this.currentOpeningHours!.toJson();
    }
    data['delivery'] = this.delivery;
    data['dine_in'] = this.dineIn;
    if (this.editorialSummary != null) {
      data['editorial_summary'] = this.editorialSummary!.toJson();
    }
    data['formatted_address'] = this.formattedAddress;
    data['formatted_phone_number'] = this.formattedPhoneNumber;
    if (this.geometry != null) {
      data['geometry'] = this.geometry!.toJson();
    }
    data['icon'] = this.icon;
    data['icon_background_color'] = this.iconBackgroundColor;
    data['icon_mask_base_uri'] = this.iconMaskBaseUri;
    data['international_phone_number'] = this.internationalPhoneNumber;
    data['name'] = this.name;
    if (this.openingHours != null) {
      data['opening_hours'] = this.openingHours!.toJson();
    }
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['place_id'] = this.placeId;
    if (this.plusCode != null) {
      data['plus_code'] = this.plusCode!.toJson();
    }
    data['price_level'] = this.priceLevel;
    data['rating'] = this.rating;
    data['reference'] = this.reference;
    data['reservable'] = this.reservable;
    if (this.reviews != null) {
      data['reviews'] = this.reviews!.map((v) => v.toJson()).toList();
    }
    data['serves_beer'] = this.servesBeer;
    data['serves_breakfast'] = this.servesBreakfast;
    data['serves_brunch'] = this.servesBrunch;
    data['serves_dinner'] = this.servesDinner;
    data['serves_lunch'] = this.servesLunch;
    data['serves_vegetarian_food'] = this.servesVegetarianFood;
    data['serves_wine'] = this.servesWine;
    data['takeout'] = this.takeout;
    data['types'] = this.types;
    data['url'] = this.url;
    data['user_ratings_total'] = this.userRatingsTotal;
    data['utc_offset'] = this.utcOffset;
    data['vicinity'] = this.vicinity;
    data['website'] = this.website;
    data['wheelchair_accessible_entrance'] = this.wheelchairAccessibleEntrance;
    return data;
  }
}

class AddressComponents {
  String? longName;
  String? shortName;
  List<String>? types;

  AddressComponents({this.longName, this.shortName, this.types});

  AddressComponents.fromJson(Map<String, dynamic> json) {
    longName = json['long_name'];
    shortName = json['short_name'];
    types = json['types'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['long_name'] = this.longName;
    data['short_name'] = this.shortName;
    data['types'] = this.types;
    return data;
  }
}

class CurrentOpeningHours {
  bool? openNow;
  List<Periods>? periods;
  List<String>? weekdayText;

  CurrentOpeningHours({this.openNow, this.periods, this.weekdayText});

  CurrentOpeningHours.fromJson(Map<String, dynamic> json) {
    openNow = json['open_now'];
    if (json['periods'] != null) {
      periods = <Periods>[];
      json['periods'].forEach((v) {
        periods!.add(new Periods.fromJson(v));
      });
    }
    weekdayText = json['weekday_text'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['open_now'] = this.openNow;
    if (this.periods != null) {
      data['periods'] = this.periods!.map((v) => v.toJson()).toList();
    }
    data['weekday_text'] = this.weekdayText;
    return data;
  }
}

class Periods {
  Close? close;
  Close1? open;

  Periods({this.close, this.open});

  Periods.fromJson(Map<String, dynamic> json) {
    close = json['close'] != null ? new Close.fromJson(json['close']) : null;
    open = json['open'] != null ? new Close1.fromJson(json['open']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.close != null) {
      data['close'] = this.close!.toJson();
    }
    if (this.open != null) {
      data['open'] = this.open!.toJson();
    }
    return data;
  }
}

class Close {
  String? date;
  int? day;
  String? time;

  Close({this.date, this.day, this.time});

  Close.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }
}

class EditorialSummary {
  String? language;
  String? overview;

  EditorialSummary({this.language, this.overview});

  EditorialSummary.fromJson(Map<String, dynamic> json) {
    language = json['language'];
    overview = json['overview'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['language'] = this.language;
    data['overview'] = this.overview;
    return data;
  }
}

class Geometry {
  Location? location;
  Viewport? viewport;

  Geometry({this.location, this.viewport});

  Geometry.fromJson(Map<String, dynamic> json) {
    location = json['location'] != null
        ? new Location.fromJson(json['location'])
        : null;
    viewport = json['viewport'] != null
        ? new Viewport.fromJson(json['viewport'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    if (this.viewport != null) {
      data['viewport'] = this.viewport!.toJson();
    }
    return data;
  }
}

class Location {
  double? lat;
  double? lng;

  Location({this.lat, this.lng});

  Location.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    return data;
  }
}

class Viewport {
  Location? northeast;
  Location? southwest;

  Viewport({this.northeast, this.southwest});

  Viewport.fromJson(Map<String, dynamic> json) {
    northeast = json['northeast'] != null
        ? new Location.fromJson(json['northeast'])
        : null;
    southwest = json['southwest'] != null
        ? new Location.fromJson(json['southwest'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.northeast != null) {
      data['northeast'] = this.northeast!.toJson();
    }
    if (this.southwest != null) {
      data['southwest'] = this.southwest!.toJson();
    }
    return data;
  }
}

class Close1 {
  int? day;
  String? time;

  Close1({this.day, this.time});

  Close1.fromJson(Map<String, dynamic> json) {
    day = json['day'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['day'] = this.day;
    data['time'] = this.time;
    return data;
  }
}

class Photos {
  int? height;
  List<String>? htmlAttributions;
  String? photoReference;
  int? width;

  Photos({this.height, this.htmlAttributions, this.photoReference, this.width});

  Photos.fromJson(Map<String, dynamic> json) {
    height = json['height'];
    htmlAttributions = json['html_attributions'].cast<String>();
    photoReference = json['photo_reference'];
    width = json['width'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['height'] = this.height;
    data['html_attributions'] = this.htmlAttributions;
    data['photo_reference'] = this.photoReference;
    data['width'] = this.width;
    return data;
  }
}

class PlusCode {
  String? compoundCode;
  String? globalCode;

  PlusCode({this.compoundCode, this.globalCode});

  PlusCode.fromJson(Map<String, dynamic> json) {
    compoundCode = json['compound_code'];
    globalCode = json['global_code'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['compound_code'] = this.compoundCode;
    data['global_code'] = this.globalCode;
    return data;
  }
}

class Reviews {
  String? authorName;
  String? authorUrl;
  String? language;
  String? originalLanguage;
  String? profilePhotoUrl;
  dynamic rating;
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
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['author_name'] = this.authorName;
    data['author_url'] = this.authorUrl;
    data['language'] = this.language;
    data['original_language'] = this.originalLanguage;
    data['profile_photo_url'] = this.profilePhotoUrl;
    data['rating'] = this.rating;
    data['relative_time_description'] = this.relativeTimeDescription;
    data['text'] = this.text;
    data['time'] = this.time;
    data['translated'] = this.translated;
    return data;
  }
}