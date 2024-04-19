class BlogPostsController < ApplicationController
  before_action :set_before_action_blog_post, only: %i[show edit update destroy]
  before_action :authenticate_user!, except: %i[index show]

  def index
    @blog_posts = BlogPost.all
  end

  def new
    @blog_post = BlogPost.new
  end

  def show; end

  def create
    @blog_post = BlogPost.new(blog_post_params)
    if @blog_post.valid?
      @blog_post.save
      flash[:notice] = 'Blog Post Sucess Input'
      redirect_to blog_post_path(@blog_post.id)
    else
      flash[:notice] = 'Blog Post input error'
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Record not found'
    redirect_to root_path
  end

  def update
    if @blog_post.update(blog_post_params)
      redirect_to @blog_post
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @blog_post.destroy
    redirect_to root_path
  end

  private

  def blog_post_params
    params.require(:blog_post).permit(:title, :body)
  end

  def set_before_action_blog_post
    @blog_post = BlogPost.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    flash[:notice] = 'Record not found'
    redirect_to root_path
  end
end
