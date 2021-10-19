@IsTest
public class MockHttpResponse implements HttpCalloutMock {
  static List<Mock> mocks;

  public static MockHttpResponse builder() {
    mocks = new List<Mock>{ new Mock() };
    return new MockHttpResponse();
  }

  public static MockHttpResponse emptyBuilder() {
    mocks = new List<Mock>();
    return new MockHttpResponse();
  }

  public MockHttpResponse next() {
    mocks.add(new Mock());
    return this;
  }

  public MockHttpResponse mockCalloutException(String exceptionMessage) {
    mocks.add(new Mock(exceptionMessage));
    return this;
  }

  public MockHttpResponse statusCode(Integer statusCode) {
    getCurrentResponse().setStatusCode(statusCode);
    return this;
  }

  public MockHttpResponse status(String status) {
    getCurrentResponse().setStatus(status);
    return this;
  }

  public MockHttpResponse contentType(String contentType) {
    getCurrentResponse().setHeader('Content-Type', contentType);
    return this;
  }

  public MockHttpResponse body(String body) {
    getCurrentResponse().setBody(body);
    return this;
  }

  public MockHttpResponse body(Map<String, Object> body) {
    getCurrentResponse().setBody(JSON.serialize(body));
    return this;
  }

  public HttpResponse respond(HttpRequest req) {
    Mock m = mocks.remove(0);

    if (m.isException) {
      CalloutException e = (CalloutException) CalloutException.class
        .newInstance();
      if (m.exceptionMessage != null) {
        e.setMessage(m.exceptionMessage);
      }
      throw e;
    }

    return m.res;
  }

  static HttpResponse getCurrentResponse() {
    return mocks[mocks.size() - 1].res;
  }

  class Mock {
    HttpResponse res;
    Boolean isException;
    String exceptionMessage;

    Mock() {
      res = new HttpResponse();
      res.setStatusCode(200);
      isException = false;
    }

    Mock(String exceptionMessage) {
      this.exceptionMessage = exceptionMessage;
      isException = true;
    }
  }
}
