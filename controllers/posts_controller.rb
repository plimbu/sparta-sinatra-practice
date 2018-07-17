
#PostsController  inherit from Sinatra which is a module which inherits from its own class BASE!
class PostsController < Sinatra::Base

#IMPORTANT
#tricks ruby to make it look for erb in a different file called views
  # sets root as the parent-directory of the current file
  set :root, File.join(File.dirname(__FILE__), '..')

  # sets the view directory correctly
  set :views, Proc.new { File.join(root, "views") }







  #if in development mode use sinatra reloader so we can make view changes live
  configure :development do
    register Sinatra::Reloader
  end

#fake dummy data just used for the purpose of this intro
  $posts = [{
  	 id: 0,
  	 title: "Post 1",
  	 body: "This is the first post"
  },
  {
      id: 1,
      title: "Post 2",
      body: "This is the second post"
  },
  {
      id: 2,
      title: "Post 3",
      body: "This is the third post"
  }]

#end of fake data we will use for this project




  #can't make changes untill site is taken down and app is run again unless we have require "sinatra/reloader"
  #/ is root directry which is basically whichever root they are on
  #if you make get request to root then get Hello world



  #FORM
  get "/new" do
erb :"posts/form"
  end



  #INDEX
  get "/" do
    #erb looks for file in posts/index directory then renders it
    @title = "Blog Posts"
    @posts = $posts
    # This page will be rendered AFTER the layout.erb is rendered and inserted where yield is is rendered
    erb :"posts/index"
  end

  #NEW
  get "/new" do
  "This is the new root"
  end
  # SHOW
  get "/:id" do
    #params is a has we can access
    puts params
    #create a hash called params which stores user id
    #whatever the user ENTERS INTO THE ID PARAMETER is stored into the id variable
    id = params[:id]
@paragraph = $posts[id.to_i]
@text = $posts[id.to_i]


    erb :"posts/show"




  end









  # CREATE
  post "/" do
    "This is the create route!"
  end

  # EDIT
  get "/:id/edit" do
    id = params[:id]

    "This is the edit route!"
  end

  # UPDATE
  put "/:id" do
    id = params[:id]

    "This is the update route!"
  end

  # DESTROY
  delete "/:id" do
    id = params[:id]

    "This is the destroy route!"
  end




end
