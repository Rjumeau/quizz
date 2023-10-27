# What’s the SQL query to get books written before 1985?

SELECT * FROM books WHERE publishing_year < 1985


# What’s the SQL query to get books written before 1985?
SELECT * FROM books
JOIN authors ON books.author_id = authors.author_id
WHERE authors.name = "Jules Verne"
ORDER BY publishing_year DESC
LIMIT 3

# Complete the following migrations to create your e-library database.
class CreateAuthors < ActiveRecord::Migration[7.0]
  def change
    create_table :authors do |t|
      t.string :name
      t.timestamps
    end
  end
end


# Complete the following migrations to create your e-library database.
class CreateBooks < ActiveRecord::Migration[7.0]
 def change
   create_table :books do |t|
    t.string :title
    t.date :publishing_year
    t.references :author, foreign_key: true
    t.timestamps
   end
 end
end

#Complete the following migrations to create your e-library database.

class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :email
      t.timestamps
    end
  end
end

#Complete the following migrations to create your e-library database.
class CreateReadings < ActiveRecord::Migration[7.0]
  def change
    create_table :readings do |t|
      t.date :reading_date
      t.references :user, foreign_key: true
      t.references :book, foreign_key: true
      t.timestamps
    end
  end
end

# Write a migration to add a category column to the books table.
class AddCategoryToBooks < ActiveRecord::Migration[7.0]
  def change
    add_column :books, :category, :string
  end
end

# Define each Active Record model with its associations for your database.
# Hint: We’re working with 4 tables: authors, books, users & readings. Therefore we need 4 models!


class Author
  has_many :books
end

class Book
  belongs_to :author
  has_many :readings
  has_many :users, through: :readings
end

class User
  has_many :readings
  has_many :books, through: :readings
end

class Reading
  belongs_to :user
  belongs_to :book
end


#1. Add your favorite author to the DB
jules_verne = Author.new(name: "Jules Verne")
jules_verne.save

Author.create(name: "Jules Verne")

#2. Get all authors
Author.all

#3. Get author with id=8
Author.find(8)

#4. Get author with name="Jules Verne", store it in a variable: jules
jules_verne = Author.find_by(name: "Jules Verne")
#5. Get Jules Verne's books
jules_verne.books

#6. Create a new book "20000 Leagues under the Seas". Store it in a variable: twenty_thousand
twenty_thousand = Book.new(title: "20000 Leagues under the Seas", publishing_year: 1870)
#7. Add Jules Verne as this book's author
twenty_thousand.author = jules_vernes

#8. Now save this book in the DB!
twenty_thousand.save


# Add validations of your choice to the Author class.
class Author
  has_many :books
  validates :name, presence: true
end

class Book
  belongs_to :author
  validates :author, presence: true
end
