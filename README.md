# MockHttpResponse

Salesforce HttpCalloutMock Interface implementation

## Usage

The code snippet below sets two mocks responses that are returned in order.

- Everything following a call to `next()` will be associated with the next response.

- A status code of 200 is set by default but may be overridden.

- `body()` can take a String or a Map which is then serialized.

- `emptyBuilder()` will not create a starter response by default. You will need to add one via `next()` or `mockCalloutException(String exceptionMessage)`.

- `mockCalloutException(String exceptionMessage)` will create a mock that throws a Callout Exception.

### Example: Create two mock responses
 ```java
 Test.setMock(HttpCalloutMock.class, MockHttpResponse.builder()
    .contentType('application/json')
    .body('{ "status": "OK" }')
    .next()
    .statusCode(201)
    .status('bibbity-bobbity')
    .body('some text')
 );
 ```

 ### Example: Create one mock response that throws a Callout Exception
 ```java
 Test.setMock(HttpCalloutMock.class, MockHttpResponse.emptyBuilder()
    .mockCalloutException('Oh noes!')
 );
 ```

 ### Example: Create one valid mock response and one that throws a Callout Exception
 ```java
 Test.setMock(HttpCalloutMock.class, MockHttpResponse.builder()
    .contentType('application/json')
    .body('{ "status": "OK" }')
    .mockCalloutException('Oh noes!')
 );
