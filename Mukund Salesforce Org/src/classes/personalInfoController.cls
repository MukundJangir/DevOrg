public class personalInfoController {

    public String name { get; set;}
    public String address { get; set;}
    public String state { get; set;}
    public String country { get; set;}
    public String city { get; set;}
    public String email{ get; set;}
    public Integer pincode { get; set;}
    public String telephone {get; set;}
    public Integer fax {get; set;}
    public boolean female_sex {get; set;}
    public boolean male_sex {get; set;}
    
    
    public PageReference save() {
    
    Personal_Info__c personal_info = new Personal_Info__c();
    personal_info.Address__c = address;
    personal_info.City__c = city;
    personal_info.Country__c = country;
    personal_info.Email__c = email;
    personal_info.Fax__c = fax;
    personal_info.Male_sex__c = male_sex;
    personal_info.Female_sex__c = female_sex;
    personal_info.name__c = name;
    personal_info.Pin_Code__c = pincode;
    personal_info.State__c = state;
    personal_info.Telephone__c = telephone;
    
    
    insert personal_info ;
        return null;
    }

}