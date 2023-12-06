***Work in Progress***
# Trendyol iOS App Architecture

Trendyol iOS app workspace consists of 1 main app target and 3 other targets named **channels**. As well as each channel has own pages and business logics, also they all share same architecturel design explained the sections below.
<br/><br/>

| Trendyol        | Meal           | DolapLite  | Instant Delivery
| :-------------: |:-------------:| :-----:| :-----: |
| Main Trendyol App | Online Catering      |    Second Hand Fashion | Grocery Shopping |
| ![](https://i.ibb.co/PrBf8M5/Webp-net-resizeimage-6.jpg "")      | ![](https://i.ibb.co/ZTnbj6M/Webp-net-resizeimage-4.jpg "") | ![](https://i.ibb.co/ccqtVN7/Webp-net-resizeimage-5.jpg "") | ![](https://i.ibb.co/zb0cr4F/Webp-net-resizeimage-3.jpg "") |

Although these channels seems like a standalone app when opened, they're shipped under one executable app target. There are frameworks used only by channels as well as there are frameworks used in commonly between different channels.

To achieve a clean architecture across frameworks, app architecture consists of dynamic frameworks placed in **different layers.**
<br/><br/>

For detailed info for each practice, you can navigate using links below;

| Topic | Info |
| ------ | ------ |
| [Layering Approach](practices/layering_approach.md) | What is layering approach, how we build the project using frameworks in different layers |
| [Networking](practices/networking.md) | CoreApi, NetworkManager, Interceptors, Logging  |
| [VIPER as Architectural Design Pattern](practices/viper.md) | How we implement VIPER, Layers, Viper practices, Unit tests |
| [Routing](practices/routing.md) | How we handle navigating between different modules, Deeplinking |