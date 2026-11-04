 

 

return {
    music = function(p1, p2) -- Line: 3, Name: music
        return (p2 == "Lobby" or (p1 == "Lobby" or p1 == "Countdown")) and "LobbyMusic" or "MatchMusic";
    end,

    surface = function(p3, p4, p5) -- Line: 6, Name: surface
        if p4 then
            local Attribute = p4:GetAttribute("AudioSurface");

            if type(Attribute) == "string" and Attribute ~= "" then
                return Attribute;
            end;

            if p4.Name == "Grass" then
                return "Grass";
            end;
        end;

        local v6 = p5.Materials[p3.Name];

        if v6 then
            return v6;
        end;

        if p4 then
            p4 = p4.Parent;
        end;

        while p4 and p4 ~= workspace do
            local Attribute = p4:GetAttribute("AudioSurface");

            if type(Attribute) == "string" and Attribute ~= "" then
                return Attribute;
            end;

            p4 = p4.Parent;
        end;

        return p5.DefaultSurface;
    end,

    crossed = function(p7, p8, p9) -- Line: 23, Name: crossed
        if p7 == nil then
            return false;
        end;

        for _, v in p9 do
            if p7 <= p8 then
                if p7 < v and v <= p8 then
                    return true;
                end;
            elseif p7 < v or v <= p8 then
                return true;
            end;
        end;

        return false;
    end
};