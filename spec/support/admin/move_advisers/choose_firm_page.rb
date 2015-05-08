module Admin
  module MoveAdvisers
    class ChooseFirmPage < SitePrism::Page
      set_url_matcher %r{/admin/firms/[0-9]+/move_advisers/choose_to_firm}

      element :to_firm_fca_number, '.t-to_firm_fca_number'
      element :next, '.t-next'

      section :hidden, HiddenFieldsSection, '.t-hidden-fields'
    end
  end
end
