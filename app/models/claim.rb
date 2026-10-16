class Claim < ApplicationRecord
  SPECIFIC_ENOUGH = 0.75
  STORY_LIMIT = 280
  MEASURE_AFTER = 10

  belongs_to :item

  include S1::Measurable
  measurable_as { { story: story, item: item } }

  judges :plausible, "Is `story` a plausible account of losing the `item`?",
    measure_on: :validation, if: :will_save_change_to_story?
  judges :match, "Is `story` describing the same object as `item`?",
    measure_on: :validation, if: :will_save_change_to_story?
  judges :specificity, "Is `story` specific enough to pick one object out of many — colour, material, markings, where exactly, and when — rather than a generic line like 'an umbrella at school' or 'a book today'?",
    measure_on: :validation, if: :will_save_change_to_story?

  validates :story, length: { maximum: STORY_LIMIT }
  validates :plausible, numericality: { greater_than: 0.5, message: "doesn't sound like this item" }
  validates :specificity, numericality: { greater_than_or_equal_to: SPECIFIC_ENOUGH, message: "is too vague — say the colour, the markings, exactly where, and when" }

  def self.specificity_label(story)
    return "" if story.to_s.length < MEASURE_AFTER

    "specificity #{(new(story: story).tap { |claim| claim.assign_measure(:specificity) }.specificity * 100).round}% / #{(SPECIFIC_ENOUGH * 100).round}%"
  end
end
