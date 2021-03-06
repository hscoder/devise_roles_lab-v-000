class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post!, only: [:edit, :update]
  before_action :authorize_user!, only: [:edit, :update]

  def show
  end

  def create
    user_id = current_user.id
    Post.create(content: params[:post][:content], user_id: user_id)
    redirect_to user_path(id: user_id)
  end

  def update
    @post.update!(content: params[:post][:content])
    redirect_to post_path, id: @post.id
  end

  def edit
  end

  private

  def find_post!
    @post = Post.find(params[:id])
  end

  def authorize_user!
    raise 'You are unauthorized to complete this action' unless current_user
    unless current_user == @post.user || current_user
      redirect_to post_path, id: @post.id, alert: 'You are unauthorized to complete this action'
    end
  end
end
