class RecommendBeans{
  List<RecommendBean> list;

  RecommendBeans(this.list);

}

class RecommendBean {
  int id;
  String title;
  String briefIntro;

  RecommendBean(this.id, this.title, this.briefIntro);

  factory RecommendBean.fromJson(Map<String, dynamic> json) {
    return RecommendBean(json["id"],json["title"],json["briefIntro"]);
  }

  String toString(){
    return "id = $id ,title = $title , briefIntro = $briefIntro";
  }
}