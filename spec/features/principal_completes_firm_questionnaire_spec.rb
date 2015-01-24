RSpec.feature 'Principal completes the firm questionnaire' do
  let(:questionnaire_page) { QuestionnairePage.new }
  let(:adviser_page) { AdviserPage.new }

  before do
    create(:in_person_advice_method)
    create(:other_advice_method)
    create(:initial_meeting_duration)
    create(:initial_advice_fee_structure)
    create(:ongoing_advice_fee_structure)
    create(:allowed_payment_method)
    create(:investment_size)
  end

  scenario 'Successfully complete the questionnaire' do
    given_i_have_selected_a_firm
    and_i_can_see_my_firm_name_and_fca_reference_number
    when_I_complete_all_mandatory_questions
    then_my_directory_listing_is_created_and_marked_as_done
    and_i_am_directed_to_assign_advisers_to_my_firm_or_subsidiary
  end

  def given_i_have_selected_a_firm
    @principal = create(:principal)
    questionnaire_page.load(principal: @principal.token)
  end

  def and_i_can_see_my_firm_name_and_fca_reference_number
    expect(questionnaire_page.firm_name.text).to eql(@principal.firm.registered_name)
    expect(questionnaire_page.firm_fca_number.text).to eql(@principal.firm.fca_number.to_s)
  end

  def when_I_complete_all_mandatory_questions
    questionnaire_page.tap do |p|
      p.email_address.set Faker::Internet.email
      p.telephone_number.set Faker::Base.numerify('##### ### ###')
      p.address_line_one.set Faker::Address.street_address
      p.address_town.set Faker::Address.city
      p.address_county.set Faker::Address.county
      p.address_postcode.set Faker::Address.postcode

      p.in_person_advice_methods.first.set true
      p.other_advice_methods.first.set true
      p.offers_free_initial_meeting.set true
      p.initial_meeting_durations.first.set true
      p.initial_fee_structures.first.set true
      p.ongoing_fee_structures.first.set true
      p.allowed_payment_methods.first.set true

      p.minimum_fee.set Faker::Number.number(4)

      p.retirement_income_products_percent.set 15
      p.pension_transfer_percent.set 15
      p.long_term_care_percent.set 15
      p.equity_release_percent.set 15
      p.inheritance_tax_and_estate_planning_percent.set 15
      p.wills_and_probate_percent.set 15
      p.other_percent.set 10

      p.investment_sizes.first.set true

      p.next_button.click
    end
  end

  def then_my_directory_listing_is_created_and_marked_as_done
    @principal.firm.reload

    expect(@principal.firm).to be_valid
  end

  def and_i_am_directed_to_assign_advisers_to_my_firm_or_subsidiary
    expect(adviser_page).to be_displayed
  end
end