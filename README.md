# Network request and decoding errors in Swift

This is a listing of raw data returned from different cases of network requests and model decoding in Swift, with emphasis on error cases. Useful for the purpose of mocking error responses.

The [Star Wars API](https://swapi.co/api/) is used as reference. 

Sample output of playground follows for convenience.

## Exercise 1: Successful request
**Data:** : 
```
Optional("{\"people\":\"https://swapi.co/api/people/\",\"planets\":\"https://swapi.co/api/planets/\",\"films\":\"https://swapi.co/api/films/\",\"species\":\"https://swapi.co/api/species/\",\"vehicles\":\"https://swapi.co/api/vehicles/\",\"starships\":\"https://swapi.co/api/starships/\"}")
```

**Response**:
``` 
<NSHTTPURLResponse: 0x6000000338c0> { URL: https://swapi.co/api/ } { Status Code: 200, Headers {
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "application/json"
    );
    Date =     (
        "Wed, 16 May 2018 12:09:45 GMT"
    );
    Etag =     (
        "W/\"c1df070b0509ebefe72e85d721f40bf0\""
    );
    Server =     (
        cloudflare
    );
    Vary =     (
        "Accept, Cookie"
    );
    Via =     (
        "1.1 vegur"
    );
    allow =     (
        "GET, HEAD, OPTIONS"
    );
    "cf-ray" =     (
        "41bdbcbb7f7263df-FRA"
    );
    "expect-ct" =     (
        "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""
    );
    "x-frame-options" =     (
        SAMEORIGIN
    );
} }
```
**Network error**: none

**Decoded model**: 
```
API(films: https://swapi.co/api/films/, people: https://swapi.co/api/people/, planets: https://swapi.co/api/planets/, species: https://swapi.co/api/species/, starships: https://swapi.co/api/starships/, vehicles: https://swapi.co/api/vehicles/)
```

## Exercise 2: non-existing host
**Data**: none 

**Response**: none

**Network Error** :
```
Error Domain=NSURLErrorDomain Code=-1003 "A server with the specified hostname could not be found." UserInfo={NSUnderlyingError=0x600001055d80 {Error Domain=kCFErrorDomainCFNetwork Code=-1003 "(null)" UserInfo={_kCFStreamErrorCodeKey=8, _kCFStreamErrorDomainKey=12}}, NSErrorFailingURLStringKey=https://nonexisting.co/api/, NSErrorFailingURLKey=https://nonexisting.co/api/, _kCFStreamErrorDomainKey=12, _kCFStreamErrorCodeKey=8, NSLocalizedDescription=A server with the specified hostname could not be found.}
```

## Exercise 3: non-existing resource
**Data**: 
```
Optional("<!DOCTYPE html>\n<html lang=\"en\">\n\n<head>\n<meta charset=\"utf-8\">\n<title>\n      SWAPI - The Star Wars API\n    </title>\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n<link rel=\"stylesheet\" href=\"//netdna.bootstrapcdn.com/bootstrap/3.1.1/css/bootstrap.min.css\">\n<link href=\"/static/css/bootstrap.css\" rel=\"stylesheet\">\n<link href=\"/static/css/custom.css\" rel=\"stylesheet\">\n<link rel=\"shortcut icon\" href=\"/static/favicon.ico\">\n</style>\n<script src=\"//code.jquery.com/jquery-2.1.0.min.js\" type=\"12b2974bbe4f5b3be4eb1eb3-\"></script>\n<script src=\"//maxcdn.bootstrapcdn.com/bootstrap/3.3.0/js/bootstrap.min.js\" type=\"12b2974bbe4f5b3be4eb1eb3-\"></script>\n</script>\n</head>\n<body>\n<nav class=\"navbar navbar-default\" role=\"navigation\">\n<div class=\"container-fluid\">\n<div class=\"navbar-header\">\n<button 
```
(abridged for brevity)
**Response**: 
```
<NSHTTPURLResponse: 0x60400002eec0> { URL: https://swapi.co/api/chewbacca/ } { Status Code: 404, Headers {
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "text/html; charset=utf-8"
    );
    Date =     (
        "Wed, 16 May 2018 12:54:30 GMT"
    );
    Server =     (
        cloudflare
    );
    Via =     (
        "1.1 vegur"
    );
    "cf-ray" =     (
        "41bdfe484ca263df-FRA"
    );
    "expect-ct" =     (
        "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""
    );
    "x-frame-options" =     (
        SAMEORIGIN
    );
} }
```

**Network error**: none

**Decoding error**:
``` 
dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "JSON text did not start with array or object and option to allow fragments not set." UserInfo={NSDebugDescription=JSON text did not start with array or object and option to allow fragments not set.})))
```

## Exercise 4: non-existing query
**Data**: 
```
Optional("{\"count\":7,\"next\":null,\"previous\":null,\"results\":[{\"title\":\"A New Hope\",\"episode_id\":4,\"opening_crawl\":\"It is a period of civil war.\\r\\nRebel spaceships, striking\\r\\nfrom a hidden base, have won\\r\\ntheir first victory against\\r\\nthe evil Galactic Empire.\\r\\n\\r\\nDuring the battle, Rebel\\r\\nspies managed to steal secret\\r\\nplans to the Empire\'s\\r\\nultimate weapon, the DEATH\\r\\nSTAR, an armored space\\r\\nstation with enough power\\r\\nto destroy an entire planet.\\r\\n\\r\\nPursued by the Empire\'s\\r\\nsinister agents, Princess\\r\\nLeia races home aboard her\\r\\nstarship, custodian of the\\r\
```
(abridged for brevity)

**Response**: 
```
<NSHTTPURLResponse: 0x6000002237a0> { URL: https://swapi.co/api/films/?nonexisting=query } { Status Code: 200, Headers {
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "application/json"
    );
    Date =     (
        "Thu, 17 May 2018 09:37:31 GMT"
    );
    Etag =     (
        "W/\"a6f57b83572279727b3a9208d0653a82\""
    );
    Server =     (
        cloudflare
    );
    Vary =     (
        "Accept, Cookie"
    );
    Via =     (
        "1.1 vegur"
    );
    allow =     (
        "GET, HEAD, OPTIONS"
    );
    "cf-ray" =     (
        "41c51b159f046403-FRA"
    );
    "expect-ct" =     (
        "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""
    );
    "x-frame-options" =     (
        SAMEORIGIN
    );
} }
```
**Network error**: none

**Decoding error**: 
```
typeMismatch(Swift.Double, Swift.DecodingError.Context(codingPath: [CodingKeys(stringValue: "results", intValue: nil), _JSONKey(stringValue: "Index 0", intValue: 0), CodingKeys(stringValue: "releaseDate", intValue: nil)], debugDescription: "Expected to decode Double but found a string/data instead.", underlyingError: nil))
```

## Exercise 5: corrupted data (non-conforming JSON)
**Data**: (overriden by playground for sample of corrupted data)

**Response**: 
```
<NSHTTPURLResponse: 0x600000026fc0> { URL: https://swapi.co/api/ } { Status Code: 200, Headers {
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "application/json"
    );
    Date =     (
        "Wed, 16 May 2018 12:54:34 GMT"
    );
    Etag =     (
        "W/\"c1df070b0509ebefe72e85d721f40bf0\""
    );
    Server =     (
        cloudflare
    );
    Vary =     (
        "Accept, Cookie"
    );
    Via =     (
        "1.1 vegur"
    );
    allow =     (
        "GET, HEAD, OPTIONS"
    );
    "cf-ray" =     (
        "41bdfe5c684a6415-FRA"
    );
    "expect-ct" =     (
        "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""
    );
    "x-frame-options" =     (
        SAMEORIGIN
    );
} }
```

**Network error**: none

**Decoding error**:  
```
dataCorrupted(Swift.DecodingError.Context(codingPath: [], debugDescription: "The given data was not valid JSON.", underlyingError: Optional(Error Domain=NSCocoaErrorDomain Code=3840 "JSON text did not start with array or object and option to allow fragments not set." UserInfo={NSDebugDescription=JSON text did not start with array or object and option to allow fragments not set.})))
```

## Exercise 6: model mismatch / wrong decoding key
**Data**: 
```
Optional("{\"people\":\"https://swapi.co/api/people/\",\"planets\":\"https://swapi.co/api/planets/\",\"films\":\"https://swapi.co/api/films/\",\"species\":\"https://swapi.co/api/species/\",\"vehicles\":\"https://swapi.co/api/vehicles/\",\"starships\":\"https://swapi.co/api/starships/\"}")
```

**Response**: 
```
<NSHTTPURLResponse: 0x60400002e3e0> { URL: https://swapi.co/api/ } { Status Code: 200, Headers {
    "Content-Encoding" =     (
        gzip
    );
    "Content-Type" =     (
        "application/json"
    );
    Date =     (
        "Wed, 16 May 2018 12:54:35 GMT"
    );
    Etag =     (
        "W/\"c1df070b0509ebefe72e85d721f40bf0\""
    );
    Server =     (
        cloudflare
    );
    Vary =     (
        "Accept, Cookie"
    );
    Via =     (
        "1.1 vegur"
    );
    allow =     (
        "GET, HEAD, OPTIONS"
    );
    "cf-ray" =     (
        "41bdfe63fc5863af-FRA"
    );
    "expect-ct" =     (
        "max-age=604800, report-uri=\"https://report-uri.cloudflare.com/cdn-cgi/beacon/expect-ct\""
    );
    "x-frame-options" =     (
        SAMEORIGIN
    );
} }
```
**Network error**: none

**Decoding error**: 
```
keyNotFound(CodingKeys(stringValue: "count", intValue: nil), Swift.DecodingError.Context(codingPath: [], debugDescription: "No value associated with key CodingKeys(stringValue: \"count\", intValue: nil) (\"count\").", underlyingError: nil))
```

## Exercise 7: request in offline mode (disable host connection in playground to get it)
**Data**: none 

**Response**: none

**Network Error** :
```
Error Domain=NSURLErrorDomain Code=-1009 "The Internet connection appears to be offline." UserInfo={NSUnderlyingError=0x60400005fbf0 {Error Domain=kCFErrorDomainCFNetwork Code=-1009 "(null)" UserInfo={_kCFStreamErrorCodeKey=50, _kCFStreamErrorDomainKey=1}}, NSErrorFailingURLStringKey=https://swapi.co/api/, NSErrorFailingURLKey=https://swapi.co/api/, _kCFStreamErrorDomainKey=1, _kCFStreamErrorCodeKey=50, NSLocalizedDescription=The Internet connection appears to be offline.}
```



