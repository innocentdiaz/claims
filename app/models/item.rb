class Item < ApplicationRecord
  include S1::Measurable
  measurable_as { { description:, title:, since: created_at&.strftime("%Y-%m-%d") } }   # hash shorthand for columns; created_at is nil before the first save

  choice_enum :category, "What is it?",
    professional: "a professional or work item.",
    personal: "a personal item",
    other: "something else",
    measure_on: :create                            # collapse into the column, off the request thread (a job)

  scope :unclaimed, -> { where(claimed: false) }
end
