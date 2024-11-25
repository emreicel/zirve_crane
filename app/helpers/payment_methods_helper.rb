module PaymentMethodsHelper
    def render_payment_method_icon(method)
      icon_class = case method.downcase
                  when /nakit/, /cash/
                    'fa-money-bill-wave'
                  when /kredi/, /credit/
                    'fa-credit-card'
                  when /havale/, /eft/
                    'fa-university'
                  when /çek/, /check/
                    'fa-money-check'
                  else
                    'fa-wallet'
                  end
  
      content_tag :div, class: 'payment-method-icon' do
        content_tag :i, nil, class: "fas #{icon_class}"
      end
    end
  end