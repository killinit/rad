module ApplicationHelper
  def validation_summary_with_devise_alerts(form:)
    form.object.errors.add(:base, flash[:alert]) if flash[:alert]
    content_tag :div, form.validation_summary, class: 't-devise-form-errors'
  end

  def render_breadcrumbs(&builder_block)
    crumb_builder = (Class.new do
      def add(locale_key, url = :no_path)
        crumb = { locale_key: locale_key }
        crumb[:url] = url unless url == :no_path
        crumbs.push(crumb)
      end

      def crumbs
        (@crumbs ||= [])
      end
    end).new

    builder_block.call(crumb_builder)
    render 'shared/breadcrumbs', breadcrumbs: crumb_builder.crumbs
  end
end
