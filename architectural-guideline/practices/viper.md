***Work in Progress***
## **Trendyol iOS App Architectural Design Pattern**
For architectural design pattern we use VIPER to achieve more scalable and testable code. As known we seperate a VIPER module into 4 layers named **view**, **presenter**, **router** and **interactor**.  You can see relationship between VIPER layers below;

![](https://i.ibb.co/9VJYZp1/Viper-2.png "")

### **View**

View is a dummy object, it is responsible from displaying view elements and notifying presenter with touch events received from the user. Instead of MVC’s massive view controller with thousands lines of codes, basically all network calls and business logic should not exist in it.

### **Presenter**

Presenter is the heart of the viper module. It retains all layers. All presentation logic should be handled here. It should not import UIKit since View layer is responsible from view related stuff.

### **Router**

Router (aka Wireframe in some documents) is responsible from navigation. When it is required to navigate a page, showing an alert, presenting a sheet etc, presenter invokes the router to do job.

### **Interactor**

Networking related stuff is handled here. It is retained by presenter and after the network call is finished, interactor invokes the output through the weak instance, it is presenter in most cases.
<br/><br/>

- ***TODO***: Better visuals
- ***TODO***: An example from project

## **Unit Testing**
- ***TODO***: Unit Tests
