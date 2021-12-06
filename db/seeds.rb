# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

if User.count == 0
User.create(username:"lavanya", email:"lavanya@ca.com",password:"1234",password_confirmation:"1234",isAdmin: true)
User.create(username:"lavanya2", email:"lavanya2@ca.com",password:"12345",password_confirmation:"12345",isAdmin: false)
end
if Message.count == 0
    Message.create(m_text:'Rails API lesson today',user_id:1)
    Message.create(m_text:'BE with CRUD tomorrow', user_id:2)
    Message.create(m_text:'Integration and Deployment lessons next week',user_id:2)
end

