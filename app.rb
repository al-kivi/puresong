require 'sinatra'
require 'sequel'
require 'sinatra/sequel'
require 'sqlite3'
require 'gmail'
#require 'mandrill' # this is an alternative to gmail

database = Sequel.sqlite('development.sqlite')

# Define database migrations. Rending migrations are run once at startup
# ----------------------------------------------------------------------

begin
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
rescue
  puts "Table already exists"
end

# Basic functions
# -------------------------------------------------------------

get '/' do
  @title = "A Poplite sample website"
  erb :home, :locals => {:active=>["pure-menu-selected","","",""]}
end

get '/about' do
  @title = "More innovation from Vizica Consulting"
  erb :about, :locals => {:active=>["","","pure-menu-selected",""]}
end

get '/contact' do
  @title = "Online information request form"
  @name = ""
  @email = ""
  @comments = ""
  erb :contact, :locals => {:active=>["","","","pure-menu-selected"]}
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
  erb :songs, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/songs/new' do
  @song = Song.new
  erb :new_song, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/songs/:id' do
  @song = Song[(params[:id])]
  erb :show_song, :locals => {:active=>["","pure-menu-selected","",""]}
end

get '/songs/:id/edit' do
  @song = Song[params[:id]]
  erb :edit_song, :locals => {:active=>["","pure-menu-selected","",""]}
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

# Sample application to show mailout capabilities with Gmail
# This Google account has been adjusted for less security 
# -------------------------------------------------------------------------

post '/mailout' do
  @user = ENV["GMAIL_USER"]   # access info stored in environment variables
  @pwd = ENV["GMAIL_PWD"]
  
  gmail = Gmail.connect(@user, @pwd)
  
  email = gmail.compose do	
  end
  
  email['to'] = "admin@xxx.net"  # enter your administrators email here
  email['subject'] = "Request for information from - " + params[:name] + " - " + params[:email]
  email['body'] = params[:comments]
  
  email.deliver! 
  
  gmail.logout
  
  redirect to('/')
end


# Sample application to show mailout capabilities with Mandrill
# -------------------------------------------------------------------------

post '/mailout_option' do

  m = Mandrill::API.new ENV["MANDRILL_API_KEY"] # accesses environment variable
	
  message = {  
   :subject=> "Request for information from - " + params[:name],
   :from_name=> params[:name],  
   :text=>params[:comments],  
   :to=>[  
     { 
       :email=> ENV["ADMIN_EMAIL"]  # accesses environment variable
     }  
   ],  
   :html=>params[:comments],  
   :from_email=> ENV["ADMIN_EMAIL"]  # this needs to match Mandrill setup
  }  
  sending = m.messages.send message

  redirect to('/')
end