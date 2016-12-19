class PostsController < ApplicationController

  before_filter :authenticate_user!, :only => [:new, :edit, :create, :destory]

  def new
    @group = Group.find(params[:group_id])
    @post = Post.new
  end
  def edit
    @group =Group.find(params[:group_id])
    
    @post = Post.find(params[:id])
  end

  def create
    @group = Group.find(params[:group_id])
    @post = Post.new(post_params)
    @post.group = @group
    @post.user = current_user

    if @post.save
      redirect_to group_path(@group)
    else
      render :new
    end
  end
  def destory
    @group =Group.find(params[:group_id])
    @post =Post.find(post_params)
    @post.group = @group
    @post.user = current_user
    @post.destroy
    redirect_to group_path(@group),alert: 'Post deleted'
 end


  private

  def post_params
    params.require(:post).permit(:content)
  end

end
