@RestResource(urlMapping = '/RestAPIExample/*')
global with sharing class RestAPIExample {
    @Httppost
    global static void createcases() {
        RestAPIWrapper wrapper = new RestAPIWrapper();
        String reqString  = RestContext.request.requestbody.toString();
        List<RestAPIWrapper.Request> reqrecs = new List<RestAPIWrapper.Request>();
        reqrecs = (List<RestAPIWrapper.Request>) JSON.deserialize(reqString, List<RestAPIWrapper.Request>.class );
        
        
        
        RestResponse res = RestContext.response;
        RestAPIWrapper.response resbody = new RestAPIWrapper.response();
        string returnstring = JSON.serialize(resbody);
        res.Statuscode = 200;
        res.responseBody = Blob.Valueof(returnstring);
    }
    

}