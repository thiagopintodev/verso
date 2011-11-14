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
  
  
  desc "Exporta a localizacao dos arquivos paperclip do PV para project_versions.json"
  task :exportar_pv => :environment do
    open('project_versions.json', 'w') { |f| f.write ProjectVersion.exportar_to_json }
    'project_versions.json'
  end
  
  desc "Importa project_versions.json e move arquivos para novo local"
  task :importar_pv => :environment do
    array = JSON.parse open('project_versions.json', 'r').read
    array.each do |hash_pv|
      pv = ProjectVersion.find(hash_pv['id'])
      #
      mv_file(hash_pv['fla_path'], pv.fla.path) if hash_pv['fla_path'].present?
      mv_file(hash_pv['swf1_path'], pv.swf1.path) if hash_pv['swf1_path'].present?
      mv_file(hash_pv['swf2_path'], pv.swf2.path) if hash_pv['swf2_path'].present?
      mv_file(hash_pv['swf3_path'], pv.swf3.path) if hash_pv['swf3_path'].present?
      mv_file(hash_pv['aud1_path'], pv.aud1.path) if hash_pv['aud1_path'].present?
      mv_file(hash_pv['aud2_path'], pv.aud2.path) if hash_pv['aud2_path'].present?
      mv_file(hash_pv['aud3_path'], pv.aud3.path) if hash_pv['aud3_path'].present?
      #
      puts "#{hash_pv['id']}\t#{hash_pv['fla_path']}\t#{pv.fla.path}\tOK"
    end
    puts "OK!"
  end
  
  private
  
  def mv_file(from, to)
    a = to.split('/')
    a.delete(a.last)
    a = a.join('/')
    puts a
    system "mkdir -p #{a}"
    FileUtils.mv from, to
  end
end
