# -*- encoding : utf-8 -*-
# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
TestM::Application.initialize!

WillPaginate::ViewHelpers.pagination_options[:previous_label] = '<< Предыдущая'
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'Следующая >>'

Time::DATE_FORMATS[:dr] = "%d.%m.%Y"