class Question < ApplicationRecord
  belongs_to :user

  validates :body, presence: true
  validates :user_id, presence: true
end

# Асоціація belongs_to :user встановлює зв'язок між питанням 
# та користувачем, вказуючи, що кожне питання пов'язане з 
# одним користувачем.
# Валідація validates :content, presence: true гарантує, що
# перед збереженням питання в базу даних, значення атрибуту
# content повинно бути присутнім, тобто, користувач повинен
# ввести якийсь текст питання.
