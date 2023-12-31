# UsersController
class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      flash[:success] = 'User created successfully.'
      redirect_to @user
    else
      flash[:error] = 'There was a problem creating the user.'
      render 'new', status: :unprocessable_entity
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:notice] = 'User has been updated'
      redirect_to @user
    else
      flash[:error] = 'User could not be updated'
      render 'edit', status: :unprocessable_entity
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to '/'
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end
end
