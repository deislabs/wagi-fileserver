### Env.**splitEnvVar**

```grain
splitEnvVar : String -> (String, String)
```

Split an environment variable at the first equals sign.

Parameters:

|param|type|description|
|-----|----|-----------|
|`item`|`String`|An environment variable pair, separated by an equals sign (=).|

Returns:

|type|description|
|----|-----------|
|`(String, String)`|A tuple key/value pair.|

### Env.**envMap**

```grain
envMap : () -> Map.Map<a, b>
```

Get the environment variables as a Map<String, String>

Returns:

|type|description|
|----|-----------|
|`Map.Map<a, b>`|A map of all environment variables.|

