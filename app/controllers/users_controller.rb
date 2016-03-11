class UsersController < ApplicationController
  include Payola::StatusBehavior
  before_action :authenticate_user!
  # before_action :admin_only, :except => :show

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    unless current_user.admin?
      unless @user == current_user
        redirect_to :back, :alert => "Access denied."
      end
    end
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(secure_params)
      redirect_to users_path, :notice => "User updated."
    else
      redirect_to users_path, :alert => "Unable to update user."
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy
    redirect_to users_path, :notice => "User deleted."
  end

  def dashboard
    @menu_id = 0
  end

  def subscription
    @menu_id = 1
  end

  def promo
    @menu_id = 2
  end

  def delivery
    @menu_id = 3
  end

  def settings
    @menu_id = 4
    @user = current_user
    @subscription = Payola::Subscription.find_by!(owner_id: current_user.id)
  end

  def update_email
    if current_user.update_attributes(email: params[:user][:email])
      flash[:notice] = "Email updated."
    else
      flash[:alert] = 'Unable to update email.'
    end

    redirect_to :settings
  end

  def update_name
    if current_user.update_attributes(name: params[:user][:name])
      flash[:notice] = "Name updated."
    else
      flash[:alert] = 'Unable to update name.'
    end

    redirect_to :settings
  end
  
  private

  def admin_only
    unless current_user.admin?
      redirect_to :back, :alert => "Access denied."
    end
  end

  def secure_params
    params.require(:user).permit(:role)
  end

end
