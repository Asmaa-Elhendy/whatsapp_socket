class ChatModel{
  int id;
  String name;
  String icon;
  String time;
  bool isgroup;
  String current_message;
  String status;
  bool selected_contact;
  ChatModel({ this.id=0, this.name='', this.icon='', this.time='', this.isgroup=false, this.current_message='',this.status='',this.selected_contact=false});
}