class CreateSubjects < ActiveRecord::Migration
  def self.up
    create_table :subjects do |t|
      t.string :nome
      t.timestamps
    end
    #nomes = ["Português", "Matemática", "Ciências", "História", "Geografia", "Artes", "Educação Física", "Ensino Religioso", "Inglês", "Espanhol"]
    #nomes.each { |nome| Subject.create! :nome => nome }
  end

  def self.down
    drop_table :subjects
  end
end
