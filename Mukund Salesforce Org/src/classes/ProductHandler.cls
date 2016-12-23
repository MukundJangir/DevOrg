public class ProductHandler extends TriggerHandler{

	Product2[] productList = Trigger.new;
	
	override public void beforeInsert(){
		system.debug('Note before called');
		
		system.debug('beforeInsertNote called');
        for(Product2 note:productList){
            system.debug('INsert note Id = '+note.id);
        }
	}
	
	override public void beforeUpdate(){
		List<Id> idList = new List<Id>();
        for(Product2 note:productList){
            system.debug('update note Id = '+note.id);
        }
       // updateCandidate(idList);
		
	}
}