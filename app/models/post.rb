class Post < ActiveRecord::Base
  has_many :tags
  validate :has_tags?

  def has_tags?
    errors.add_to_base "Post must have some tags." if self.users.blank?
  end
end
