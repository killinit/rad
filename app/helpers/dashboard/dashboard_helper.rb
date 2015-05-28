module Dashboard
  module DashboardHelper
    def firm_count
      @trading_names.count + (@firm.present? ? 1 : 0)
    end

    def standard_field(f, field, opts)
      field_classes = "t-#{field.to_s.gsub('_', '-')}"
      field_classes << " form__input-container--#{opts[:width]}" if opts[:width]

      f.form_row field do
        concat f.errors_for field
        concat f.label field, opts[:label], class: 'form__label-heading' if opts[:label]
        concat f.label field, class: 'form__label-heading' unless opts[:label]
        concat f.text_field field, class: field_classes
      end
    end

    def form_item(f, form_name, field, &block)
      render partial: 'dashboard/shared/form_helpers/item', locals: {
        f: f,
        field: field,
        block: block,
        form_name: form_name,
        legend_text: t("#{form_name}.#{field}.heading"),
        description_text: t("#{form_name}.#{field}.description"),
        label_text: block ? '' : t("questionnaire.#{field}.label")
      }
    end

    def form_checkbox_group(f, form_name, collection_class)
      field = collection_class.model_name.collection
      render partial: 'dashboard/shared/form_helpers/checkbox_group', locals: {
        f: f,
        form_name: form_name,
        collection: collection_class.all,
        field: field,
        field_ids: "#{collection_class.model_name.element}_ids".to_sym,
        test_class: "#{collection_class.model_name.element.gsub('_', '-')}-id",
        legend_text: t("#{form_name}.#{field}.heading")
      }
    end
  end
end
