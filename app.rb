require 'sinatra'
require 'sinatra/reloader'
require 'data_mapper'
require './model'   #model.rb를 데리고 오기 위해 

enable :sessions

get '/' do 
    
    @tweet = Tweet.all
    if session[:email]
    erb :index 
    else
        redirect '/login'
    end
end

get '/create' do
    @name = params[:name]
    @content = params[:content]
    
    Tweet.create(
       # name: @name,
       # content: @content
        #칼럼이름: 넣고자 하는 내용.
        #칼럼이름: 넣고자 하는 내용 
        name: session[:email],
        content: params[:content]
        )
        
        redirect '/' #유저에게 안보여줄 것이라 erb 대신 루트페이지로 돌아가기 
end

get '/signup' do
    erb :signup
end

get '/register' do
    
    User.create(
        email: params[:email],
        password: params[:password]
        )
    erb :register
end

get '/admin' do
    
    @user = User.all
    @total =User.total
    erb :admin
end

get '/login' do
    erb :login
    
end

get '/login_session' do
    #사용자를 로그인 시킨다.
    #== 만약 사용자가 유효하다면, (email, pw == DB에 저장된 email, pw) 
    # session  사용자를 저장한다. 
#   @users = User.all
#   @success = ""
#   @users.each do |u|
#         if u.email == params[:email]
#             if u.password == params[:password]
#               @success = "성공"
#             else
#                 @success = "비밀번호가 틀림"
#             end
#         else
#             @success = "회원가입 ㄱㄱ"
#         end

#   end

    @msg = "로그인실패"
    @users = User.all
    
    @users.each do |u|
        if u.email == params[:email] && u.password == params[:password]
           
                @msg = "로그인 성공"
                session[:email] = u.email
            
        end
    end
   # @user = User.first(email: params[:email])
   
   #만약 @user에 어떤 값이 들어가 있으면
   # == 유저가 입력한 이메일으 데이터가 우리 DB에 있다면
   # == DB에 params[]로 날라온 값이 있다면 
   
   erb :login_session
end

get '/logout' do
session.clear
redirect '/'
end
