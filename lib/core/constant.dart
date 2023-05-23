/// Radius default in meters
const double radiusDefault = 5000;

const String fields = 'formatted_address,name,rating,opening_hours,geometry';

/// Restricted Google Map API Key
const String apiKey = 'AIzaSyCkelhHftYwdyGcrODDsIWfKlGjBpdQuKY';

/// Get base photo url
String getPhotoUrl(String photoRef) =>
    'https://maps.googleapis.com/maps/api/place/photo?maxwidth=680&photo_reference=$photoRef&key=$apiKey';

/// No Image
const String noImage =
    'https://us.123rf.com/450wm/yehorlisnyi/yehorlisnyi2104/yehorlisnyi210400016/167492439-no-photo-or-blank-image-icon-loading-images-or-missing-image-mark-image-not-available-or-image.jpg?ver=6';

/// Google places API base URL
const String placeApiUrl = 'https://maps.googleapis.com/maps/api/place/';
