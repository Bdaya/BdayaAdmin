
committees = %w( IT FR HR PR YES Geneh Care Logistics Academics Design Team )

committees.each do |com|
  Committee.create name: com
end

admin = Admin.new
admin.email = 'admin@bdaya.org'
admin.password, admin.password_confirmation = 'BdayaAdmin@123'
admin.save