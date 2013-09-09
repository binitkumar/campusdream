/*
	ZeroFour 2.0 by HTML5 UP
	html5up.net | @n33co
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
*/

window._skel_config = {
	preset: 'standard',
	prefix: '/assets/style',
	resetCSS: true,
	breakpoints: {
		'desktop': {
			grid: {
				gutters: 50
			}
		},
		'1000px': {
			grid: {
				gutters: 35
			}
		}
	}
};

window._skel_panels_config = {
	preset: 'standard'
};

function ready(){
    $('#nav > ul').dropotron({
        offsetY: -22,
        mode: 'fade',
        noOpenerFade: true,
        speed: 300,
        detach: false
    });

    $("#sign_in").click(function(){$("#new_user").submit();});
    $("#edit_profile").click(function(){$("#edit_user").submit();});

    (function(d, s, id) {
        var js, fjs = d.getElementsByTagName(s)[0];
        if (d.getElementById(id)) return;
        js = d.createElement(s); js.id = id;
        js.src = "//connect.facebook.net/en_US/all.js#xfbml=1&appId=180726242006939";
        fjs.parentNode.insertBefore(js, fjs);
    }(document, 'script', 'facebook-jssdk'));
}
$(document).ready(ready);
$(document).on('page:load',ready);