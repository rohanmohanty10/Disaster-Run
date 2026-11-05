  

 

local TweenService = game:GetService("TweenService");

return function(u1, p2, p3, p4, p5, p6) -- Line: 3
    -- upvalues: TweenService (copy)
    local v7 = { "Quote Gui", "Quote" };
    local v8 = p2 or {};

    local function checkDoubleTransparency(p9) -- Line: 10
        p9.Transparency = p9.Transparency * 1;
    end;

    if type(u1) == "table" then
        for i = 1, #u1 do
            if p5 then
                if pcall(function() -- Line: 24
                    -- upvalues: u1 (copy), i (copy)
                    local v10 = u1[i];
                    v10.Transparency = v10.Transparency * 1;
                end) then
                    if p6 and p4 == 1 then
                        u1[i]:SetAttribute("OriginalTransparency", u1[i].Transparency);
                    end;

                    local v11 = u1[i];
                    local v12 = TweenInfo.new(p3);
                    local v13 = {};
                    local v14;

                    if p4 == 0 and p6 then
                        v14 = u1[i]:GetAttribute("OriginalTransparency") or p4;
                    else
                        v14 = p4;
                    end;

                    v13.Transparency = v14;
                    TweenService:Create(v11, v12, v13):Play();
                end;

                for _, descendant in pairs(u1[i]:GetDescendants()) do
                    if pcall(function() -- Line: 35
                        -- upvalues: descendant (copy)
                        local v15 = descendant;
                        v15.Transparency = v15.Transparency * 1;
                    end) and not (table.find(v8, descendant.Name) or (table.find(v7, descendant.Name) or (descendant:GetAttribute("IgnoreTransparency") or (descendant:IsA("ImageLabel") or descendant:IsA("TextLabel"))))) then
                        if p6 and p4 == 1 then
                            descendant:SetAttribute("OriginalTransparency", descendant.Transparency);
                        end;

                        local v16 = TweenInfo.new(p3);
                        local v17 = {};
                        local v18;

                        if p4 == 0 and p6 then
                            v18 = descendant:GetAttribute("OriginalTransparency") or p4;
                        else
                            v18 = p4;
                        end;

                        v17.Transparency = v18;
                        TweenService:Create(descendant, v16, v17):Play();
                    end;
                end;
            elseif pcall(function() -- Line: 17
                -- upvalues: u1 (copy), i (copy)
                local v19 = u1[i];
                v19.Transparency = v19.Transparency * 1;
            end) then
                TweenService:Create(u1[i], TweenInfo.new(p3), {
                    Transparency = p4
                }):Play();
            end;
        end;

        return;
    end;

    for _, descendant in pairs(u1:GetDescendants()) do
        if pcall(function() -- Line: 51
            -- upvalues: descendant (copy)
            local v20 = descendant;
            v20.Transparency = v20.Transparency * 1;
        end) and not (table.find(v8, descendant.Name) or (table.find(v7, descendant.Name) or (descendant:GetAttribute("IgnoreTransparency") or (descendant:IsA("ImageLabel") or descendant:IsA("TextLabel"))))) then
            TweenService:Create(descendant, TweenInfo.new(p3), {
                Transparency = p4
            }):Play();
        end;
    end;
end;