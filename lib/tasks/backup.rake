require 'colorize'

namespace :verso do

  desc "Copia Banco de dados e Pasta de Arquivos (linux)"
  task :backup do
    t = Time.now
    ts = t.strftime("%Y_%h_%d__%H_%M_%S")
    pasta = "backup/#{ts}"
    #
    puts "Iniciando Backup em #{pasta}...".yellow
    system("mkdir backup")
    system("mkdir #{pasta}")
    system("cp db/*.sqlite3 #{pasta}")
    puts "Backup Salvo em: #{pasta} com Sucesso!".green
    #
    puts "Compactando #{pasta}...".yellow
    system("zip -r #{pasta}/arquivos_#{ts}.zip public/arquivos")
    puts "Compactado #{pasta}".green
    puts "#{Time.now-t} segundos".green
  end
  
end
