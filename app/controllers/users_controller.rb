# frozen_string_literal: true

class UsersController < ApplicationController
  def index
    @total_users = User.count
    @users = if params[:search_term].present?
               User.where("name ->> 'first' ILIKE ? OR name ->> 'last' ILIKE ? ", "%#{params[:search_term]}%",
                          "%#{params[:search_term]}%")
                   .select("
          CONCAT(name ->> 'title', ' ', name->> 'first', ' ', name->> 'last') as full_name,
          users.*
        ")
             else
               User.select("
          CONCAT(name ->> 'title', ' ', name->> 'first', ' ', name->> 'last') as full_name,
          users.*
        ")
             end
  end

  def destroy
    @user = User.find(params[:id]) # Assuming user ID is passed in the request
    @user.destroy

    redirect_to users_path, notice: 'User deleted successfully!'
  end

  def find_user
    @user = User.where("
        name ->> 'first' ILIKE ?
        OR name ->> 'last' ILIKE ?
      ", params[:search_keyword], params[:search_keyword])
  end
end
