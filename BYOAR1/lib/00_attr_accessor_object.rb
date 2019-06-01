# We are defining a CLASS INSTANCE METHOD my_attr_accessor 
# in our AttrAccessorObject Class 

# names is an array of symbols right?? 
class AttrAccessorObject
  def self.my_attr_accessor(*names) 
    names = names.map{|name| name.to_s}
    names.each do |name|
      define_method(name) {
        instance_variable_get("@#{name}")
      }
    end

    names.each do |name| 
      define_method("#{name}=") do |x| 
        instance_variable_set("@#{name}", x)
      end
    end
  end

end
