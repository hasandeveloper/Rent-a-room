class User < ApplicationRecord

  has_many :permissions
  has_many :roles, through: :permissions
  has_many :rooms
  has_many :bookings

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


  # devise :database_authenticatable, :authentication_keys => [:username]


  validates :email,  uniqueness: true
  # validates :username, uniqueness: true
  validates_length_of :username, :minimum => 5, :maximum => 5


  validates_presence_of :first_name, :last_name, :username, :mobile

  def will_save_change_to_email?
    false
  end

  after_create :assign_customer_role

  def assign_customer_role
      Permission.create(user_id: self.id, role_id: Role.last.id)
  end

   def role?(role)
       self.roles.pluck(:name).include? role
   end
end
