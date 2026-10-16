class Claim < ApplicationRecord
  belongs_to :item

  include S1::Measurable
  measurable_as { { story:, item: } }

  judges :is_plausible, "Is `story` a plausible account of losing the `item`?",           # float columns: the probabilities, kept
                 measure_on: :validation, if: :will_save_change_to_story?             # measured inside the save, before validations —
  judges :matches,     "Is `story` describing the same object as `item`?",              # both fields, one call
                 measure_on: :validation, if: :will_save_change_to_story?
  validates :is_plausible, numericality: { greater_than: 0.5, message: "doesn't sound like this item" }
  scope :likely, -> { where(match: 0.8..) }
end
