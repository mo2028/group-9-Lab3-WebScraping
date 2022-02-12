class Course 
    attr_accessor :cnum, :cname, :snum, :cid, :imode, :cAttr, :place, :time
    def initialize(cnum)
        @cnum = cnum
        @cname = nil
        @snum = nil
        @cid = nil
        @imode = nil
        @cAttr = nil
        @place = nil
        @time = nil
    end
end