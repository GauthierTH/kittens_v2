class Order < ApplicationRecord
    belongs_to :user
    has_many :orderitems
    has_many :items, through: :orderitems

    after_update :admin_order_email_send

    def admin_order_email_send()
        if self.status == "paid"
            AdminMailer.admin_order_email(self).deliver_now
        end
    end
end
