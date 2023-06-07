// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails

import "@hotwired/turbo-rails"
import "controllers"
import "jquery"
import "semantic-ui"


$(document).on('turbo:load', function () {
    $('.ui.dropdown').dropdown();
		$('.ui.accordion').accordion();
		$('#js-sidebar').click(function() {
			$('.ui.sidebar').sidebar('toggle');
		});

})

