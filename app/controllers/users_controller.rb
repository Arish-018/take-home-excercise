# frozen_string_literal: true

# controllers/users_controller
class UsersController < ApplicationController
  before_action :authenticate_user!, :authorize_admin
  before_action :set_user, only: %i[show edit update destroy]
  before_action :initialize_user, only: %i[create]

  # GET /users
  # GET /users.json
  def index
    @users = User.all_non_admin_users

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @user }
    end
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  # POST /users.json
  def create
    respond_to do |format|
      if @user.save
        format.html do
          redirect_to @user,
                      notice: 'User account successfully created.
                               A password reset email has been sent
                               to the user.'
        end
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  def initialize_user
    @user = User.new(user_params)
    @user.password = @user.friendly_password
    @user.password_confirmation = @user.password
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update_attributes(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user)
          .permit(:email, :password,
                  :password_confirmation, :full_name,
                  :phone_number, :company_name,
                  :company_address)
  end
end
