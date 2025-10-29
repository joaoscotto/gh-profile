# frozen_string_literal: true

FactoryBot.define do
  factory :profile do
    name { 'Yukihiro Matsumoto' }
    url { 'https://github.com/matz' }
    username { 'matz' }
  end
end
