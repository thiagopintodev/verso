var site_url = '/';
var twitter_name = 'chrismahon';
var ie7 = (document.all && !window.opera && window.XMLHttpRequest);
var overlay_colour = '#FFF';
var overlay_opacity = .8;

$(function() {

	/* FORMS ---------------------------------------------------------*/

		$('textarea.hint, input.hint').hint();

	/* NAV ---------------------------------------------------------*/
	
		$('ul#siteNav > li').mouseenter(function(){
		
			$(this).addClass('hover');
		
			// check width	
			var $ul = $(this).find('ul');
			var $link = $(this).find('a:first');
			
			// if link is wider make the list the same width
			if( $ul.width() < $link.outerWidth() ) {
				$ul.width( $link.outerWidth() );
			}
			
			// ie7 nonsense
			if(ie7) { $ul.find('li').width( $ul.outerWidth() ) };
			
		}).mouseleave(function(){
		
			$(this).removeClass('hover');
			Cufon.refresh();
			
		});

});

$.fn.hint = function() {
	return this.each(function(){
		var t = $(this); // get jQuery version of 'this'
		var title = t.attr('title'); // get it once since it won't change
		
		if (title) { // only apply logic if the element has the attribute
			
			// on focus, set value to blank if current value matches title attr
			t.focus(function(){
				if (t.val() == title) {
					t.val('');
					t.addClass('blur');
				}
			})

			// on blur, set value to title attr if text is blank
			t.blur(function(){
				if (t.val() == '') {
					t.val(title);
					t.removeClass('blur');
				}
			})

			// now change all inputs to title
			t.blur();
		}
	})
}
