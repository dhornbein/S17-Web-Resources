#!/bin/bash

set -eu

gitPath="https://raw.github.com/dhornbein/S17-Web-Resources/master/"
gitPathURL="https%3A%2F%2Fraw.github.com%2Fdhornbein%2FS17-Web-Resources%2Fmaster%2F"
shareMessage="September 15-17, 2012 New York City"
shareSummery="There is a grand convergence happening September 15-17th in New York City. Show wall street how you feel. More information at s17nyc.org"

echo '
<script type="text/javascript">
function SelectAll(id)
{
    document.getElementById(id).focus();
    document.getElementById(id).select();
}
</script>
<style type="text/css">
table {width:100%;}
td {border: 1px solid #ddd;margin:0;padding:0;}
.res_name {}
.res_embed { vertical-align: top; }
.res_embed textarea {width:98%; height:80px; margin:0; }
.res_image {}
.res_image img {max-width:100%; }
.res_link {}
.res_link input {width:98%;}
.res_bottom td {border-bottom-width:10px;}
tr:hover td {border-color:#3A8E8E;}
tr:hover .res_image {background-color:#AAA;}
tr:hover + tr.res_bottom td {border-color:#3A8E8E;}
tr:hover + tr.res_bottom .res_name {color:#3A8E8E;}
</style></head><body>'
echo '<table><thead><tr><th>Share</th><th>Image (right click to save)</th></tr></thead>'

i=1

for f in web*/*; do
		i=`expr $i + 1`
    filename=`basename "$f" '.png'`

    size=`identify -format '%wx%h' "$f"`;

    shareURL="$(echo "$gitPathURL$f" | sed 's/\//%2F/g')"

    facebook="<a title='share this on Facebook' href='http://www.facebook.com/sharer.php?s=100&p[url]=$shareURL&p[images][0]=$shareURL&p[title]=$shareMessage&p[summary]=$shareSummery'target='_blank'><img src='http://interoccupy.net/wp-content/uploads/2012/07/1342377856_facebook-icon.png' alt='Share on Facebook' /></a>"
    twitter="<a href='https://twitter.com/intent/tweet?url=$shareURL&via=occupywallstNYC&text=check out this awesome graphic&hashtags=s17,ows,s17nyc&related=occupywallstNYC,occupywallst' target='_blank' title='share via Twitter'><img src='https://dev.twitter.com/sites/default/files/images_documentation/bird_blue_16.png' alt='Twitter'></a>"
    google="<a href='https://plus.google.com/share?url=$shareURL' target='_blank' title='share on Google+'><img src='https://www.gstatic.com/images/icons/gplus-16.png' alt='Google+'/></a>"

    embed="<small>$facebook $twitter $google<br>Embed code:</small><textarea id='res_textarea_$i' onClick='SelectAll(\"res_textarea_$i\")' readonly=readonly><a href='http://s17nyc.org/#embed' target='_blank'><img src='$gitPath$f' border='0' /></a></textarea>"
    link="<input id='res_input_$i' onClick='SelectAll(\"res_input_$i\")' readonly=readonly type='text' value='$gitPath$f' title='Direct link to image'>"

    echo "<tr>
	    <td class='res_embed'>$embed</td>
	    <td class='res_image'><a href='$gitPath$f' target='_blank'><img src='$gitPath$f'></a></td>
    </tr>"
    echo "<tr class='res_bottom'>
	    <td class='res_name'>$filename - $size</td>
    	<td class='res_link'>$link</td>
    </tr>"
done

echo '</table>'