class BlogPost < ActiveRecord::Base
	
	attr_accessible :title, :keywords, :author, :summary, :description, :published, :published_at, :blog_id

	validates :title, presence: true
	validates :keywords, presence: true
	validates :author, presence: true
	validates :summary, presence: true
	validates :description, presence: true
	validates :published_at, presence: true, :if => :blog_post_published?
	validates :blog_id, presence: true

	# Associations
	# BlogPost belongs to a Blog
	belongs_to :blog

	def blog_post_published?
		self.published?
	end

end
