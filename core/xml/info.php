<?php
	
	$xml = new SimpleXMLElement('./info.xml', null, true);
	
	$oriX = ( !empty($_GET['x']) )? $_GET['x']:0;
	$oriY = ( !empty($_GET['y']) )? $_GET['y']:0;
	
	function my_case_cmp($l1, $l2) {
		
		global $oriX;
		global $oriY;
		
		$p1 = ( abs((int) $l1['x'] - $oriX ) ) + ( abs((int) $l1['y'] - $oriY ) );
		$p2 = ( abs((int) $l2['x'] - $oriX ) ) + ( abs((int) $l2['y'] - $oriY ) );
		
		if ($p1 == $p2) return 0;
		else return $p1 < $p2 ? -1 : 1;
	}
	
	$cases = $xml->xpath('//cas');
	usort($cases, 'my_case_cmp');
	
	$chaine = '<alphabounceinfo>';
	for ($i = 0, $leng = count($cases) ; $i < $leng ; $i ++) $chaine .= $cases[$i]->asXML();
	$chaine .= '</alphabounceinfo>';
	
	$info = new SimpleXMLElement( $chaine );
	
	header ("content-type: text/xml");
	echo $info->asXML();
	
?>