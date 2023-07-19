// 이미지 실패시 기본이미지
function getImage(url, defaultImg) {
	var ret;
	if (url == "" || url == null || (typeof (url) == 'undefined')) {
		ret = '/static/img/' + defaultImg;
	} else {
		ret = url;
	}
	return ret;
}

// 현재시간기준 몇분전처리
function timeBefore(strDate) {
	// 현재시간
	if (typeof strDate == 'undefined' || strDate == 'undefined') {
		return "조금전"
	}
	var now = new Date();
	// 기준시간
	var writeDay = new Date(strDate);
	var minus;
	var time = '';
	if (now.getFullYear() > writeDay.getFullYear()) {
		minus = now.getFullYear() - writeDay.getFullYear();
		time += minus + "년전 ";
		return time;
	}
	if (now.getMonth() > writeDay.getMonth()) {
		minus = now.getMonth() - writeDay.getMonth();
		time += minus + "달전";
		return time;
	}
	if (now.getDate() > writeDay.getDate()) {
		minus = now.getDate() - writeDay.getDate();
		time += minus + "일전";
		return time;
	}

	if (now.getHours() > writeDay.getHours()) {
		minus = now.getHours() - writeDay.getHours();
		time += minus + "시간전";
		return time;
	}

	if (now.getMinutes() > writeDay.getMinutes()) {
		minus = now.getMinutes() - writeDay.getMinutes();
		time += minus + "분전";
		return time;
	}

	if (now.getSeconds() > writeDay.getSeconds()) {
		minus = now.getSeconds() - writeDay.getSeconds();
		time += minus + "초전";
		return time;
	}

	return "조금전";
}

function checkCustomTag(source) {
	var DOMHolderArray = new Array();
	var tagsArray = new Array();
	var lines = source.split('\n');
	for (var x = 0; x < lines.length; x++) {
		var tagsArray = lines[x]
				.match(/<(\/{1})?\w+((\s+\w+(\s*=\s*(?:".*?"|'.*?'|[^'">\s]+))?)+\s*|\s*)>/g);
		if (tagsArray) {
			for (var i = 0; i < tagsArray.length; i++) {
				if (tagsArray[i].indexOf('</') >= 0) {
					elementToPop = tagsArray[i].substr(2,
							tagsArray[i].length - 3);
					elementToPop = elementToPop.replace(/ /g, '');
					for (var j = DOMHolderArray.length - 1; j >= 0; j--) {
						if (DOMHolderArray[j].element == elementToPop) {
							DOMHolderArray.splice(j, 1);
							if (elementToPop != 'html') {
								break;
							}
						}
					}
				} else {
					var tag = new Object();
					tag.full = tagsArray[i];
					tag.line = x + 1;
					if (tag.full.indexOf(' ') > 0) {
						tag.element = tag.full.substr(1,
								tag.full.indexOf(' ') - 1);
					} else {
						tag.element = tag.full.substr(1, tag.full.length - 2);
					}
					var selfClosingTags = new Array('area', 'base', 'br',
							'col', 'command', 'embed', 'hr', 'img', 'input',
							'keygen', 'link', 'meta', 'param', 'source',
							'track', 'wbr');
					var isSelfClosing = false;
					for (var y = 0; y < selfClosingTags.length; y++) {
						if (selfClosingTags[y].localeCompare(tag.element) == 0) {
							isSelfClosing = true;
						}
					}
					if (isSelfClosing == false) {
						DOMHolderArray.push(tag);
					}
				}

			}
		}
	}

	if (DOMHolderArray.length == 0) {
		return true;
	} else {
		return false
	}
}

function doRestApi(target, action, callback){
	var form = $(target)[0];
    var data = new FormData(form);
    if(!action){
   	 	action = $(target).attr('action');
    }

	$.ajax({
        type: "POST",
        enctype: 'multipart/form-data',
        url: action,
        data: data,
        processData: false,
        contentType: false,
        cache: false,
        timeout: 600000,
        success: function (data) {
        	//$('#post-magazine').find('a').click();

            if(data.resultCode && data.resultCode == 9000) {
                alert(data.resultMsg);
                return;
            }
        	setTimeout(function() {
        	     $('.modal').modal('hide');
        	     $('.zero-configuration').DataTable().ajax.reload(null, false);

				if(typeof callback == 'function') {
					callback();
				}
    	    }, 500);

        },
        error: function (e) {
        	alert('실패');
            console.log(e);
        }
    });
}

function setMenuName(title){
	console.log('menuName : ' + title);
	$('#menuName').text(title);

}
