  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local u1 = {};
u1.__index = u1;
local Janitor = require(script:WaitForChild("Janitor"));

local function evalCS(p2, p3) -- Line: 10
    if p3 == 0 then
        return p2.Keypoints[1].Value;
    end;

    if p3 == 1 then
        return p2.Keypoints[#p2.Keypoints].Value;
    end;

    for i = 1, #p2.Keypoints - 1 do
        local v4 = p2.Keypoints[i];
        local v5 = p2.Keypoints[i + 1];

        if v4.Time <= p3 and p3 < v5.Time then
            local v6 = (p3 - v4.Time) / (v5.Time - v4.Time);

            return Color3.new((v5.Value.R - v4.Value.R) * v6 + v4.Value.R, (v5.Value.G - v4.Value.G) * v6 + v4.Value.G, (v5.Value.B - v4.Value.B) * v6 + v4.Value.B);
        end;
    end;
end;

function u1.new(p7, p8, p9) -- Line: 34
    -- upvalues: u1 (copy), Janitor (copy)
    local u10 = setmetatable({}, u1);
    u10.Model = p7;
    u10.Model:SetAttribute("Cycling", true);
    u10.Character = p9.Character;
    u10.Player = p9.Player;
    u10.Janitor = Janitor.new();
    u10.PartNames = p8 or {};
    u10.Parts = {};
    u10.Start = os.clock();
    u10.Last = 0;

    for _, descendant in pairs(u10.Model:GetDescendants()) do
        u10:Check(descendant);
    end;

    u10.Janitor:Add(u10.Model.DescendantAdded:Connect(function(p11) -- Line: 53
        -- upvalues: u10 (copy)
        u10:Check(p11);
    end));
    u10.Janitor:Add(game:GetService("RunService").RenderStepped:Connect(function(p12) -- Line: 57
        -- upvalues: u10 (copy)
        u10:Update();
    end));
    u10.Janitor:LinkToInstance(u10.Model);
    u10.Janitor:Add(function() -- Line: 62
        -- upvalues: u10 (copy)
        u10.Model:SetAttribute("Cycling", false);
        u10:Destroy();
    end);

    return u10;
end;

function u1.GetTime(p13, p14) -- Line: 70
    return (os.clock() - p13.Start) / (p14 or 1);
end;

function u1.Check(p15, p16) -- Line: 74
    if p16:IsA("BasePart") and (table.find(p15.PartNames, p16.Name) and not table.find(p15.Parts, p16)) then
        table.insert(p15.Parts, p16);
    end;
end;

function u1.Update(p17) -- Line: 80
    -- upvalues: ParticleHandler (copy), evalCS (copy)
    if os.clock() - p17.Last >= 0.03333333333333333 then
        p17.Last = os.clock();
        local v18 = p17.Model:GetAttribute("Gradient");
        local v19 = p17.Model:GetAttribute("Time");
        local v20 = p17.Model:GetAttribute("Pattern");
        local v21 = ParticleHandler.GetUnusualHSVData({
            Player = p17.Player,
            Character = p17.Character
        });

        if v21 ~= nil then
            v18 = ParticleHandler.HSVShift(v18, v21);
        end;

        for _, v in pairs(p17.Parts) do
            local v22 = v:GetAttribute("Offset") or 0;
            local v23 = (p17:GetTime(v19) + v22) % 1;

            if p17.Model:GetAttribute("Reverse") then
                v23 = 1 - v23;
            end;

            if v20 then
                v23 = v23 / v20 % 1;
            end;

            v.Color = evalCS(v18, v23);
        end;
    end;
end;

function u1.Destroy(p24) -- Line: 114
    if p24.Janitor and p24.Janitor.Destroy then
        p24.Janitor:Destroy();
    end;

    setmetatable(p24, nil);
end;

return u1;