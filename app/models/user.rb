class User < ActiveRecord::Base
  has_many :user_lessons, :dependent => :destroy
  has_many :lessons, :through => :user_lessons

  def lessons_as_student
    user_lessons.where(:role => "student").map(&:lesson)
  end

  def lessons_as_teacher
    user_lessons.where(:role => "teacher").map(&:lesson)
  end

end