class Answer < ApplicationRecord
  belongs_to :question

  validates :question_id, presence: true
  validates :text, presence: true
  validates :position, presence: true

  scope :to_question, -> (question_id) {where(question: question_id)}

end
