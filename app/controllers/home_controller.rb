class HomeController < ApplicationController
  include Pundit::Authorization

  def index
    @home_policy = HomePolicy.new(current_user, :home)
    @active_contracts = policy_scope(Contract).where(completed: false)

    # Tüm ödeme kayıtları (yetkilendirmeye göre)
    @payment_records = policy_scope(PaymentTable)

    # Eksik dökümanlar (sadece super_admin ve admin için)
    if policy(:home).show_invoices?
      @missing_documents = PaymentTable
        .left_joins(:file_attachment)
        .where(active_storage_attachments: { id: nil })
        .where("start_date < ? OR (start_date >= ? AND start_date <= ?)",
               Date.current,
               Date.current,
               Date.current + 4.days)
        .order(start_date: :asc)
    end
  end
end