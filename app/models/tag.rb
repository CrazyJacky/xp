class Tag < ActiveRecord::Base
  has_many :lesson_tags, :dependent => :destroy
  has_many :lessons, :through => :lesson_tags
  has_many :experiences, :dependent => :destroy
  has_many :users, :through => :experiences

  validates :name, presence: true
  validates_uniqueness_of :name, :case_sensitive => false

  before_save :before_save_slugify

  def self.all_by_user(user)
    self.joins(:lessons => :users).where("users.id = '#{user.id}'")
  end

  def self.all_by_category(category)
    where(:category => category)
  end

  def self.active
    self.joins(:lessons).where("lessons.status = 'open'").group('tags.id')
  end

  def self.used
    joins(:lessons).group('tags.id')
  end

  def upcoming_lessons
    lessons.where(:status => "open") + lessons.where(:status => "closed")
  end

  def completed_lessons
    lessons.where(:status => "completed")
  end

  def before_save_slugify
    self.slug = slugify(self.name)
  end

  private
  def slugify(string)
    string.downcase.gsub(" ", "-")
  end

end
