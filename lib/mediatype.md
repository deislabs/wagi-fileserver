### Mediatype.**default_mt**

```grain
default_mt : String
```

### Mediatype.**guess**

```grain
guess : String -> String
```

Guess the media type of this file

Per recommendation, if no media type is found for an extension,
this returns `application/octet-stream`.

Parameters:

|param|type|description|
|-----|----|-----------|
|`filename`|`String`|The name of the file|

Returns:

|type|description|
|----|-----------|
|`String`|A media type|

