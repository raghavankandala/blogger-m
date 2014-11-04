class Blog < ActiveRecord::Base
	attr_accessible :title, :description, :keywords, :author
	
	# Validations
	# Title should be present 
	# Description should be present
	# Author should be present
	# Keywords should be present

	validates :title, presence: true
	validates :description, presence: true
	validates :author, presence: true
	validates :keywords, presence: true

	# Associations
	# Blog has many Blog Posts
	has_many :blog_posts

end
