// Copyright 2022 Steamcord LLC
function Steamcord.Utils.BuilderAccessor(tbl, humanName, internalVar)
    tbl[ "Set" .. humanName] = function(self,  val)
        self[internalVar] = val
        return self
    end

    tbl[ "Get" .. humanName] = function(self)
        return self[internalVar]
    end
end