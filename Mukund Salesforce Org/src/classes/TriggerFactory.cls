/**
 * @author      Capgemini India {Balmukund Jangir}
 * @date        06/04/2013
 * @description Used to instantiate and execute Trigger Handlers associated with sObjects.
 **/
public class TriggerFactory {
    /**
     * Public static method to create and execute a trigger handler
     *
     * Arguments:   Schema.sObjectType soType - Object type to process (SObject.sObjectType)
     *
     * Throws a TriggerException if no handler has been coded.
     */
    public static void createHandler(Schema.sObjectType soType)
    {
        // Get a handler appropriate to the object being processed
        TriggerHandler handler = getHandler(soType);
        
        // Make sure we have a handler registered, new handlers must be registered in the getHandler method.
        if (handler == null)
        {
            throw new TriggerException('No Trigger Handler registered for Object Type: ' + soType);
            
        }
        
        // Execute the handler to fulfil the trigger
        execute(handler);
    }
    
    /**
     * private static method to control the execution of the handler
     *
     * Arguments:   ITrigger handler - A Trigger Handler to execute
     */ 
    private static void execute(TriggerHandler handler) {
        // Before Trigger
        if (Trigger.isBefore) {
            
            if (Trigger.isDelete) {
                handler.beforeDelete();
            }
            else if (Trigger.isInsert) {
                handler.beforeInsert();
            }
            else if (Trigger.isUpdate) {
                handler.beforeUpdate();
            }
            
        } else {
            
            if (Trigger.isDelete) {
                handler.afterDelete();
            }
            else if (Trigger.isInsert) {
                handler.afterInsert();
            }
            else if (Trigger.isUpdate) {
                handler.afterUpdate();
            }
        }
        
        // Perform any post processing in Async mode, methods to use @future
        //handler.processAsync();
    }
    
    /**
     * private static method to get the appropriate handler for the object type.
     * Modify this method to add any additional handlers.
     *
     * Arguments:   Schema.sObjectType soType - Object type tolocate (SObject.sObjectType)
     *
     * Returns:     ITrigger - A trigger handler if one exists or null.
     */
    private static TriggerHandler getHandler(Schema.sObjectType soType)
    {
        if (soType == Opportunity.sObjectType)
        {
           // return new OpportunityHandler();
        }
        else if (soType == Account.sObjectType) 
        {
            //return new CBPAlerts();
        }       
        else if (soType == Contact.sObjectType) 
        {
            //return new ContactHandler();
        } 
        else if (soType == Note.sObjectType) 
        {
            return new NotesHandler();
        }     
        else if (soType == Attachment.sObjectType) 
        {
            return new AttachmentHandler();
        }
         else if (soType == Event.sObjectType) 
        {
            return new EventHandler();
        }  
       return null;  
    }
}