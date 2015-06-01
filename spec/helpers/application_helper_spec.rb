RSpec.describe ApplicationHelper, type: :helper do
  describe '#render_breadcrumbs' do
    before do
      allow(helper).to receive(:render)
    end

    let(:expected_crumbs) do
      [
        { locale_key: 'Path crumb', url: 'http://someurl/' },
        { locale_key: 'Last crumb' }
      ]
    end

    it 'renders the the shared/breadcrumbs template' do
      expect(helper).to receive(:render).with('shared/breadcrumbs', anything)
      helper.render_breadcrumbs {}
    end

    it 'builds a crumb list and passes it in the `breadcrumbs` variable' do
      expect(helper).to receive(:render).with(anything, breadcrumbs: expected_crumbs)
      helper.render_breadcrumbs do |crumbs|
        crumbs.add 'Path crumb', 'http://someurl/'
        crumbs.add 'Last crumb'
      end
    end
  end
end
