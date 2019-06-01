require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    @db_headers ||= DBConnection.execute2(<<-SQL)
      SELECT
        * 
      FROM 
        cats
      LIMIT
        0
    SQL
    @db_headers.first.map{|header| header.to_sym}
  end

  def self.finalize!
    columns.each do |col|
      define_method(col) {
        attributes[col]
      }

      define_method("#{col}=") {|val| 
        attributes[col] = val
      }
    end
  end

  def self.table_name=(table_name)
    return table_name 
  end

  def self.table_name
    return self.to_s.downcase + 's'
  end

  def self.all
    all_rows = DBConnection.execute(<<-SQL)
      SELECT
        * 
      FROM 
        cats
    SQL
    return all_rows
  end

  def self.parse_all(results)
    results.each do |result|
      result = result.to_h
    end
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.keys.each do |key|  
      key = key.to_sym 
      raise "unknown attribute '#{key}'" unless self.class.columns.include?(key)  
      
      self.send("#{key}=", params[key])
    end
  end

  def attributes
    @attributes ||= {} 
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
