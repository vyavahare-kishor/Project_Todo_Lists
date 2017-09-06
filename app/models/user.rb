class User < ApplicationRecord
    extend Devise::Models
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :role, :name

  has_many :projects, through: :todo_lists
  has_many :todo_lists

  scope :by_developer, -> {where(role: :developer)}

  def is?( requested_role )
    self.role == requested_role.to_s
  end
end
