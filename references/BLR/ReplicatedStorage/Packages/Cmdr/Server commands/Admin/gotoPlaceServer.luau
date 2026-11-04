  

local TeleportService = game:GetService("TeleportService");

return function(p1, p2, p3, p4) -- Line: 3
    -- upvalues: TeleportService (copy)
    local v5 = p2 or { p1.Executor };

    if p3 <= 0 then
        return "Invalid place ID";
    end;

    if p4 == "-" then
        return "Invalid job ID";
    end;

    p1:Reply("Commencing teleport...");

    if p4 then
        for _, v in ipairs(v5) do
            v:SetAttribute("TeleportingToPlace", true);
            TeleportService:TeleportToPlaceInstance(p3, p4, v);
        end;
    else
        for _, v in v5 do
            v:SetAttribute("TeleportingToPlace", true);
        end;

        TeleportService:TeleportAsync(p3, v5);
    end;

    return "Teleported.";
end;