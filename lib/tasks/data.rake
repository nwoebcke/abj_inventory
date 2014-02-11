namespace :data do
  desc "import data from old ABJ database to Ruby database"
  task :import_prodlines => :environment do
    file = File.open("./lib/tasks/data/prodlines.csv")
    file.each_with_index do |line, i|
      next if i == 0
      attrs = []
      attrs_outer = line.split("|")
      attrs_outer.each do |val|  
        newval = /\"(.+)\"/.match(val)
        if newval && newval.length > 1
          attrs << newval[1]
        else
          attrs << ""
        end
      end
      p = ProductLine.new(:old_id => attrs[0], :description => attrs[1], :notes => attrs[2], :prefix => attrs[3])
      p.save!
    end
  end

  task :import_customers => :environment do
    require 'csv'
    CSV.foreach('./lib/tasks/data/customers.csv', :headers => true) do |row|
      cust = Customer.new(:old_id => row[0], :name => row[1], :address => row[2])
      city_state_zip = /(.+)[,]*\s+(\w+)[,]*\s+(\d*[-\d+]*)/.match(row[3])
      if city_state_zip.nil?
        cust.city = row[3]
      else
        cust.city = city_state_zip[1] unless city_state_zip[1].nil?
        cust.state = city_state_zip[2] unless city_state_zip[2].nil?
        cust.zip = city_state_zip[3] unless city_state_zip[3].nil?
      end
      cust.fax = row[4] unless row[4].nil?
      cust.phone = row[5] unless row[5].nil?
      cust.save!
    end
  end

  task :import_customer_prodlines => :environment do
    require 'csv'
    CSV.foreach('./lib/tasks/data/vendor_matrix.csv', :headers => true) do |row|
      cust = Customer.find_by_old_id(row[0]) unless row[0].nil?
      cpl = CustomerProductLine.new(:name => row[1]) unless row[1].nil?
      pl = ProductLine.find_by_old_id(row[2]) unless row[2].nil?
      unless pl.nil? || cust.nil?
        cpl.customer = cust
        cpl.product_line = pl
        cpl.save!
      end
    end
  end

  task :import_parts_from_sales => :environment do
    require 'csv'
    connection = ActiveRecord::Base.establish_connection(
        :adapter => "mysql2", 
        :host => "localhost", 
        :database => "abj_ruby_development", 
        :username => "abj_ruby", 
        :password => "AbjIsGr8")

    prod_lines = connection.connection.execute("SELECT old_id, id FROM product_lines").to_a
    pl_ids = Hash.new
    prod_lines.each do |pl|
      pl_ids[pl[0]] = pl[1]
    end
    cnt = 0
    sql_start = "INSERT INTO parts_from_sales (product_line_id, part_num, description, created_at, updated_at) VALUES "
    sql = sql_start
    CSV.foreach('./lib/tasks/data/sales_history.csv', :headers => true) do |row|
      unless row["part_num"].nil?
        values = Array.new
        values << pl_ids[row["prod_line"].to_i].to_s
        values += row.to_a.map{|keyval| keyval[1] }.slice(2..3)
        # puts "values: " + values.to_s
        sql += ", " if cnt > 0
        sql += " (" + values.map{|v| v.nil? ? "NULL" : ("'" + v + "'") }.join(", ") + ", NOW(), NOW())"
        cnt += 1
        # break if cnt > 20
        if cnt > 500
          connection.connection.execute(sql)
          sql = sql_start
          cnt = 0
        end
      end
    end
    # puts sql
    if cnt > 0
      connection.connection.execute(sql)
    end
  end

  task :import_parts_from_prices => :environment do
    require 'csv'
    connection = ActiveRecord::Base.establish_connection(
        :adapter => "mysql2", 
        :host => "localhost", 
        :database => "abj_ruby_development", 
        :username => "abj_ruby", 
        :password => "AbjIsGr8")

    prod_lines = connection.connection.execute("SELECT old_id, id FROM product_lines").to_a
    pl_ids = Hash.new
    prod_lines.each do |pl|
      pl_ids[pl[0]] = pl[1]
    end
    cnt = 0
    sql_start = "INSERT INTO parts_from_prices(part_num, product_line_id, price0, price1, price2, price3, price4, price5) VALUES "
    sql = sql_start
    CSV.foreach('./lib/tasks/data/prices.csv', :headers => true) do |row|
      unless row["part_num"].nil?
        values = Array.new
        values << row["part_num"]
        values << pl_ids[row["prod_line"].to_i].to_s
        values += row.to_a.map{|keyval| keyval[1] }.slice(2..7)
        sql += "," if cnt > 0
        sql += " (" + values.map{|v| v.nil? ? "NULL" : ("'" + v + "'") }.join(", ") + ")"
        cnt += 1
        if cnt > 500
          connection.connection.execute(sql)
          sql = sql_start
          cnt = 0
        end
      end
    end
    if cnt > 0
      connection.connection.execute(sql)
    end
  end

  task :merge_parts => :environment do
    require 'csv'

    connection = ActiveRecord::Base.establish_connection(
        :adapter => "mysql2", 
        :host => "localhost", 
        :database => "abj_ruby_development", 
        :username => "abj_ruby", 
        :password => "AbjIsGr8")
    sql = "DELETE FROM parts"
    connection.connection.execute(sql)
    sql = "ALTER TABLE parts AUTO_INCREMENT = 1"
    connection.connection.execute(sql)
    sql = "INSERT INTO parts(product_line_id, part_num, description, " + 
                          "price0, price1, price2, price3, price4, price5, created_at, updated_at)" +
          "SELECT ps.product_line_id, ps.part_num, ps.description, pp.price0, pp.price1, pp.price2, " +
                "pp.price3, pp.price4, pp.price5, ps.created_at, ps.updated_at " +
          "FROM parts_from_sales AS ps LEFT JOIN " +
                "parts_from_prices AS pp ON pp.part_num = ps.part_num"
    connection.connection.execute(sql)
  end
end