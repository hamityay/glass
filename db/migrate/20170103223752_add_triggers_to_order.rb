class AddTriggersToOrder < ActiveRecord::Migration
  def change

    execute <<-SQL
      CREATE FUNCTION upquantity() RETURNS TRIGGER AS $$
			BEGIN
				NEW.quantity = ( NEW.width * NEW.height * NEW.count / 1000000 );
			  RETURN NEW;
			END;$$
      LANGUAGE plpgsql;

			CREATE TRIGGER upquantitytrig
			AFTER INSERT OR UPDATE ON orders
			FOR EACH ROW
			EXECUTE PROCEDURE upquantity();
    SQL

  end
end
