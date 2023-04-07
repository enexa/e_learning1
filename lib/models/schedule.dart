    class Task{
      int? id;
      String ?title;
      String? note;
      String ?date;
   int? iscompleted;
      String? repeat;
      String? startTime;
      String ?endTime;
      int? remind;
      int ?color;
      Task({
         this.id,
         this.iscompleted,
         this.title,
         this.note,
        this.date,
       this.repeat,
   this.startTime,
    this.endTime,
  this.remind,
         this.color,
        
      });
      Task.fromJSON(Map<String,dynamic> json){
        id=json['id'];
        title=json['title'];
        note=json['note'];
        date=json['date'];
        iscompleted=json['iscompleted'];
        repeat=json['repeat'];
        startTime=json['startTime'];
        endTime=json['endTime'];
        remind=json['remind'];
        color=json['color'];

      }
      
      Map<String,dynamic>toJson(){
        final Map<String,dynamic> data=<String,dynamic>{};
        data['id']=id;
        data['title']=title;
        data['note']=note;
        data['date']=date;
        data['iscompleted']=iscompleted;
        data['repeat']=repeat;
        data['startTime']=startTime;
        data['endTime']=endTime;
        data['remind']=remind;
        data['color']=color;
        return data;

      }

    
    }