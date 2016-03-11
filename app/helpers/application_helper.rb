module ApplicationHelper
	def payola_can_modify_subscription?(subscription)
  	subscription.owner == current_user
	end
end
