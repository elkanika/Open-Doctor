FactoryBot.define do
  factory :deadline do
    studio
    expediente
    
    title { "Contestar demanda" }
    party { :propio }
    status { :pendiente }
    
    starts_on { Date.current }
    due_on { 5.days.from_now.to_date }
    days_count { 5 }
    business_days { true }
    priority { :alta }
  end
end
