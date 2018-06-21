DataMapper::setup(:default, "sqlite3://#{Dir.pwd}/Twitter.db")

class Tweet
    include DataMapper::Resource
    property :id, Serial
    property :name, String
    property :content, Text
    property :created_at, DateTime
end

class User
    ## 클래스 메소드 total을 통해 가입된 유저의 총 수를 보여주는
    ## User.total
    ## @@total 
    include DataMapper::Resource
    property :id, Serial
    property :email, String
    property :password, String
    property :created_at, DateTime
    
    def User.total 
        # 지금 우리가 가진 총 user의 수 
        User.all.size ## .size = 배열 안 총 갯수 
    end
end

DataMapper.finalize

Tweet.auto_upgrade!
User.auto_upgrade!

#데이터베이스를 만든 후에는 서버를 껐다가 다시 킨다. 