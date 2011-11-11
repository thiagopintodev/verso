// This is a manifest file that'll be compiled into including all the files listed below.
// Add new JavaScript/Coffee code in separate files in this directory and they'll automatically
// be included in the compiled file accessible from http://example.com/assets/application.js
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
//= require jquery
//= require jquery-ui
//= require jquery_ujs
//= require cufon/cufon-yui.js
//= require cufon/Wook_Bold.font.js
//= require cufon/Wook_Regular.font.js
//= require_directory .

Cufon.replace('h1,h2,h3,caption,button,div#title,div#slider a span', { fontFamily: 'Wook Bold' });
Cufon.replace('ul#siteNav > li > a, ul#pageTabs > li > a', { fontFamily: 'Wook Regular', hover: true });
Cufon.replace('p.intro, .c', { fontFamily: 'Wook Regular' });
