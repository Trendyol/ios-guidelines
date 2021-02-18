***Work in Progress***
## Layering Approach

We have divided the frameworks in the app into 3 layers named **Core**, **Kit** and **Module**. For preventing circular imports between different frameworks we have decided that a framework in a layer only import a framework from lower layer.
If a framework is designed and used by a spesific channel only , this framework should be placed under designated channel target. For common frameworks we have a folder outside of the channels folder level. To understand what means layers mentioned above, lets examine them one by one;
<br/><br/>

![](https://i.ibb.co/VqyyDd5/Layers.png "")
<br/><br/>
### **Core layer**
Core layer includes most generic frameworks which are used commonly. Since these frameworks behave like a base for other frameworks in upper layers, a core framework cannot embed neither a framework from kit layer or module layer. Samples;

- CoreNetwork
- CoreTracker
- CoreUtils

### **Kit layer**
Kit layer includes helper-like frameworks used by modules. Since a kit framework can be used by different modules, these frameworks are highly reusable. To achieve common tasks, these frameworks can embed and use core frameworks. Samples;

- MemberKit
- SearchSuggestionKit
- FavoriteHandlerKit

### **Module layer**
Module layer includes pages and common views that user interacts directly with. Since module frameworks are at the top layer, these frameworks can embed and use core and kit layer frameworks.

- FavoriteModule
- AccountModule
- CategoriesModule
<br/><br/>

### **Overall Structure**
As you can see all project built with frameworks using layering approach mentioned above. Modules grouped under main targets, they're are using required kit frameworks. These kit frameworks can either belong to one channel module or can be shared by different channel modules. Frameworks at the core layer mostly used commonly.

![](https://i.ibb.co/tq8Lp8b/Overall.png "")