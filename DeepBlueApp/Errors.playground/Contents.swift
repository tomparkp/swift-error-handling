//: Playground - noun: a place where people can play

import UIKit


/* Common Error Handling Styles */


// ErrorType

/*  From Apple: In Swift, errors are represented by values of types that conform to the ErrorType protocol.
This empty protocol indicates that a type can be used for error handling. */

enum Error: ErrorType {
    case Chaos
}



// Optional Error Parameter

func optionalError(completion: (result: String?, error: ErrorType?) -> Void)  {
    let two = 1+1

    guard two == 2 else {
        completion(result: nil, error: Error.Chaos)
        return
    }

    completion(result: "Success", error: nil)
}

optionalError { (result, error) -> Void in
    if error != nil {
        print("Chaos!")
    } else {
        print("Success")
    }
}



// Success-Failure Closures

func closureFunction(onSuccess success: ((result: String) -> Void), onFailure failure: ((error: ErrorType) -> Void)) {
    let two = 1+1

    guard two == 2 else {
        failure(error: Error.Chaos)
        return
    }

    success(result: "Success")
}

closureFunction(
    onSuccess: { result in
        print("Success")
    },
    onFailure: { error in
        print("Chaos!")
})


// Libraries will often used chained closures instead of the above

/*
closureFunction().onSuccess({ result in
print("Success")
}).onFailure({ error in
print("Chaos!")
})
*/


// Try Catch


func throwingFunction() throws -> String {
    let two = 1+1

    guard two == 2 else {
        throw Error.Chaos
    }

    return "Success"
}

do {
    let result = try throwingFunction()
    print(result)
} catch {
    print("Error!")
}




// Result

enum Result<T, E: ErrorType> {
    case Success(T)
    case Failure(E)
}

func resultFunction() -> Result<String, Error> {
    let two = 1+1

    guard two == 2 else {
        return .Failure(Error.Chaos)
    }

    return .Success("Success")
}

