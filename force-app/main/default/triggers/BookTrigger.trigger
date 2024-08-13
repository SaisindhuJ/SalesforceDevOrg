trigger BookTrigger on Book__C (before insert) {
    List<Book__C> books = new List<Book__C>();
    books = Trigger.new;
    BookTriggerHandler.applyDiscount(books);
}