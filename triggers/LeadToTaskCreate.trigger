trigger LeadToTaskCreate on Lead(After insert, after update, after delete)
{
        List<Task> task=new list<Task>();
        set<id>setid= new set<id>();

    if(trigger.isinsert || trigger.isupdate){
        for(Lead l: trigger.new) {
          setid.add(l.Id );
        }
    }
   for(Lead led : trigger.new )
    {
        //Lead OldLead = Trigger.oldMap.get(led.id);
          for(integer i = 1 ; i <= led.NumberOfTask__c ; i++ )
          {
            Task ta = new Task();
            ta.WhoId = led.Id;
            ta.Subject = 'lead task';
            ta.Status = 'Not Started';
            ta.Priority = 'Normal';
            ta.ActivityDate = date.today();
            system.debug(' task ' + ta);
            task.add(ta);
           }
        insert task;    
    }
    if(trigger.isupdate)
        {
            list<task> taskList =[select WhoId, Id from Task where WhoId IN:Trigger.oldMap.keyset()];
            if(tasklist.size()>0)
            delete tasklist;
            List<Task> task_upd=new list<Task>();
            set<id>setid= new set<id>();
            for(Lead led_upd : trigger.new)
            {
                system.debug('NumberofTaks'+led_upd.NumberOfTask__c);
            for(integer i = 1 ; i <= led_upd.NumberOfTask__c ; i++ )
                {
                    system.debug('In For Loop'+i);
                    Task ta = new Task();
                    ta.WhoId = led_upd.Id;
                    ta.Subject = 'lead task';
                    ta.Status = 'Not Started';
                    ta.Priority = 'Normal';
                    ta.ActivityDate = date.today();
                    system.debug(' task '  + ta);
                    task_upd.add(ta);
                }
                insert task_upd;  
            }
                
        }
}