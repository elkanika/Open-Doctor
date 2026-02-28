# frozen_string_literal: true

# Seeds iniciales para desarrollo
# Ejecutar con: rails db:seed

puts "Creando estudio de prueba..."
studio = Studio.create!(
  name: "Estudio Jurídico Demo",
  slug: "demo",
  cuit: "30-12345678-9",
  email: "info@estudiodemo.com.ar",
  phone: "011-4567-8900",
  address: "Av. Corrientes 1234, Piso 5, CABA"
)

puts "Creando usuarios..."
ActsAsTenant.with_tenant(studio) do
  titular = User.create!(
    email: "titular@estudiodemo.com.ar",
    password: "password123",
    password_confirmation: "password123",
    first_name: "Juan",
    last_name: "Pérez",
    role: :titular,
    matricula: "T° 123 F° 456 CPACF"
  )

  colaborador = User.create!(
    email: "colaborador@estudiodemo.com.ar",
    password: "password123",
    password_confirmation: "password123",
    first_name: "María",
    last_name: "González",
    role: :colaborador,
    matricula: "T° 789 F° 012 CPACF"
  )

  admin = User.create!(
    email: "admin@estudiodemo.com.ar",
    password: "password123",
    password_confirmation: "password123",
    first_name: "Laura",
    last_name: "Rodríguez",
    role: :administrativo
  )

  puts "Creando clientes..."
  cliente1 = Client.create!(
    first_name: "Carlos",
    last_name: "García",
    document_type: "DNI",
    document_number: "30123456",
    email: "carlos.garcia@email.com",
    phone: "011-1234-5678",
    address: "Av. Santa Fe 2000, CABA"
  )

  cliente2 = Client.create!(
    first_name: "Ana",
    last_name: "Martínez",
    document_type: "DNI",
    document_number: "28654321",
    email: "ana.martinez@email.com",
    phone: "011-9876-5432"
  )

  puts "Creando expedientes..."
  exp1 = Expediente.create!(
    client: cliente1,
    assigned_to: titular,
    caratula: "García, Carlos c/ López, Pedro s/ daños y perjuicios",
    numero_causa: "CNV 12345/2025",
    juzgado: "Juzgado Nacional en lo Civil N° 42",
    fuero: "civil",
    jurisdiccion: "Nacional",
    status: :activo,
    tipo_proceso: "Ordinario",
    materia: "Daños y perjuicios",
    parte: "actor",
    monto_reclamado: 5_000_000.00,
    moneda: "ARS",
    fecha_inicio: Date.new(2025, 3, 15),
    descripcion: "Accidente de tránsito en Av. 9 de Julio. Colisión múltiple."
  )

  exp2 = Expediente.create!(
    client: cliente2,
    assigned_to: colaborador,
    caratula: "Martínez, Ana c/ Empresa XYZ SA s/ despido",
    numero_causa: "CNT 67890/2025",
    juzgado: "Juzgado Nacional del Trabajo N° 15",
    fuero: "laboral",
    jurisdiccion: "Nacional",
    status: :en_tramite,
    tipo_proceso: "Ordinario",
    materia: "Laboral",
    parte: "actor",
    monto_reclamado: 8_500_000.00,
    moneda: "ARS",
    fecha_inicio: Date.new(2025, 6, 1),
    descripcion: "Despido sin causa. Reclamo de indemnización art. 245 LCT."
  )

  puts "Creando instancias procesales..."
  instancia1 = ProceduralInstance.create!(
    expediente: exp1,
    name: "Primera Instancia",
    instance_type: :primera_instancia,
    status: :activa,
    tribunal: "Juzgado Nacional en lo Civil N° 42",
    fecha_inicio: Date.new(2025, 3, 15),
    position: 0
  )

  puts "Creando actos procesales..."
  acto1 = ProceduralAct.create!(
    procedural_instance: instancia1,
    name: "Contestación de demanda",
    description: "Plazo para contestar la demanda",
    status: :pendiente,
    position: 0
  )

  puts "Creando plazos..."
  Deadline.create!(
    expediente: exp1,
    procedural_act: acto1,
    title: "Contestar demanda - García c/ López",
    description: "Plazo de 15 días hábiles para contestar la demanda",
    party: :propio,
    starts_on: Date.current - 5.days,
    due_on: Date.current + 10.days,
    days_count: 15,
    business_days: true,
    status: :pendiente,
    alert_days_before: 3,
    priority: :alta
  )

  Deadline.create!(
    expediente: exp1,
    title: "Ofrecer prueba",
    description: "Plazo para ofrecer prueba después de contestar demanda",
    party: :propio,
    starts_on: Date.current + 10.days,
    due_on: Date.current + 20.days,
    days_count: 10,
    business_days: true,
    status: :pendiente,
    alert_days_before: 2,
    priority: :normal,
    depends_on_event: "Contestación de demanda"
  )

  Deadline.create!(
    expediente: exp2,
    title: "Audiencia de conciliación SECLO",
    party: :propio,
    starts_on: Date.current,
    due_on: Date.current + 30.days,
    status: :pendiente,
    alert_days_before: 5,
    priority: :urgente
  )

  puts "Creando movimientos..."
  Movement.create!(
    expediente: exp1,
    user: titular,
    title: "Inicio de demanda",
    description: "Se presentó escrito de demanda ante el Juzgado Civil N° 42",
    occurred_at: DateTime.new(2025, 3, 15, 10, 0, 0),
    movement_type: "escrito"
  )

  Movement.create!(
    expediente: exp1,
    user: titular,
    title: "Notificación al demandado",
    description: "Se notificó cédula al domicilio del demandado",
    occurred_at: DateTime.new(2025, 4, 2, 14, 30, 0),
    movement_type: "notificación"
  )

  Movement.create!(
    expediente: exp2,
    user: colaborador,
    title: "Presentación ante SECLO",
    description: "Se inició reclamo ante el SECLO por despido sin causa",
    occurred_at: DateTime.new(2025, 6, 1, 9, 0, 0),
    movement_type: "escrito"
  )
end

puts "✅ Seeds creados exitosamente!"
puts "  - 1 Estudio"
puts "  - 3 Usuarios (titular, colaborador, administrativo)"
puts "  - 2 Clientes"
puts "  - 2 Expedientes"
puts "  - 1 Instancia procesal"
puts "  - 1 Acto procesal"
puts "  - 3 Plazos"
puts "  - 3 Movimientos"
