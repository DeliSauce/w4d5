class SubsController < ApplicationController
before_action :check_login, except: [:index, :show]
before_action :require_user_owns_sub!, only: [:edit, :update]

  def index
    @subs = Sub.all
    render :index
  end

  def show
    @sub = Sub.find_by(id: params[:id])
    render :show
  end

  def new
    @sub = Sub.new
    render :new
  end

  def create
    # @sub = current_user.subs.new(sub_params)
    @sub = Sub.new(sub_params)
    @sub.moderator_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find_by(id: params[:id])
    render :edit
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to @sub
    else
      flash.now[:errors] = @sub.errors.full_messages
      render :edit
    end
  end

  private
  def sub_params
    params.require(:sub).permit(:name, :description)
  end

  def require_user_owns_sub!
    sub = Sub.find_by(id: params[:id])
    unless sub.moderator_id == current_user.id
      flash[:errors] = ["Must be moderator to edit"]
      redirect_to subs_url
    end
  end


end
