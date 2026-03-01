FactoryBot.define do
  factory :expediente do
    studio
    client
    association :assigned_to, factory: :user
    
    caratula { "#{client.first_name} c/ OTRA PARTE s/ Daños y Perjuicios" }
    numero_causa { "EXP-#{Faker::Number.number(digits: 6)}/#{Time.current.year}" }
    juzgado { "Juzgado Civil N° #{rand(1..100)}" }
    fuero { "Civil y Comercial" }
    jurisdiccion { "CABA" }
    
    status { :en_tramite }
    tipo_proceso { "Ordinario" }
    parte { "Actora" }
  end
end
