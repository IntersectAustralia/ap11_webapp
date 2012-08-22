class Role < ActiveRecord::Base
  ADMIN_ROLE = 'admin'

  attr_accessible :name

  has_and_belongs_to_many :permissions, :join_table => 'roles_permissions'
  has_many :users

  validates :name, :presence => true, :uniqueness => {:case_sensitive => false}

  scope :by_name, order('name')
  scope :superuser_roles, where(:name => 'admin')

  def has_permission(entity, action)
    permissions.each do |perm|
      if perm.entity == entity && perm.action == action
        return true
      end
    end
    false
  end

  def admin?
    self.name == ADMIN_ROLE
  end

end
