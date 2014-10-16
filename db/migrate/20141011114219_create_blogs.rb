class CreateBlogs < ActiveRecord::Migration
  def up
		create_table :blogs do |t|
			# Even though we didn't specify the primary key for this table
			# the migration module automatically generates an ID column 
			# and makes it the primary key for this Table. And this is the default
			# rails convention. This can be overridden.
			t.string :title
			t.text :description
			t.string :author
			t.string :keywords
			t.timestamps #created_at & updated_at of type datetime
		end
  end

  def down
		drop_table :blogs
  end
end
