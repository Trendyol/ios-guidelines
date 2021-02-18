***Work in Progress***
# Networking

We have a framework at the core layer named **TYCoreAPI** for executing networking operations. It uses third party HTTP networking library, commonly known as ***Alamofire***.
Since TYCoreAPI is the core-level framework at the project, it provides definitions and protocols to channel-level frameworks.

For seperating api logic between channels, we have ***networker*** frameworks at the kit level for each channel, which are TYNetworker, DLNetworker, MLNetworker and IDNetworker at this moment.

## TYCoreAPI

TYCoreAPI is the backbone of the networking of the Trendyol app. It provides **NetworkManager** to make http requests. You can see content of the CoreApi;

![](https://i.ibb.co/NNz7zGp/Webp-net-resizeimage-4.png "")

It is not necessary to give implementation details of all these files, however we can look at the important ones;

## NetworkManager

```swift
final public class NetworkManager<EndpointItem: Endpoint> {
    private let sessionManager: Alamofire.Session
    private let networkLogger: NetworkLoggerInterface
    private let interceptor: RequestInterceptor?

    public init(sessionManager: Alamofire.Session? = nil,
                isSSLPinningActive: Bool = true,
                host: String,
                networkLogger: NetworkLoggerInterface,
                interceptor: RequestInterceptor? = nil) {
    // initializations
    }

    public func request<T: Decodable>(endpoint: EndpointItem, type: T.Type, completion: @escaping Completion<T>) {
        sessionManager.request(endpoint.url,
                               method: endpoint.method,
                               parameters: endpoint.params,
                               encoding: endpoint.method.encoding,
                               headers: HTTPHeaders(endpoint.headers),
                               interceptor: interceptor)
            .validate()
            .response(responseSerializer: DataResponseSerializer(emptyResponseCodes: possibleEmptyBodyResponseCodes), completionHandler: { [weak self] response in
                    // Response Handling
                )
    }
```
<br/><br/>
As you can see, there is one initializer and one request method here after implementation details are hidden. 

### Dependencies of the Network Manager
Network manager takes parameters below using initializer;
1. **sessionManager**: Session manager used in the network manager. For most case, default session of Alamofire is used. It's injected due to increase testability
2. **isSSLPinningActive**: Flag to determine whether SSL pinning should be applied or not
3. **host**: String parameter used in ssl pinning
4. **networkLogger**: NetworkLoggerInterface instance, used for logging requests and responses
5. **interceptor**: An instance of Alamofire's RequestInterceptor, it used to add default headers at this moment.

### Request Method
As you can see, NetworkManager is a generic class and this generic type used at the request method. When making a request, it's required to provide EndpointItem, which is a class/struct conforms to Endpoint protocol.

### Parameters of Request Method
There are three parameters needed while making an url request;

1. **endpoint**: Instance that conforms to Endpoint protocol. **Endpoint** protocol guarantees conforming struct provides basic properties of an urlRequest, such as httpMethod, url etc.

```swift
public protocol Endpoint: CustomStringConvertible {
    var baseUrl: String { get }
    var path: String { get }
    var params: [String: Any]? { get }
    var headers: [String: String] { get }
    var url: String { get }
    var method: HTTPMethod { get }
}
```

Extension of the **Endpoint** protocol provides default parameters as well as helper variables like description for debugging;

```swift
public extension Endpoint {
    var params: [String: Any]? { nil }
    var url: String { "\(baseUrl)\(path)" }
    var headers: [String: String] { [:] }
    var description: String { // description of endpoint using params }
}
```

2. **type**:  Type of a class/struct represents succesfull response model, conforms to Decodable protocol.

3. **completion**: A closure used to make callback when url request is completed.

```swift
public typealias Completion<T> = (Result<T, APIClientError>) -> Void where T: Decodable
```

## Networker

Networker is a public protocol of the TYCoreAPI framework, which provides network manager instance mentioned above;

```swift
public protocol Networker {
    associatedtype EndpointType: Endpoint
    
    var networkManager: NetworkManager<EndpointType> { get set }
}
```

Thanks to the Networker protocol, we don't have to create and retain networkManager instance for each interactor (request handler class in the VIPER). We have 4 unique networkers which conform to this Networker protocol for each channel instead. You can see the dependency between these and core api the graph below;

![](https://i.ibb.co/J2p8wy3/Group-11.png "")

For example, for Dolap Lite channel DLNetworker is used;

```swift
open class DLNetworker<T: Endpoint>: Networker {
    public typealias EndpointType = T
    
    public var networkManager: NetworkManager<T>
    
    public init() {
        networkManager = NetworkManager(host: Constant.host, networkLogger: CoreNetworkLogger(subsystem: Constant.loggerSubSystem, category: Constant.loggerCategory), interceptor: DLAuthRequestInterceptor())
    }
}
```

Each module or kit of the Dolap Lite which requires to make network call should import DLNetworker. For example, interactor layer of dolap lite orders module conforms to DLNetworker as shown below;

```swift
class DLOrderListInteractor: DLNetworker<DLOrderEndpointItem>, DLOrderListInteractorInterface {
    weak var output: DLOrderListInteractorOutput?
    
    func fetchOrderList(path: String) {
        networkManager.request(endpoint: .orderList(path: path), type: DLOrderListResponse.self) { [weak self] result in
            self?.output?.handleOrderListResponse(result)
        }
    }
}
```

Since **DLNetworker** class is generic and requires a generic type conforms to Endpoint due to **Networker** protocol, you can see **DLOrderEndpointItem** is given here. You can see basic implementation of DLOrderEndpointItem below;

```swift
enum DLOrderEndpointItem: Endpoint {
    case orderList(path: String)

    var path: String { return "/order?\(path)" }
    var method: HTTPMethod { .get }
    var baseUrl: String { APIURL.DolapLite.root.baseURL }
}
```


### RequestInterceptor
- *TODO*

### NetworkLogger
- *TODO*