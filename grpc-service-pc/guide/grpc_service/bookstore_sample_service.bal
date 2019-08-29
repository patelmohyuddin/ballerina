import ballerina/grpc;
import ballerina/log;
import ballerinax/docker;

@docker:Config {
    registry:"ballerina.guides.io",
    name:"grpc_service",
    tag:"v1.0"
}

@docker:Expose{}
// gRPC service endpoint definition.
listener grpc:Listener ep = new (9090);
map<BOOK> bookMap = {};

service bookstore on ep {

    resource function findBook(grpc:Caller caller, string bookId) {
        // Implementation goes here.
		 string payload = "";
        error? result = ();
        // Find the requested book from the map.
        if (bookMap.hasKey(bookId)) {
            var jsonValue = json.convert(bookMap[bookId]);
            if (jsonValue is error) {
                // Send casting error as internal error.
                result = caller->sendError(grpc:INTERNAL, <string>jsonValue.detail().message);
            } else {
                json bookDetails = jsonValue;
                payload = bookDetails.toString();
                // Send response to the caller.
                result = caller->send(payload);
                result = caller->complete();
            }
        } else {
            // Send entity not found error.
            payload = "Book : '" + bookId + "' cannot be found.";
            result = caller->sendError(grpc:NOT_FOUND, payload);
        }

        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + " - "
                    + <string>result.detail().message + "\n");
        }	

        // You should return a string
    }
	
	
	
	
	
	
    resource function addBook(grpc:Caller caller, BOOK bookReq) {
        // Implementation goes here.

		// Add the new Book to the map.
        string bookId = bookReq.id;
        bookMap[bookReq.id] = bookReq;
        // Create response message.
        string payload = "Status : Book created; BookID : " + bookId;

        // Send response to the caller.
        error? result = caller->send(payload);
        result = caller->complete();
        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + " - "
                    + <string>result.detail().message + "\n");
        }
        // You should return a string
    }
	
	
    resource function updateBook(grpc:Caller caller, BOOK updatedBook) {
        // Implementation goes here.

		 string payload;
        error? result = ();
        // Find the book that needs to be updated.
        string bookId = updatedBook.id;
        if (bookMap.hasKey(bookId)) {
            // Update the existing book.
            bookMap[bookId] = updatedBook;
            payload = "Book : '" + bookId + "' updated.";
            // Send response to the caller.
            result = caller->send(payload);
            result = caller->complete();
        } else {
            // Send entity not found error.
            payload = "Book : '" + bookId + "' cannot be found.";
            result = caller->sendError(grpc:NOT_FOUND, payload);
        }

        if (result is error) {
            log:printError("Error from Connector: " + result.reason() + " - "
                    + <string>result.detail().message + "\n");
        }




        // You should return a string
    }
}

