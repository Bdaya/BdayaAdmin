
committees = %w( IT FR HR PR YES Geneh Care Logistics Academics Design Team )

committees.each do |com|
  Committee.create name: com
end
