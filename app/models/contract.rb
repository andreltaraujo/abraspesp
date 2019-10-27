class Contract < ApplicationRecord
has_one :user
has_one :representative
end
