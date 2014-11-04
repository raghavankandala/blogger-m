class BlogPostsController < ApplicationController

	before_filter :load_blog
	before_filter :load_blog_post, :except => [:new, :create, :index]

	# Through this controller, we should be able to 
	# 1. Create a BlogPostPost entry
	# 2. Read a BlogPostPost entry
	# 3. Read all BlogPost entries from the Database
	# 4. Update a BlogPost entry
	# 5. Delete a BlogPost entry

	def new
		@blog_post = @blog.blog_posts.build
		# Show the HTML form to fill in details of the BlogPost
		# By convention, rails framework looks for a file called new.html.erb
		# in app/views/blog_posts folder. This can be overridden.
	end

	def create
		# We have to construct an empty BlogPost object
		# Assign the attribute values of this object with the values that user has filled in 
		# in the form. These values are available to us through the request parameters
		# params is the keyword to be used to extract all the request parameters sent 
		# to this method
		blog_props = params[:blog_post]
		@blog_post = @blog.blog_posts.build(blog_props)
		if @blog_post.save #=> returns true if object is saved otherwise returns false
			redirect_to blog_posts_path, :notice => "Your blog post entry has been created!"
			# show create.html.erb file
		else
			#=> The form data is not valid, so we will show the same form to the user 
			# and tell him/her to enter the right data/ required data.
			# The below line will render the view corresponding to the name of the action specified
			# ie it will render the view of the new action.
			render :new 
		end
	end

	def index
		@blog_posts = @blog.blog_posts.order('created_at DESC')
	end

	def show
		#render :layout => false # Turn off layout for this action alone
		render :layout => 'application' # This action alone uses admin layout irrespective of what layout the controller is configured with
	end

	def edit
	end

	def update
		blog_props = params[:blog_post]
		if @blog_post.update_attributes(blog_props) 
			# render update.html.erb
			redirect_to blog_blog_post_path(@blog,@blog_post), :notice => "Your blog post entry has been updated!" # Redirect to /blogs/<:id>
		else
			render :edit
		end
	end


	def destroy
		if @blog_post.destroy
			redirect_to blog_posts_path, :notice => "Your blog post entry has been deleted!"
		else
			redirect_to blog_posts_path, :notice => "Your blog post entry could not be deleted!"
		end
	end

	private
	
	def load_blog
		@blog = Blog.find(params[:blog_id])
	end

	def load_blog_post
		@blog_post = @blog.blog_posts.find(params[:id])
	end

end
