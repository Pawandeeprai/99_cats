# == Schema Information
#
# Table name: cats
#
#  id          :integer          not null, primary key
#  birth_date  :date             not null
#  color       :string           not null
#  name        :string           not null
#  sex         :string(1)        not null
#  description :text             not null
#  created_at  :datetime
#  updated_at  :datetime
#

class Cat < ActiveRecord::Base
  validates :birth_date, :color, :name, :sex, :description, presence: true
  validates :sex, inclusion: { in: %w(m f),
    message: "%{value} must be m or f" } #where is {value} defined?
  validates :name, uniqueness: true

  def age
    @age = Date.today.year - self.birth_date.year
  end

end
