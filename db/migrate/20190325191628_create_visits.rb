class CreateVisits < ActiveRecord::Migration[5.2]
  def change
    create_table :visits do |t|
      t.cidr :ip
      t.string :logins, array: true
    end

    add_index :visits, :ip, unique: true
    add_index :visits, 'array_length(logins, 1)', order: { id: :desc }

    # add_index :visits, 'ip inet_ops', using: 'gist'
    # add_index :visits, :logins, using: 'gin'
  end
end
