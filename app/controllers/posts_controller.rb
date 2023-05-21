class PostsController < ApplicationController
    before_action :authenticate_user!

    def index
        @feeds = Post.where(user_id: [current_user,
             *current_user.following_ids ]).order(created_at: :desc)

    end

    def new
        @post = Post.new
    end

    def create
        @user = current_user
        @post = @user.posts.new(post_params)
        p @post
        if @post.save
            flash[:notice] = "投稿に成功しました"
            redirect_to user_path(@user)
        else
            render :new, status: :unprocessable_entity
        end
    end
    
    def edit 
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        @user = current_user
        if @post.update(post_params)
            flash[:notice] = "投稿を編集しました"
            redirect_to user_path(@user)
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def destroy
        @post = Post.find(params[:id])
        @user = current_user
        if @post.destroy
            flash[:notice] = "投稿を削除しました"
            redirect_to user_path(@user)
        else
            flash[:notice] = "投稿の削除に失敗しました"
            redirect_to user_path(@user)
        end
    end

    private
        def post_params
            params.require(:post).permit(:body)
        end
end
