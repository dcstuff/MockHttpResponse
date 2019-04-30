# MockHttpResponse

Salesforce HttpCalloutMock Interface implementation

## Usage

The code snippet below sets two mocks responses that are returned in order.

- Everything following a call to `next()` will be associated with the next response.

- A status code of 200 is set by default but may be overridden.

- `body()` can take a String or a Map which is then serialized.

 ```java
 Test.setMock(HttpCalloutMock.class, MockHttpResponse.builder()
    .contentType('application/json')
    .body('{ "status": "OK" }')
    .next()
    .statusCode(201)
    .status(new Map<String, Object>{ 'some-key' => some-value })
    .body('some text')
 );
 ```
