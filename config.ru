#rack file

require "sinatra"
require "sinatra/contrib"
#the require below uses sinatra reloader if we are in development enviromenet, which means we can make changes to live site when in development mode
require "sinatra/reloader" if development?
#below require gets our post controller which the rack controller
require_relative "controllers/posts_controller.rb"

#tell rack which controller to run

run PostsController
