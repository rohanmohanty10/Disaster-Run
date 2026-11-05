  

 

local u1 = {};
local Debris = game:GetService("Debris");
game:GetService("TweenService");
game:GetService("CollectionService");
local _ = game:GetService("ReplicatedStorage").Remotes.Output;
local BezierModule = require(script.BezierModule);

function u1.CreateObject(p2, p3) -- Line: 12
    local function CheckProperty(p4, p5) -- Line: 14
        local _ = p4[p5];
    end;

    local u6 = Instance.new(p2);

    for i, v in pairs(p3) do
        if pcall(function() -- Line: 21
            -- upvalues: u6 (copy), i (copy)
            local _ = u6[i];
        end) then
            u6[i] = v;
        end;
    end;

    return u6;
end;

function u1.CreateBezierCurve(p7, p8, p9, p10) -- Line: 30
    -- upvalues: u1 (copy), Debris (copy), BezierModule (copy)
    local v11 = {};
    local v12 = u1.CreateObject("Folder", {
        Name = "BezierPath",
        Parent = workspace.Effects
    });
    Debris:AddItem(v12, 0.5);
    local v13 = BezierModule(p7, p8, p9, p10);

    if v13 then
        for i = 1, #v13 do
            if v13[i + 1] then
                local v14 = v13[i];
                local v15 = v13[i + 1];
                local Magnitude = (v15 - v14).Magnitude;
                local v16 = u1.CreateObject("Part", {
                    Anchored = true,
                    CanCollide = false,
                    Massless = false,
                    Transparency = 1,
                    Name = "BezierPart" .. i,
                    Position = v14,
                    Size = Vector3.new(0.3, 0.3, Magnitude),
                    Parent = v12
                });
                v16.CFrame = CFrame.new(v16.CFrame.Position, v15) * CFrame.new(0, 0, -Magnitude / 2);
                Debris:AddItem(v16, 0.5);
                table.insert(v11, v16);
            end;
        end;
    end;

    return v11;
end;

return u1;