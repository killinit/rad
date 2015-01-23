class Firm < ActiveRecord::Base
  has_and_belongs_to_many :in_person_advice_methods
  has_and_belongs_to_many :other_advice_methods
  has_and_belongs_to_many :initial_advice_fee_structures
  has_and_belongs_to_many :ongoing_advice_fee_structures
  has_and_belongs_to_many :allowed_payment_methods
  has_and_belongs_to_many :investment_sizes

  belongs_to :initial_meeting_duration

  has_many :advisers

  attr_accessor :percent_total

  validates :email_address,
    presence: true,
    length: { maximum: 50 },
    format: { with: /.+@.+\..+/ }

  validates :telephone_number,
    presence: true,
    length: { maximum: 30 },
    format: { with: /\A[0-9 ]+\z/ }

  validates :address_line_one,
    presence: true,
    length: { maximum: 100 }

  validates :address_line_two,
    length: { maximum: 100 }

  validates :address_postcode,
    presence: true,
    format: { with: /\A[a-zA-Z\d]{1,4} [a-zA-Z\d]{1,3}\z/ }

  validates :address_town,
    :address_county,
    presence: true

  validates :in_person_advice_methods,
    length: { minimum: 1 }

  validates :free_initial_meeting,
    inclusion: { in: [true, false] }

  validates :initial_meeting_duration,
    presence: true,
    if: ->{ free_initial_meeting }

  validates :initial_advice_fee_structures,
    length: { minimum: 1 }

  validates :ongoing_advice_fee_structures,
    length: { minimum: 1 }

  validates :allowed_payment_methods,
    length: { minimum: 1 }

  validates :minimum_fixed_fee,
    allow_blank: true,
    numericality: { only_integer: true }

  validate :sum_of_percentages_equals_one_hundred

  validates :retirement_income_products_percent,
    :pension_transfer_percent,
    :long_term_care_percent,
    :equity_release_percent,
    :inheritance_tax_and_estate_planning_percent,
    :wills_and_probate_percent,
    :other_percent,
    presence: true,
    numericality: { only_integer: true }

  validates :investment_sizes,
    length: { minimum: 1 }

  private

  def sum_of_percentages_equals_one_hundred
    total = retirement_income_products_percent.to_i \
      + pension_transfer_percent.to_i \
      + long_term_care_percent.to_i \
      + equity_release_percent.to_i \
      + inheritance_tax_and_estate_planning_percent.to_i \
      + wills_and_probate_percent.to_i \
      + other_percent.to_i

    unless total == 100
      errors.add(
          :percent_total,
          I18n.t('questionnaire.retirement_advice.percent_total.not_one_hundred')
      )
    end
  end
end
