
#PostsController  inherit from Sinatra which is a module which inherits from its own class BASE!
class PostsController < Sinatra::Base

#IMPORTANT
#tricks ruby to make it look for erb in a different file called views
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }







  configure :development do
    register Sinatra::Reloader
  end







  #INDEX
  get "/" do
    #erb looks for file in posts/index directory then renders it
    @title = "Blog Posts"
    #grab data as an instance so we can use it in the view
    @posts = Post.all
    # This page will be rendered AFTER the layout.erb is rendered and inserted where yield is is rendered
    erb :"posts/index"
  end



  #NEW
  get "/new" do

  post = Post.new

  @post = post
  post.id =""
  post.title =""
  post.body=""

    erb :"posts/new"
  end



  # SHOW for each id
  get "/:id" do
    id = params[:id].to_i

    @post = Post.find(id)

    erb :"posts/show"
  end









  # CREATE
  post "/" do
    post = Post.new
    #set post values
    post.title = params[:title]
    post.body = params[:body]

    post.save

    redirect "/"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id].to_i
    @post = Post.find(id)
    erb :"posts/edit"
  end

  # UPDATE
  put "/:id" do


    #grab id from user
    id = params[:id].to_i
    # getting post we are editing and setting it to post
    #get post depending on id
    post = Post.find(id)
    # set the title  and body user enters into posts title and body
    #set posts title and body
    post.title = params[:title]
    post.body = params[:body]

    #injects  values above to database running sql command
    post.save


    redirect "/"

  end

  # DESTROY
  delete "/:id" do
    id = params[:id].to_i
    #accessing delete and then setting everything to empty

    Post.destroy(id)
    redirect "/"



  end




end
