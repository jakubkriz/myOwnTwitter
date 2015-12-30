# self-explanatory
class PostsController < ApplicationController
  before_action :set_post, only: [:edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @tags = sort_tags(Tag.all).reverse
    @posts = sort_posts(Post.all).reverse
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  def filter
    @posts = sort_posts(Post.tagged_with(params[:tag_name])).reverse
    @tags = sort_tags(Tag.all).reverse

    render :index
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    respond_to do |format|
      if @post.save
        format.html { redirect_to root_path, notice: 'Post was created.' }
        format.json { render :index, status: :created }
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to root_path, notice: 'Post was updated.' }
        format.json { render :index, status: :ok }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    @tags = Tag.all
    @tags.each do |tag|
      tag.destroy if tag.posts.empty?
    end
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was deleted.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_post
    @post = Post.find(params[:id])
  end

  # Never trust params from the Internet, only allow the white list through.
  def post_params
    params.require(:post).permit(:author, :title, :body, :tags_string)
  end

  def sort_tags(tags)
    tags.sort_by do |tag|
      tag.posts.count
    end
  end

  def sort_posts(posts)
    posts.sort_by(&:updated_at)
  end
end
