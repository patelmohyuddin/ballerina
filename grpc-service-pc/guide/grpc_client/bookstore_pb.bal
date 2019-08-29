import ballerina/grpc;
import ballerina/io;

public type bookstoreBlockingClient client object {
    private grpc:Client grpcClient;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config = config);
        error? result = c.initStub("blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function findBook(string req, grpc:Headers? headers = ()) returns ((string, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("grpc_service.bookstore/findBook", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        return (string.convert(result), resHeaders);
    }

    remote function addBook(BOOK req, grpc:Headers? headers = ()) returns ((string, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("grpc_service.bookstore/addBook", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        return (string.convert(result), resHeaders);
    }

    remote function updateBook(BOOK req, grpc:Headers? headers = ()) returns ((string, grpc:Headers)|error) {
        
        var payload = check self.grpcClient->blockingExecute("grpc_service.bookstore/updateBook", req, headers = headers);
        grpc:Headers resHeaders = new;
        any result = ();
        (result, resHeaders) = payload;
        return (string.convert(result), resHeaders);
    }

};

public type bookstoreClient client object {
    private grpc:Client grpcClient;

    function __init(string url, grpc:ClientEndpointConfig? config = ()) {
        // initialize client endpoint.
        grpc:Client c = new(url, config = config);
        error? result = c.initStub("non-blocking", ROOT_DESCRIPTOR, getDescriptorMap());
        if (result is error) {
            panic result;
        } else {
            self.grpcClient = c;
        }
    }


    remote function findBook(string req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("grpc_service.bookstore/findBook", req, msgListener, headers = headers);
    }

    remote function addBook(BOOK req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("grpc_service.bookstore/addBook", req, msgListener, headers = headers);
    }

    remote function updateBook(BOOK req, service msgListener, grpc:Headers? headers = ()) returns (error?) {
        
        return self.grpcClient->nonBlockingExecute("grpc_service.bookstore/updateBook", req, msgListener, headers = headers);
    }

};

type BOOK record {|
    string id;
    string category;
    string title;
    string author;
    string string_year;
    string price;
    
|};



const string ROOT_DESCRIPTOR = "0A0F626F6F6B73746F72652E70726F746F120C677270635F736572766963651A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F228A010A04424F4F4B120E0A02696418012001280952026964121A0A0863617465676F7279180220012809520863617465676F727912140A057469746C6518032001280952057469746C6512160A06617574686F721804200128095206617574686F7212120A047965617218052001280952047965617212140A0570726963651806200128095205707269636532D0010A09626F6F6B73746F726512460A0866696E64426F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123B0A07616464426F6F6B12122E677270635F736572766963652E424F4F4B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123E0A0A757064617465426F6F6B12122E677270635F736572766963652E424F4F4B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33";
function getDescriptorMap() returns map<string> {
    return {
        "bookstore.proto":"0A0F626F6F6B73746F72652E70726F746F120C677270635F736572766963651A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F228A010A04424F4F4B120E0A02696418012001280952026964121A0A0863617465676F7279180220012809520863617465676F727912140A057469746C6518032001280952057469746C6512160A06617574686F721804200128095206617574686F7212120A047965617218052001280952047965617212140A0570726963651806200128095205707269636532D0010A09626F6F6B73746F726512460A0866696E64426F6F6B121C2E676F6F676C652E70726F746F6275662E537472696E6756616C75651A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123B0A07616464426F6F6B12122E677270635F736572766963652E424F4F4B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565123E0A0A757064617465426F6F6B12122E677270635F736572766963652E424F4F4B1A1C2E676F6F676C652E70726F746F6275662E537472696E6756616C7565620670726F746F33",
        "google/protobuf/wrappers.proto":"0A1E676F6F676C652F70726F746F6275662F77726170706572732E70726F746F120F676F6F676C652E70726F746F62756622230A0B446F75626C6556616C756512140A0576616C7565180120012801520576616C756522220A0A466C6F617456616C756512140A0576616C7565180120012802520576616C756522220A0A496E74363456616C756512140A0576616C7565180120012803520576616C756522230A0B55496E74363456616C756512140A0576616C7565180120012804520576616C756522220A0A496E74333256616C756512140A0576616C7565180120012805520576616C756522230A0B55496E74333256616C756512140A0576616C756518012001280D520576616C756522210A09426F6F6C56616C756512140A0576616C7565180120012808520576616C756522230A0B537472696E6756616C756512140A0576616C7565180120012809520576616C756522220A0A427974657356616C756512140A0576616C756518012001280C520576616C756542570A13636F6D2E676F6F676C652E70726F746F627566420D577261707065727350726F746F50015A057479706573F80101A20203475042AA021E476F6F676C652E50726F746F6275662E57656C6C4B6E6F776E5479706573620670726F746F33"
        
    };
}

