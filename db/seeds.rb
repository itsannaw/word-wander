# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

User.destroy_all
Post.destroy_all
Comment.destroy_all

AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

5.times do |i|
  User.create!(
    name: "User #{i+1}",
    email: "user#{i+1}@example#{i+1}.com",
    password: "password",
    password_confirmation: "password"
  )
end

User.all.each do |user|
  3.times do |i|
    user.posts.create!(
      title: "Post #{i+1} by #{user.name}",
      description: "This is the description of post #{i+1} by #{user.name}",
      image: Rack::Test::UploadedFile.new(Rails.root.join('app', 'assets', 'images', 'seed_image.jpg'), 'image/png')
    )
  end
end

Post.all.each do |post|
  2.times do |i|
    post.comments.create!(
      body: "Comment #{i+1} on post #{post.title}",
      user: User.all.sample
    )
  end
end
