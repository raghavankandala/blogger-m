class CreateBlogPosts < ActiveRecord::Migration
  def up
	create_table :blog_posts do |t|
		t.string :title, :keywords
		t.text :summary
		t.text :description
		t.string :author
		t.boolean :published
		t.timestamp :published_at
		t.timestamps
	end
  end

  def down
	drop_table :blog_posts
  end
end
