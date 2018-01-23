class Permission < ApplicationRecord
  belongs_to :user
  belongs_to :role



  def save_or_exist(permission)

    check=Permission.find_by(user_id: permission[:user], role_id: permission[:role])
    if check.nil?
      self.save

    end
  end
end
