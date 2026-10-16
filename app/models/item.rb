class Item < ApplicationRecord
  DESCRIPTION_LIMIT = 280
  CATEGORIZE_AFTER = 10

  has_many :claims

  validates :title, presence: true
  validates :description, length: { maximum: DESCRIPTION_LIMIT }

  include S1::Measurable
  measurable_as { { description:, title:, since: created_at&.strftime("%Y-%m-%d") } }   # hash shorthand for columns; created_at is nil before the first save

  choice_enum :category, "What is it?",
    professional: "a professional or work item.",
    personal: "a personal item",
    other: "something else",
    measure_on: :create                            # collapse into the column, off the request thread (a job)

  scope :unclaimed, -> { where(claimed: false) }

  def self.category_label(description)
    return "" if description.to_s.length < CATEGORIZE_AFTER

    "category=#{new(description: description).tap { |item| item.assign_measure(:category) }.category}"
  end
end
