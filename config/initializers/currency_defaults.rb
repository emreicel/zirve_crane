# config/initializers/currency_defaults.rb

ActionView::Base.default_form_builder = Class.new(ActionView::Helpers::FormBuilder) do
    def number_to_currency(number, options = {})
      options = {
        unit: "₺",
        separator: ",",
        delimiter: ".",
        format: "%n %u"
      }.merge(options)
  
      super(number, options)
    end
  end
  