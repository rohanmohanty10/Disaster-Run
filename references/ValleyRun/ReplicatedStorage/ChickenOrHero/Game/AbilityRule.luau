 

 

local Session = script.Parent:WaitForChild("Session");
local u3 = {
    blocked = function(p1) -- Line: 10, Name: blocked
        -- upvalues: Session (copy)
        if Session:GetAttribute("NoAbilities") == true then
            return true;
        end;

        local Attribute = Session:GetAttribute("AbilitiesFor");

        if type(Attribute) ~= "string" or (p1 == nil or p1.GetAttribute == nil) then
            return false;
        end;

        local Attribute2 = p1:GetAttribute("GameRole");
        local v2;

        if Attribute2 == "Runner" or Attribute2 == "Catcher" then
            v2 = Attribute2 ~= Attribute;
        else
            v2 = false;
        end;

        return v2;
    end
};

function u3.knifeBlocked(p4) -- Line: 24
    -- upvalues: Session (copy), u3 (copy)
    return Session:GetAttribute("Ranked") == true and true or u3.blocked(p4);
end;

function u3.watch(p5, p6) -- Line: 29
    -- upvalues: Session (copy)
    return {
        Session:GetAttributeChangedSignal("NoAbilities"):Connect(p6),
        Session:GetAttributeChangedSignal("AbilitiesFor"):Connect(p6),
        Session:GetAttributeChangedSignal("Ranked"):Connect(p6),
        p5:GetAttributeChangedSignal("GameRole"):Connect(p6)
    };
end;

return u3;