require 'sinatra'
#require 'sequel'
require 'sinatra/sequel'
require 'mandrill'

database = Sequel.sqlite('development.sqlite')

# Define database migrations. Rending migrations are run once at startup
# ----------------------------------------------------------------------
migration "create the songs table" do
  database.create_table :songs do
    primary_key	:id
    varchar     :title
    text				:lyrics
    integer			:length
    date				:released_on
#    timestamp   :published_at, :null => false

#    index :title, :unique => true
  end
end

# Basic functions
# -------------------------------------------------------------

get '/' do
	@title = "A Poplite sample website"
  erb :home
end

get '/about' do
  @title = "More innovation from Vizica Consulting"
  erb :about
end

get '/contact' do
	@title = "Online information request form"
	@name = ""
	@email = ""
	@comments = ""
  erb :contact
end

not_found do
  erb :not_found
end

# Sample application using SQLite
# Derived from Chapter 3, Jump Start Sinatra by Darren Jones. Copyright 2013 Sitepoint
# -------------------------------------------------------------------------------------

class Song < Sequel::Model
  #def before_save
  	#self.published_at ||= Time.now
  	#super
  #end
end

get '/songs' do
  @songs = Song.all
  erb :songs
end

get '/songs/new' do
  @song = Song.new
  erb :new_song
end

get '/songs/:id' do
  @song = Song[(params[:id])]
  erb :show_song
end

get '/songs/:id/edit' do
  @song = Song[params[:id]]
  erb :edit_song
end

post '/songs' do
  song = Song.create(params[:song])
  redirect to("/songs/#{song.id}")
end

put '/songs/:id' do
  song = Song[params[:id]]
  song.update(params[:song])
  redirect to("/songs/#{song.id}")
end

get '/songs/:id/delete' do # notice non-standard method for deletion
  Song[params[:id]].destroy
  redirect to('/songs')
end

# Sample application to show mailout capabilities
# -------------------------------------------------------------------------

post '/mailout' do

	#m = Mandrill::API.new ENV["MANDRILL_API_KEY"] # accesses environment variable
	#m = Mandrill::API.new "aZigkSOvZNE7p6muHoqCXQ"
	m = Mandrill::API.new "5t9fVlvPlMDJK9dcQ696Ug"
	
  message = {  
   :subject=> "Request for information from - " + params[:name],  
   :from_name=> params[:name],  
   :text=>params[:comments],  
   :to=>[  
     { 
       :email=> "akivi@ica.net"
     }  
   ],  
   :html=>params[:comments],  
   :from_email=>"akivi@ica.net"  # this needs to match Mandrill setup
  }  
  sending = m.messages.send message

	redirect to('/')
end