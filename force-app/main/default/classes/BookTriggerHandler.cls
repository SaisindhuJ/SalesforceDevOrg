public class BookTriggerHandler {
    public static void applyDiscount(List<Book__C> books){
        for(Book__C b : books){
            b.price__c *= 0.9;
        }
    }
}