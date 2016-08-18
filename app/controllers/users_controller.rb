class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :require_same_user,only:[:edit, :update]
  # GET /users
  def index
    @users = User.paginate(page: params[:page],per_page:5)
  end

  # GET /users/1
  def show
    @user_articles = @user.articles.paginate(page: params[:page],per_page:5)
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "welcome to blog #{@user.username}"
      redirect_to articles_path
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      flash[:success] = "your account was updated successfully"
      redirect_to articles_path
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to users_url, notice: 'User was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def user_params
      params.require(:user).permit(:username, :email,:password)
    end

    def require_same_user
      if !logged_in? || current_user != @user
        flash[:danger] = "you are only edit or delete your own account"
        redirect_to root_path
      end
    end
end
