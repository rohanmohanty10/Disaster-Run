  

 

return function(p1, p2, p3, p4) -- Line: 1
    if typeof(p1) == "Instance" then
        p1 = p1:GetDescendants();
    end;

    if typeof(p3) == "table" then
        p3 = TweenInfo.new(unpack(p3));
    end;

    for _, v in pairs(p1) do
        if v:IsA("BasePart") then
            if not v:GetAttribute("_OriginalTransparency") then
                v:SetAttribute("_OriginalTransparency", v.Transparency);
            end;

            local v5;

            if p2 == false or p2 == nil then
                v5 = v:GetAttribute("_OriginalTransparency") or v.Transparency;
            else
                v5 = p2;
            end;

            if p3 then
                if p3 then
                    local u6 = game:GetService("TweenService"):Create(v, p3, {
                        Transparency = v5
                    });
                    u6:Play();
                    task.spawn(function() -- Line: 24
                        -- upvalues: u6 (copy)
                        u6.Completed:Wait();
                        u6:Destroy();
                    end);
                end;
            else
                v.Transparency = v5;
            end;
        end;
    end;

    if p4 then
        task.wait(p3.Time);
        p4();
    end;
end;