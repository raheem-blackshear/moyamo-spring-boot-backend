var Moyamo = Moyamo || {};

//console.log = function() {}

Moyamo.expertGroup = {
	map : new Array(),
	
	template : function(data){
		var result = "<div class='badge border-right-success border-left-success badge-striped'><i class='la font-medium-2'></i><span style='bottom: 0px;'>#{data}</span></div>";
		result = result.replace("#{data}", data);
		return result;
	},
	
	init : function(){
		if(this.map.length){
			return;
		}

		this.map["all"] = "전체";
		this.map["normal"] = "일반";
		this.map["name"] = "이름";
		this.map["clinic"] = "클리닉";
		this.map["contents"] = "컨텐츠";
	},
	
	view : function(data) {
		var result = "";
		
		if(!Array.isArray(data)){
			return this.template(this.map[data]);
		}
		
		for(var type in data){
			result += this.template(this.map[type])+"<br>";
		}
		
		return result;
	}
};


(function(){
	Moyamo.expertGroup.init();
})();