class User < ApplicationRecord
    validates :name, :email, :phone, :cpf, presence: true

    validates :email, :phone, :cpf, uniqueness: true, on: :create

    validates :email, format: { with: /\w+([\.-]?\w+)*@\w+([\.-]?\w+){1}(\.\w{1,2})/ }
    validates :phone, format: { with: /\(\d{2}\)\s9\s\d{4}\-\d{4}/ }
    validates :cpf, format: { with: /\d{3}\.\d{3}\.\d{3}\-\d{2}/ }
end
