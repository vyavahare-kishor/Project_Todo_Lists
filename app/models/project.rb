class Project < ApplicationRecord
  has_many :todo_lists, inverse_of: :project
  has_many :users, through: :todo_lists

  accepts_nested_attributes_for :todo_lists,  allow_destroy: true

  scope :current_manager, -> (id) {where(manager: id)}
end
