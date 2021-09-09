### Stringutil.**reverse**

```grain
reverse : String -> String
```

Return a String that is the reverse of the given String.

Parameters:

|param|type|description|
|-----|----|-----------|
|`str`|`String`|The string to reverse.|

Returns:

|type|description|
|----|-----------|
|`String`|A reversed version of the given string|

### Stringutil.**lastIndexOf**

```grain
lastIndexOf : (String, String) -> Option<Number>
```

Get the index of the last appearance of needle in the haystack.

For a multi-character needle, this will return the end of that sequence,
not the beginning (as indexOf does).

Parameters:

|param|type|description|
|-----|----|-----------|
|`needle`|`String`|The string to search for|
|`haystack`|`String`|The string to be searched|

Returns:

|type|description|
|----|-----------|
|`Option<Number>`|The offset, if found, or a number|

### Stringutil.**afterLast**

```grain
afterLast : (String, String) -> String
```

### Stringutil.**beforeLast**

```grain
beforeLast : (String, String) -> String
```

