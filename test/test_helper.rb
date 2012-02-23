require 'test/unit'
$:.unshift File.expand_path("../../lib", __FILE__)
require 'Ala'

def load_router
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
    router = Ala::Router.instance
    router.read(@linesA, :A)
    router.read(@linesB, :B)
end

load_router
