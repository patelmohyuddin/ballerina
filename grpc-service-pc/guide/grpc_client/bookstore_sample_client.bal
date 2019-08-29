import ballerina/grpc;
import ballerina/io;
import ballerina/log;

public function main (string... args) {
     

    bookstoreBlockingClient blockingEp = new("http://localhost:9090");
	
	
	 // Add an book
    log:printInfo("-----------------------Add a new Book-----------------------");
    BOOK bookReq = {id:"12346", category:"Eng", title:"yours", author:"patel mohyu", string_year:"2019", price:"2000"};
    var addResponse = blockingEp->addBook(bookReq);
	 BOOK bookReq1 = {id:"16586", category:"Eng", title:"bright", author:"patel amir", string_year:"2019", price:"2000"};
    var addResponse1 = blockingEp->addBook(bookReq1);
	 BOOK bookReq2 = {id:"17798", category:"Eng", title:"MAP", author:"patel bro", string_year:"2013", price:"4000"};
    var addResponse2 = blockingEp->addBook(bookReq2);
    if (addResponse is error) {
        log:printError("Error from Connector: " + addResponse.reason() + " - "
                                                + <string>addResponse.detail().message + "\n");
    } else {
        string result;
		//string results;
		//string resultss;
        grpc:Headers resHeaders;
		//grpc:Headers resHeaderss;
		//grpc:Headers resHeadersss;
		(result, resHeaders) = addResponse;
        //(result, resHeader) = addResponse1;
		//(resultss, resHeadersss) = addResponse;
        log:printInfo("Response - " + result + "\n");
       
        //log:printInfo("Response - " + results + "\n");
        
        //log:printInfo("Response - " + resultss + "\n");
		
		
    }
	
	
	
	 // Update an book
    log:printInfo("--------------------Update an existing book--------------------");
    BOOK updateReq = {id:"12346", category:"Eng", title:"ys", author:"patel moyu", string_year:"2019", price:"2000"};
    var updateResponse = blockingEp->updateBook(updateReq);
    if (updateResponse is error) {
        log:printError("Error from Connector: " + updateResponse.reason() + " - "
                                                + <string>updateResponse.detail().message + "\n");
    } else {
        string result;
        grpc:Headers resHeaders;
        (result, resHeaders) = updateResponse;
        log:printInfo("Response - " + result + "\n");
    }

    // Find an BOOK
    log:printInfo("---------------------Find an existing Book---------------------");
    var findResponse = blockingEp->findBook("12346");
	var findResponse1 = blockingEp->findBook("16586");
	var findResponse2 = blockingEp->findBook("17798");
    if (findResponse is error) {
        log:printError("Error from Connector: " + findResponse.reason() + " - "
                                                + <string>findResponse.detail().message + "\n");
    } else {
        string result;
		// string resultss;
		 // string results;
        grpc:Headers resHeaders;
        (result, resHeaders) = findResponse;
        log:printInfo("Response - " + result + "\n");
		// (results, resHeaders) = findResponse1;
        //log:printInfo("Response - " + results + "\n");
		 //(resultss, resHeaders) = findResponse2;
        //log:printInfo("Response - " + resultss + "\n");
    }
	

}



