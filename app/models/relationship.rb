class Relationship < ApplicationRecord
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"

  # 次の２つのバリデーションはコメントアウトしても、テストがクリアしてしまう
  # Rails 5以降は必須ではなくなっている　(一応ここでは、基礎に忠実にやるため、書いた)
  validates :follower_id, presence: true
  validates :followed_id, presence: true
  
end
