class Post

  attr_accessor :id, :title, :body

#this is the model who grabs stuff from the database which the controller controlss, which is sent to controller then sent to be styleed then sent to controller to be sen to client

#self.function mean it is not an instance and is called within class e.g Post.open_connection
  def self.open_connection
    #open up connection to database called blog
    conn = PG.connect(dbname: "blog", user: "postgres", password: "Acad3my1")
  end

#conn is a instance/hash which we store all the blog data from data base using self.open_connection
  def self.all
    conn = self.open_connection
    sql = "SELECT * FROM post ORDER BY id"
    #executing sql on conn which takes it to the database
    results = conn.exec(sql)

#go through results hash/instance by mapping it first then for each data in the hash and run it through hydrate function
#hydrate function returns data we want
    posts = results.map do |data|

      self.hydrate data
    end
    return posts
  end


#get data we want

  def self.hydrate post_data
    #new instance of post class
    post = Post.new
    post.id = post_data["id"]
    post.title = post_data["title"]
    post.body = post_data["body"]
    return post

  end

#function passes id as parameter and then runs a sql comment to get all from where id = id from paraemeter
  def self.find id
    #store connection in conn
    conn = self.open_connection
    #store sql command in sql
    sql = "SELECT * FROM post WHERE id = #{id}"

    #executes sql code for connection to database PG and then returns whatever is returned from hydrate function
    posts = conn.exec(sql)
    return self.hydrate posts[0]

  end

#SHOW AND UPDATE
  #not self.save because we want to call it on a instance of the class
  #get title and body values from params and then insert into table
  def save
    conn = Post.open_connection

#if there is not an id we are on  index
    if !self.id
#insert into post title and bodys columns and insert the values self.title and self.body which is got from the user params
    sql = "INSERT INTO post (title, body) VALUES ('#{self.title}', '#{self.body}')"
  else
    sql = "UPDATE post SET title='#{self.title}', body='#{self.body}' WHERE id = '#{self.id}'"
  end
    conn.exec(sql)
  end



  #DESTROY
  def self.destroy id
    conn = self.open_connection
    sql = "DELETE FROM post WHERE id = #{id}"
    conn.exec(sql)
  end


end
