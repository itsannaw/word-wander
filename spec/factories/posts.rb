FactoryBot.define do
  factory :post do
    title { 'Sample Post' }
    description { 'This is a sample post description' }
    image { Rack::Test::UploadedFile.new(Rails.root.join('spec', 'fixtures', 'test.png'), 'image/png') }
    user
  end
end
