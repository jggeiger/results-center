class Answer < ApplicationRecord
  belongs_to :question

  scope :to_question, -> (question_id) {where(question: question_id)}

end
