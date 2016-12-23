public with sharing class AutoCompleteController {
    
    // Instance fields
    public String searchTerm {get; set;}
    public String selectedMovie {get; set;}
    
    // JS Remoting action called when searching for a movie name
    @RemoteAction
    public static List<Contact> searchMovie(String searchTerm) {
        System.debug('Movie Name is: '+searchTerm );
        List<Contact> movies = Database.query('Select Id, Name from Contact where name like \'%' + String.escapeSingleQuotes(searchTerm) + '%\'');
        return movies;
    }
}