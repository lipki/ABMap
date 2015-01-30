



$(function(){
	
	point_a = [0, 0];
	load = true;
	
	// gestion des messages
	$(".message").mousedown(function(){
		$(this).toggle();
	});
	$(".btn_aide").mousedown(function(){
		$(".message")
			.filter(".aide")
			.toggle();
	});
	$(".btn_screen").mousedown(function(){
		$(".message")
			.filter(".screen")
			.toggle();
	});
	
	// bouton missions
	$("#tab li").mousedown(function(){
		$("div.tab").toggle();
		$("#tab li").attr('class', 'off');
		$(this).attr('class', 'on');
	});
	
	// afficher les calques
	$("li").mousedown(function(){
		$("."+$(this).attr("class"))
			.filter(".calque")
			.toggle();
		$("."+$(this).attr("class"))
			.filter(".case")
			.toggle();
	});
	
	// position de la souris
	$('#content')
		.mouseover(function(){
			$("#bulle").css('display', 'block');
		})
		.mouseout(function(){
			$("#bulle").css('display', 'none');
		});
	
	function getCase (e) {
		if (navigator.appName!="Microsoft Internet Explorer") {
			diffx = e.pageX - ( (window.innerWidth - 200)/2 +200 );
			diffy = e.pageY - Math.floor((window.innerHeight)/2);
		} else {
			diffx = (event.x+document.documentElement.scrollLeft + 200) - ( (document.body.clientWidth - 200)/2 +200 );
			diffy = (event.y+document.documentElement.scrollTop) - Math.floor((document.body.clientHeight)/2);
		}
		
		point = new Array();
		point.push(Math.floor((diffx-11)/20+1)+point_a[0]);
		point.push(Math.floor((diffy-8)/18+1)+point_a[1]);
		
		if(!load) $("#bulle span").html('Position : ['+point[0]+']['+point[1]+']');
		if(!load && $("#bulle .load").css('display') != 'none') $("#bulle .load").css('display', 'none');
		
		if (navigator.appName!="Microsoft Internet Explorer") {
			$("#bulle").css('top', e.pageY);
			$("#bulle").css('left', e.pageX+30);
		} else {
			$("#bulle").css('top', event.y+document.documentElement.scrollTop );
			$("#bulle").css('left', event.x+document.documentElement.scrollLeft + 230 );
		}
	}
	document.onmousemove = getCase;
	
	// déplacement initiale
	function deplace(x, y) {
		point_a = [x, y];
		$(".calque")
			.not(".fixe")
			.not(".centrecase")
			.animate({
				top: y*-18, left: x*-20
			}, "slow");
		$(".centre span").html('['+x+']['+y+']');
		window.location.replace('./#'+x+','+y);
	}
	
	function QueryString(param){
		if(window.location.hash.indexOf(',') != -1) {
			position = window.location.hash.split('#');
			position = position[1].split(',');
			return (param == 'x')? position[0]:position[1];
		} else return 0;
	}
	
	if(window.location.hash == '#screen') $(".message").filter(".screen").toggle();
	else deplace(Number(QueryString('x')), Number(QueryString('y')));
	
	// déplacement numérique
	$("input.go").mousedown(function(){
		deplace(Number($("input.x").val()), Number($("input.y").val()));
	});
	
	// déplacement a la souris
	$("#carte").mousedown(function(){
		deplace(Number(point[0]), Number(point[1]));
	});
	
	// chargement du xml
	$.get("./core/xml/index.xml", function(xml){
		
		posCases($(xml).find('case'))
		posMissions($(xml).find('mission'))
		
		load = false;
		
	});
	
	// placement des cases
	function posCases(list) {
		
		list.each(function(i){
			$('.cases .centrecase').append('<div id="case_'+i+'" class="'+$(list[i]).attr('type')+' case" style="top: '+($(list[i]).attr('y')*18)+'px; left: '+($(list[i]).attr('x')*20)+'px;"><img src="./core/images/'+$(list[i]).attr('type')+'.png"/></div>');
			$("#bulle").append('<div class="case_'+i+' remarque" style="display:none;"/>');
			if (navigator.appName!="Microsoft Internet Explorer")
				$("#bulle").find('.case_'+i).append($(list[i]).children());
			else	$("#bulle").find('.case_'+i).append($(list[i]).text());
		});
		
		//event
		$('.case')
			.mouseover(function(){
				$("#bulle div."+$(this).attr('id')).css('display', 'block');
			})
			.mouseout(function(){
				$("#bulle div."+$(this).attr('id')).css('display', 'none');
			});
	}
	
	// placement des missions
	function posMissions(list) {
		
		list.each(function(i){
			display = 'none';
			if($(list[i]).attr('cond') == undefined) display = 'block';
			$('#missions').append(
			'<li id="mission_'+$(list[i]).attr('id')+'" class="mission entree" style="display:'+display+';">'+$(list[i]).attr('label')+
				'<input id="check_'+$(list[i]).attr('id')+'" class="check mission_'+$(list[i]).attr('id')+'" type="checkbox"/>'+
			'</li>');
			$("#bulle").append('<div class="mission_'+$(list[i]).attr('id')+' messagemission" style="display: none;">'+
						'<img class="check_'+$(list[i]).attr('id')+' debut" src="./core/images/debut.'+$(list[i]).attr('id')+'.png"/>'+
						'<img class="check_'+$(list[i]).attr('id')+' fin" src="./core/images/fin.'+$(list[i]).attr('id')+'.png" style="display: none;"/>'+
					'</div>');
			/*$(list[i]).find('case').each (function (u) {
				$('.'+$($(list[i])[u]).attr('type')).css('display', display);
				$('.mission:last-child').append('<li class="li_'+$($(list[i])[u]).attr('type')+'" x="'+$($(list[i])[u]).attr('x')+'" y="'+$($(list[i])[u]).attr('y')+'">'+$($(list[i])[u]).attr('label')+'</li>');
				$('.li_'+$($(list[i])[u]).attr('type')).mousedown(function(){
					deplace(Number($(this).attr('x')), Number($(this).attr('y')));
				});
			});*/
		});
		
		
		//event

		$(".check")
			.change( function() {
				if($(this).attr('checked') == true) {
					$('.'+$(this).attr('id')).filter(".debut").css('display', 'none');
					$('.'+$(this).attr('id')).filter(".fin").css('display', 'block');
					
					id = $(this).attr('id');
					list.each(function(i){
						if('check_'+$(this).attr('cond') == id) {
							$('#mission_'+$(this).attr('id')).css('display', 'block');
							/*$(this).find('case').each (function (u) {
								$('.'+$(this).attr('type')).css('display', 'block');
							});*/
						}
					});
					
					/*$(this).find('case').each (function (u) {
						$('.'+$(this).attr('type')).css('display', 'none');
					});*/
					
				} else {
					$('.'+$(this).attr('id')).filter(".debut").css('display', 'block');
					$('.'+$(this).attr('id')).filter(".fin").css('display', 'none');
					
					id = $(this).attr('id');
					list.each(function(i){
						if('check_'+$(this).attr('cond') == id) {
							$('#mission_'+$(this).attr('id')).css('display', 'none');
							$('#check_'+$(this).attr('id')).removeAttr('checked');
							$('#check_'+$(this).attr('id')).change();
							/*$(this).find('case').each (function (u) {
								$('.'+$(this).attr('type')).css('display', 'none');
							});*/
						}
					});
				}
			});
		
		
		$('.mission')
			.mouseover(function(){
				$('.'+$(this).attr('id')).filter(".messagemission").css('display', 'block');
				$('#bulle').css('display', 'block');
				$('#bulle span').css('display', 'none');
			})
			.mouseout(function(){
				$('.'+$(this).attr('id')).filter(".messagemission").css('display', 'none');
				$('#bulle').css('display', 'none');
				$('#bulle span').css('display', 'block');
			});
	}
	
	
	// effacer les éléments de sous quetes
	$("#menu ul ol").add("#menu ul ul").hide()
		.parents("ul").mousedown(function(){
			$(this).children("ol").toogle();
			$(this).children("ul").toogle();
		});
});