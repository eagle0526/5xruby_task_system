# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


user = User.create(name: "yee", email: "xxx@gmail.com", password: "123asdzxc")

priority_arr = ["高", "中", "低"]
state_arr = ["待處理", "進行中", "已完成"]

11.times do |number|
  Task.create(title: "任務#{number}", 
              content: "好難啊", 
              priority: priority_arr.sample(1).first, 
              state: state_arr.sample(1).first, 
              classification: "程式", 
              start_time: "2025-02-25 12:00",
              end_time: "2025-02-26 12:00",
              user_id: user.id
            )
            
end


