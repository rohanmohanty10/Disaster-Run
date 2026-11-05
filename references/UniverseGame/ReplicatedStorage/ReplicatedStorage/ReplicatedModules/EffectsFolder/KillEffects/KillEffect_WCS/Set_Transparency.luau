  

 

return function(p1, p2, p3, p4) -- Line: 1
    local v5 = typeof(p1) == "Instance" and { p1 } or p1;

    if typeof(p3) == "table" then
        p3 = TweenInfo.new(unpack(p3));
    end;

    for _, v in pairs(v5) do
        if v:IsA("BasePart") then
            if not v:GetAttribute("_OriginalTransparency") then
                v:SetAttribute("_OriginalTransparency", v.Transparency);
            end;

            local v6;

            if p2 == false or p2 == nil then
                v6 = v:GetAttribute("_OriginalTransparency") or v.Transparency;
            else
                v6 = p2;
            end;

            if p3 then
                if p3 then
                    local u7 = game:GetService("TweenService"):Create(v, p3, {
                        Transparency = v6
                    });
                    u7:Play();
                    task.spawn(function() -- Line: 24
                        -- upvalues: u7 (copy)
                        u7.Completed:Wait();
                        u7:Destroy();
                    end);
                end;
            else
                v.Transparency = v6;
            end;
        end;
    end;

    if p4 then
        task.wait(p3.Time);
        p4();
    end;
end;