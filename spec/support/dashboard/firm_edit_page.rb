module Dashboard
  class FirmEditPage < SitePrism::Page
    set_url '/dashboard/firms/{firm}'
    set_url_matcher %r{/dashboard/firms/\d+}

    element :firm_name, '.t-firm-name'
  end
end
