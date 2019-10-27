namespace :dev do
  
  DEFAULT_PASSWORD = 111111
  
  desc "Configura o ambiente de desenvolvimento"
  task setup: :environment do
  
    if Rails.env.development?
      show_spinner("Apagando DB...") { %x(rails db:drop:_unsafe) }
      show_spinner("Criando DB...") { %x(rails db:create) }
      show_spinner("Migrando DB...") { %x(rails db:migrate) }
      show_spinner("Criando Contratos...") { %x(rails db:seed) }
      show_spinner("Cadastrando ADMIN padrão...") { %x(rails dev:add_default_admin) }
      show_spinner("Cadastrando outros ADMINS...") { %x(rails dev:add_others_admins) }
      show_spinner("Cadastrando USER padrão...") { %x(rails dev:add_default_user) }
      show_spinner("Cadastrando outros USERS...") { %x(rails dev:add_others_users) }  
    else
    puts "Você não está no ambiente do desenvolvimento!"
    end
  end
    
  desc "Adiciona o administrador padrão"
    task add_default_admin: :environment do
      Admin.create!(
        email: 'admin@admin.com',
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD
        )
    end

    desc "Adiciona outros administradores"
    task add_others_admins: :environment do
      10.times do
        Admin.create!(
          email: Faker::Internet.email,
          password: DEFAULT_PASSWORD,
          password_confirmation: DEFAULT_PASSWORD
          )
      end
    end
  
  desc "Adiciona o usuário padrão"
  task add_default_user: :environment do
    User.create!(
      first_name: "André",
      last_name: "Araujo",
      email: 'user@user.com',
      password: DEFAULT_PASSWORD,
      password_confirmation: DEFAULT_PASSWORD,
      contract: Contract.first
      )
  end
  
  desc "Adiciona outros usuários"
  task add_others_users: :environment do
    10.times do |i| 
      User.create!(
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: DEFAULT_PASSWORD,
        password_confirmation: DEFAULT_PASSWORD,
        contract: Contract.all.sample
      )
    end
  end
      private
  
    def show_spinner(msg_start, msg_end = "Concluído!")
      spinner = TTY::Spinner.new("[:spinner] #{msg_start}")
      spinner.auto_spin
      yield
      spinner.success("(#{msg_end})")
    end
end
