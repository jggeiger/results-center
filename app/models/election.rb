class Election < ApplicationRecord

    validates :title, presence: true
    validates :status, presence: true
    enum :status, {pending: "pending", open: "open", closed: "closed"}
    
end
