class Tag < ActiveRecord::Base
  has_many :posts

  def self.from_param(param)
    find_by_name!(param)
  end
  def to_param  # overridden
    name
  end
end

# user = User.find_by_name('Phusion')
# user_path(user)  # => "/users/Phusion"
