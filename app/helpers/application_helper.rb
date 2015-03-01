module ApplicationHelper

	def flash_class(type)
		case type
		when :alert
			"status-red"
		when :notice
			"status-green"
		else
			"status-blue"
		end
	end
end
