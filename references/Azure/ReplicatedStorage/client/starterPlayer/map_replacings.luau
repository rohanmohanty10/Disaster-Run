 

 

local v1 = {};
local Resources = game:GetService("ReplicatedStorage"):WaitForChild("Resources");

function v1.swap_crowds(p2: boolean) -- Line: 6
    -- upvalues: Resources (copy)
    local PotatoMaps = Resources:FindFirstChild("PotatoMaps");
    local map = workspace:FindFirstChild("map");

    if p2 ~= workspace:GetAttribute("PotatoMap") then
        if workspace:GetAttribute("11v11") then
            workspace:SetAttribute("PotatoMap", p2);
            local v3 = PotatoMaps:FindFirstChild("11v11"):FindFirstChild(p2 == true and "Potato" or "OriginalModel");
            local map2 = map:FindFirstChild("map");

            if map2 then
                local v4 = map2:FindFirstChild("Model") or map2.sanam:FindFirstChild("Model");

                if v4 then
                    v4:Destroy();
                end;

                local u5 = v3:Clone();
                u5.Name = "Model";

                if u5.PrimaryPart then
                    u5:PivotTo(map2.sanam.main.CFrame);
                end;

                u5.Parent = map2;
                u5.Destroying:Once(function() -- Line: 26
                    -- upvalues: u5 (ref)
                    u5 = nil;
                end);
            end;
        elseif not workspace:GetAttribute("gamemode") or workspace:GetAttribute("jolly") then
            workspace:SetAttribute("PotatoMap", p2);
            local v6 = PotatoMaps:FindFirstChild("5v5"):FindFirstChild(p2 == true and "Potato" or "OriginalModel");
            local map2 = map:FindFirstChild("map");

            if map2 then
                local v7 = map2:FindFirstChild("Model") or map2.sanam:FindFirstChild("Model");

                if v7 then
                    v7:Destroy();
                end;

                local u8 = v6:Clone();
                u8.Name = "Model";

                if u8.PrimaryPart then
                    u8:PivotTo(map2.sanam.main.CFrame);
                end;

                u8.Parent = map2;
                u8.Destroying:Once(function() -- Line: 46
                    -- upvalues: u8 (ref)
                    u8 = nil;
                end);
            end;
        end;
    end;
end;

function v1.delete_crowds(p9: boolean) -- Line: 55
    -- upvalues: Resources (copy)
    local PotatoMaps = Resources:FindFirstChild("PotatoMaps");
    local map = workspace:FindFirstChild("map");

    if p9 ~= workspace:GetAttribute("PotatoestMap") then
        if workspace:GetAttribute("11v11") then
            workspace:SetAttribute("PotatoestMap", p9);
            PotatoMaps:FindFirstChild("11v11"):FindFirstChild(p9 == true and "Potato" or "OriginalModel");
            local map2 = map:FindFirstChild("map");
            local v10 = map2 and (map2:FindFirstChild("Model") or map2.sanam:FindFirstChild("Model"));

            if v10 then
                v10:Destroy();
            end;
        elseif not workspace:GetAttribute("gamemode") or workspace:GetAttribute("jolly") then
            workspace:SetAttribute("PotatoestMap", p9);
            PotatoMaps:FindFirstChild("5v5"):FindFirstChild(p9 == true and "Potato" or "OriginalModel");
            local map2 = map:FindFirstChild("map");
            local v11 = map2 and (map2:FindFirstChild("Model") or map2.sanam:FindFirstChild("Model"));

            if v11 then
                v11:Destroy();
            end;
        end;
    end;
end;

return v1;