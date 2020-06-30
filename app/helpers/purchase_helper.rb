module PurchaseHelper
  def zipoutput(input)
    output = "#{input}"
    while output.length < 7 do 
    output = "0" + output
    end
    "#{output.slice(0..2)}-#{output.slice(3..6)}"
  end
end
