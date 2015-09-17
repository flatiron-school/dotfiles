class Object

  def lm
    (self.methods - Object.methods).sort
  end

  def lim
    (self.instance_methods - Object.instance_methods).sort
  end

end