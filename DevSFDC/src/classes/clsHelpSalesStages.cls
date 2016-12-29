public class clsHelpSalesStages{
    public List<OpportunityStage> getSalesStages(){
      List<OpportunityStage> lstOppStage = [ SELECT MasterLabel, 
                           IsClosed,
                           IsWon, 
                           ForecastCategory, 
                           ForecastCategoryName, 
                           DefaultProbability, 
                           Description
                    FROM OpportunityStage
                    WHERE IsActive = true
                    ORDER BY SortOrder ASC ];
    return lstOppStage;
    }
  
    
}