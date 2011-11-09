class SeedProjects < ActiveRecord::Migration
  def up
    xxx = Time.now.to_s
    u = User.create! :username=>'auto', :email=>'auto@auto.com', :password=>xxx, :password_confirmation=>xxx
    
    degree_names = (1..9).to_a
    subject_names = ["Portugues", "Matematica", "Ciencias", "Historia", "Geografia", "Artes", "E Fisica", "E Relig", "Ingles", "Espanhol"]
    
    subjects = subject_names.map { |nome| Subject.create! :nome => nome }
    degrees  = degree_names.map  { |nome| Degree.create!  :nome => nome }
    
    subjects.each do |s|
      degrees.each do |d|
        (1..8).each do |i|
          Project.create! :user     => u,
                          :subject  => s,
                          :degree   => d,
                          :sequencia => i
          end
      end
    end
    
    
  end

  def down
    puts "semeamento de dados, portanto, nao eh reversivel"
  end
end
