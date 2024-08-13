public class EmployeeDataController {
    
    @AuraEnabled
    public static string getEmployeeDetails(){
        string resResult='';
        try{
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://dummy.restapiexample.com/api/v1/employees');
            req.setMethod('GET');
            HttpResponse res = new HttpResponse();
            res = http.send(req);
            if(res.getStatusCode() == 200){
                system.debug('response-->'+res);
                system.debug('response body -->'+res.getBody());
                resResult = String.valueOf(res.getBody());
            }   
        } catch(exception e){
            system.debug('Exception Occured -->'+ e);
        }
       return resResult; 
    }
    
    @AuraEnabled
    public static string createEmployee(string empdetails){
        string resResult='';
        string tempdetails = empdetails;
        try{
            Http http = new Http();
            HttpRequest req = new HttpRequest();
            req.setEndpoint('https://dummy.restapiexample.com/api/v1/create');
            req.setMethod('POST');
            req.setBody(tempdetails);
            HttpResponse res = new HttpResponse();
            res = http.send(req);
            if(res.getStatusCode() == 200){
                system.debug('response-->'+res);
                system.debug('response body -->'+res.getBody());
                resResult = String.valueOf(res.getBody());
            }   
        } catch(exception e){
            system.debug('Exception Occured -->'+ e);
        }
       return resResult;         
    }
    
}