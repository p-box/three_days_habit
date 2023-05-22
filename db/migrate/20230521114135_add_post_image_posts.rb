class AddPostImagePosts < ActiveRecord::Migration[7.0]
  def up
    add_column :posts, :post_image, :string
  end
end
