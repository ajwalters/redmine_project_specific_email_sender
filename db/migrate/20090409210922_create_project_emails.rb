class CreateProjectEmails < ActiveRecord::Migration
  def self.up
    create_table :project_emails do |t|
      t.string :email
      t.references :project
    end
    add_index :project_emails, :project_id
  end

  def self.down
    remove_index :project_emails, :project_id
    drop_table :project_emails
  end
end
