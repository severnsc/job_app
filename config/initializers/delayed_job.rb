class Delayed::Job < ActiveRecord::Base
  belongs_to :reminder
end