class Course 
    attr_accessor :cnum, :cname, :snum, :imode, :cAttr, :place, :time
    def initialize(cnum, cname)
        @cnum = cnum # course number like 3901
        @cname = cname # course name like Project: Design, Development, and Documentation of Web Applications
        @snum = nil #section number like 0040 (25212)
        @imode = nil # instruction mode like in person
        @cAttr = nil # course attribute like level 1
        @place = nil # place like Dreese Lab
        @time = nil # time like 5: 30 pm - 6: 50 pm
    end
end