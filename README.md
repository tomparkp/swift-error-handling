This project was presented at the March 2016 meeting of [Philly Cocoaheads](http://phillycocoa.org).

It's an example API client project that demonstrates how to neatly handle errors through the use of things like enums, generics, protocols, and protocol extensions in Swift. It should be noted that this project is still relatively basic and that in a production project you'll probably want to expand on the boilerplate provided here.

## Kudos

* [Yosuke Ishikawa and APIKit](https://github.com/ishkawa/APIKit) - Although this presentation was in the context of organizing and handling errors the networking code is based very heavily on APIKit. After experimenting with many networking libraries I found Yosuke's approach to be a great combination of readability and scalability. If you want to take things a step further, or want to implement a networking approach similar to the one used in this project without writing the boilerplate check out APIKit.

* [Freddy](https://github.com/bignerdranch/Freddy) - A very nice JSON parsing library from our friends at the Big Nerd Ranch. I felt like writing a JSON parser was something for another day so this library is used in the project.

* [Soroush Khanlou](http://khanlou.com/) - His articles are all in Objective-C but Soroush's blog really sold me on breaking down my project into small, single-purpose objects and keeping my view controller code focused on handling user input. Really great articles here.

* [Moya](https://github.com/Moya/Moya) - Moya is another fantastic networking library for Swift. Although the end result of my networking code was much closer to APIKit I leveraged a lot of concepts from Moya throughout my experimentation with networking in Swift.

* [Alamofire](https://github.com/Alamofire/Alamofire) - Although this project uses NSURLSession, the documentation and source for Alamofire was what started me on the journey of experimenting with networking in Swift.

* [Siesta](https://github.com/bustoutsolutions/siesta) - Though not used in this project Siesta is doing some really cool things with networking in Swift. Breaking down the source and experimenting with this approach is what I plan to do next.

* [Philly Cocoaheads](http://phillycocoa.org) - It's where I've learned just about everything I know about creating great apps for Apple's platforms.
