trigger ContactTrigger on Contact(before update, before insert, after insert, after delete, after update) {
    if (Trigger.isBefore) {
        if (Trigger.isUpdate) {
            ContactTriggerHandler.beforeUpdate(Trigger.new, Trigger.oldMap);
    }

        if (Trigger.isInsert) {
            ContactTriggerHandler.beforeInsert(Trigger.new);
        }
}
    if (Trigger.isAfter) {
        if (Trigger.isInsert){
            ContactTriggerHandler.afterInsert(Trigger.new);
        }

        if (Trigger.isDelete) {
            ContactTriggerHandler.afterDelete(Trigger.old);
        }

        if (Trigger.isUpdate) {
            ContactTriggerHandler.afterUpdate(Trigger.new, Trigger.oldMap);
        }
    }
}