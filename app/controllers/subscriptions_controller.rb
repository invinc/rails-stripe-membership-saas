class SubscriptionsController < ApplicationController
	# bring in the `render_payola_status` helper.
  include Payola::StatusBehavior
  before_action :authenticate_subscription!

	def update_card
		Payola::UpdateCard.call(@subscription, params[:stripeToken])
		redirect_to settings_path, :notice => "Card updated."
	end

	private

	def authenticate_subscription!
		@subscription = Payola::Subscription.find_by_guid(params[:subscription_id])
		if @subscription.nil? or payola_can_modify_subscription?(@subscription)==false
			redirect_to settings_path, :alert => "Access denied on Subscription."
		end
	end
end