class Article < ApplicationRecord
  MEALS = ["Breakfast", "Lunch", "Dinner", "Snack"].freeze
  has_many :comments, dependent: :destroy
  validates :title, presence: true, length: { minimum: 5, maximum: 160 }
  validates :body, presence: true, length: { minimum: 20 }
  validates :meal, inclusion: { in: MEALS }
  DIFFICULTIES = ["Easy", "Medium", "Weekend Project"].freeze
  validates :prep_minutes, numericality: { only_integer: true, greater_than: 0, less_than_or_equal_to: 600 }
  validates :difficulty, inclusion: { in: DIFFICULTIES }
  validates :ingredients, presence: true
  def ingredients_list
    ingredients.to_s.lines.map(&:strip).reject(&:empty?)
  end

end
