RSpec.feature 'The dashboard firm edit page' do
  let(:firms_index_page) { Dashboard::FirmsIndexPage.new }
  let(:firm_edit_page) { Dashboard::FirmEditPage.new }

  scenario 'The principal can edit their firm' do
    given_i_am_a_fully_registered_principal_user
    and_i_have_a_firm
    and_i_am_logged_in
    when_i_am_on_the_principal_dashboard_firms_page
    and_i_click_the_edit_link_for_my_firm
    then_i_see_the_edit_page_for_my_firm
  end

  def given_i_am_a_fully_registered_principal_user
    @principal = FactoryGirl.create(:principal)
    @user = FactoryGirl.create(:user, principal: @principal)
  end

  def and_i_have_a_firm
    firm_attrs = FactoryGirl.attributes_for(:firm, fca_number: @principal.fca_number)
    @principal.firm.update_attributes(firm_attrs)
  end

  def and_i_am_logged_in
    login_as(@user, scope: :user)
  end

  def when_i_am_on_the_principal_dashboard_firms_page
    firms_index_page.load
    expect(firms_index_page).to be_displayed
  end

  def and_i_click_the_edit_link_for_my_firm
    firms_index_page.parent_firm.edit_link.click
  end

  def then_i_see_the_edit_page_for_my_firm
    expect(firm_edit_page).to be_displayed
    expect(firm_edit_page.firm_name).to have_text @principal.firm.registered_name
  end
end
