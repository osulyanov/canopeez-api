json.extract! user, :id, :name, :surname, :school, :nickname, :image,
              :created_at, :is_premium

json.extract! user, :provider, :uid, :email if user == current_user
