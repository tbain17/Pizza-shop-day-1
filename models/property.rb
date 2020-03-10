require("pg")
class Property
  attr_accessor :address, :property_value, :number_bedrooms, :year_built
  attr_reader :id

  def initialize(property_info)
    @id = property_info["id"].to_i if property_info["id"]
    @address = property_info["address"]
    @property_value = property_info["property_value"].to_i
    @number_bedrooms = property_info["number_bedrooms"].to_i
    @year_built = property_info["year_built"].to_i
  end

  def save()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = " INSERT INTO property_tracker (address, property_value, number_bedrooms, year_built) VALUES ($1, $2, $3, $4) RETURNING *"
    values = [@address, @property_value, @number_bedrooms, @year_built]
    db.prepare("save", sql)
    @id = db.exec_prepared("save", values)[0]["id"].to_i
    db.close()
  end

  def update()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "UPDATE property_tracker
    SET(
      address,
      property_value,
      number_bedrooms,
      year_built
    ) = (
      $1,
      $2,
      $3,
      $4
    )
    WHERE id = $5"
    values = [@address, @property_value, @number_bedrooms, @year_built, @id]
    db.prepare("update", sql)
    db.exec_prepared("update", values)
    db.close()
  end

  def Property.all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM property_tracker"
    db.prepare("all", sql)
    properties = db.exec_prepared("all")
    db.close()
    return properties.map {|property| Property.new(property)}
  end

  def delete()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM property_tracker WHERE id = $1"
    values = [@id]
    db.prepare("delete_one", sql)
    db.exec_prepared("delete_one", values)
    db.close()
  end

  def Property.delete_all()
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "DELETE FROM property_tracker"
    db.prepare("delete_all", sql)
    db.exec_prepared("delete_all")
    db.close()
  end

  def Property.find(id_number)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM property_tracker WHERE id = $1"
    values = [id_number]
    db.prepare("find", sql)
    property_data = db.exec_prepared("find", values)[0]
    db.close()
    Property.new(property_data)
  end

  def Property.find_by_address(address)
    db = PG.connect({dbname: "property_tracker", host: "localhost"})
    sql = "SELECT * FROM property_tracker WHERE address = $1"
    values = [address]
    db.prepare("find_by_address", sql)
    property_data = db.exec_prepared("find_by_address", values)[0]
    db.close()
    Property.new(property_data)
  end

end
#
# 9. Implement a `find` method that returns one instance of your class when an id is passed in.
# 10. Implement a `find_by_address` method that returns one instance of your class when a name is passed in, or nil if no instance is found.
