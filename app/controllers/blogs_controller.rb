class BlogsController < ApplicationController

	#layout :false #=> Turn off layout for this controller and all of its actions
	#layout 'admin' #=> Use admin layout instead of default application layout for this controller and all of its actions.

	# Through this controller, we should be able to 
	# 1. Create a Blog entry
	# 2. Read a Blog entry
	# 3. Read all Blog entries from the Database
	# 4. Update a Blog entry
	# 5. Delete a Blog entry

	def new
		@blog = Blog.new	
		# Show the HTML form to fill in details of the Blog
		# By convention, rails framework looks for a file called new.html.erb
		# in app/views/blogs folder. This can be overridden.
	end

	def create
		# We have to construct an empty Blog object
		# Assign the attribute values of this object with the values that user has filled in 
		# in the form. These values are available to us through the request parameters
		# params is the keyword to be used to extract all the request parameters sent 
		# to this method
		blog_props = params[:blog]
		@blog = Blog.new(blog_props)
		if @blog.save #=> returns true if object is saved otherwise returns false
			redirect_to blogs_path, :notice => "Your blog entry has been created!"
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
		@blogs = Blog.order('created_at DESC')
	end

	def show
		@blog = Blog.find(params[:id])
		@blog_posts = @blog.blog_posts.order("created_at DESC")
		#render :layout => false # Turn off layout for this action alone
		render :layout => 'application' # This action alone uses admin layout irrespective of what layout the controller is configured with
	end

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])
		blog_props = params[:blog]
		if @blog.update_attributes(blog_props) 
			# render update.html.erb
			redirect_to blog_path(@blog), :notice => "Your blog entry has been updated!" # Redirect to /blogs/<:id>
		else
			render :edit
		end
	end


	def destroy
		@blog = Blog.find(params[:id])
		if @blog.destroy
			redirect_to blogs_path, :notice => "Your blog entry has been deleted!"
		else
			redirect_to blogs_path, :notice => "Your blog entry could not be deleted!"
		end
	end

end
