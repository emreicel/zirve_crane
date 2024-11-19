# app/controllers/home_controller.rb
class HomeController < ApplicationController
  def index
    @payment_records = PaymentTable.all

    @missing_documents = PaymentTable
    .left_joins(:file_attachment)
    .where(active_storage_attachments: { id: nil })
    .where("start_date < ? OR (start_date >= ? AND start_date <= ?)",
           Date.current,
           Date.current.beginning_of_month,
           Date.current.end_of_month)
    .order(start_date: :asc)
  end
end
