require "Ala/version"
require 'singleton'

module Ala

  class App
    attr_accessor :phone
    attr_reader :route

    def initialize(router)
      @phone=""
      @route = router
    end

    def find_cheapest(number=nil)
      phone= number || phone
      route.find_cheapest(phone)
    end

    def price
      route.price || "N/A"
    end

    def carrier
      route.carrier || "N/A"
    end
  end


  # This is dataloader for router
  # Gives an interface to load data
  # Can be replaced with FileRead API-endpoints
  class Loader


    def initialize
      @linesA = [
        ["1",     "0.9"],
        ["246",   "5.9"],
        ["46",    "0.17"],
        ["4620",  "0.0"],
        ["468",   "0.15"],
        ["4631",  "0.15"],
        ["4673",  "0.9"],
        ["46732", "1.1"]
      ]

      @linesB = [
        ["1",	 "0.92"],
        [ "44",	 "0.5"],
        ["46",	 "0.2"],
        ["467",	 "1.0"],
        ["48",	 "1.2"]
      ]
    end

    def first_operator
      @linesA
    end

    def second_operator
      @linesB
    end
  end



  class Router
    attr_accessor :list , :operators , :country_codes
    attr_reader :price, :carrier

    include Singleton


    def initialize
      @list= {}
      @country_codes = []
      @operators = []

      #it would have save some typing if country_codes named as prefix
      @matched_country_codes = []
      @max_matched_country_code = ""
      @price = nil
      @carrier=nil
    end

    def read(lines,operator)
      lines.each do |line|
        prefix, price = line
        add(prefix,operator,price)
      end
    end


    def add(prefix,operator,price)
      if @list.has_key?(prefix)
        @list[prefix].merge!({operator.to_sym => price })
      else
        @list[prefix] = {operator.to_sym => price }
      end
      @country_codes << prefix unless @country_codes.include?(prefix)
      @operators << operator unless @operators.include?(operator)
    end



    def country_prefix_for(phone_number)
      prefix_list = @country_codes.map do |prefix|
        Regexp.new("^#{prefix}").match(phone_number).to_s
      end
      prefix_list.compact.reject(&:empty?)
    end




    #@returns Array[ Symbol operator , String price ]
    def find_cheapest(phone_number)
      phone_number = PhoneNumber.clean(phone_number)
      return reset unless PhoneNumber.valid?(phone_number,self)
      @matched_country_codes = country_prefix_for(phone_number)
      @matched_country_codes.sort!{|x,y| y<=>x}
      @matched_country_codes
      @max_matched_country_code = @matched_country_codes.shift
      @matched_country_codes
      find
    end



    private #====================================================

    def reset
      @carrier = nil
      @price = nil
      [@carrier , @price]
    end

    def find
      data = {}

      data.merge!(@list[@max_matched_country_code])

      for operator in rest_operators
        for prefix in @matched_country_codes
          unless @list[prefix][operator].nil?
            data.merge!(@list[prefix])
            break
          end
        end
      end

      min_price = data.values.map(&:to_f).min
      @carrier, @price = data.select do |k,v|
        v.to_f == min_price
      end.flatten
    end


    def rest_operators
      @operators - @list[@max_matched_country_code].keys
    end

  end




  class PhoneNumber
    def self.clean(number)
      number.gsub(/[^0-9]/,"").gsub(/^0{1,2}/,"")
    end

    def self.valid?(number,router)
      !router.country_prefix_for(number).empty?
    end
  end

end


