class CreateAssignments < ActiveRecord::Migration[5.2]
  def change
    create_table :assignments do |t|

      t.references :store, foreign_key: true
      t.references :employee, foreign_key: true
      t.date :start_date
      t.date :end_date 
      
      #t.timestamps
    end
  end
end
