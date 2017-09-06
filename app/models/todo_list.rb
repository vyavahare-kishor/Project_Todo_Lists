class TodoList < ApplicationRecord
  belongs_to :project, inverse_of: :todo_lists
  belongs_to :user, inverse_of: :todo_lists

  scope :by_current_user, -> (id) {where(user_id: id)}
end
