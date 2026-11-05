  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Core = require(game.ReplicatedStorage.ReplicatedRoot.Core);
require(Knit.Util.Trove);
local u1 = nil;
local v2 = {};

if Core.Context ~= "Client" then
    return v2;
end;

function v2.Init(u3) -- Line: 26
    -- upvalues: u1 (ref), PathShortcuts (copy)
    u1 = require(PathShortcuts.ReplicatedModules:WaitForChild("Independent"):WaitForChild("TagService"));

    function u3.GetCooldownFolder(p4) -- Line: 29
        -- upvalues: u3 (copy)
        local v5 = u3.GetCharacter(p4);
        local Player = v5.Player;
        local Character = v5.Character;
        local v6 = Player and Player:FindFirstChild("Cooldowns");

        if v6 then
            Character = v6;
        elseif Character then
            Character = Character:FindFirstChild("Cooldowns");
        end;

        return Character;
    end;

    function u3.CreateCooldown(p7, p8) -- Line: 36
        -- upvalues: u3 (copy), u1 (ref)
        if p7:GetAttribute("URF") then
            return;
        end;

        local v9 = p8 or {};
        local v10 = u3.GetCharacter(p7);
        local _ = v10.Player;
        local Character = v10.Character;
        local v11 = u3.GetCooldownFolder(Character);

        if v11 then
            local _ = v9.Name or "[UNKNOWN]";
            local Time = v9.Time;
            local v12 = u1:GetContainer(Character);

            if v12 then
                local v13 = u1:GetMax(v12, "CooldownMultiplier");
                local v14 = u1:GetMin(v12, "CooldownReduction");

                if type(v13) == "number" then
                    Time = Time * v13;
                end;

                if type(v14) == "number" then
                    Time = Time * v14;
                end;
            end;

            local StringValue = Instance.new("StringValue");
            StringValue.Name = v9.Name;
            StringValue:SetAttribute("Start", os.clock());

            if Time then
                StringValue:SetAttribute("Duration", Time);
                task.delay(Time, function() -- Line: 65
                    -- upvalues: StringValue (copy)
                    if StringValue then
                        StringValue:Destroy();
                    end;
                end);
            end;

            StringValue.Parent = v11;

            return StringValue;
        end;
    end;

    function u3.GetCooldown(p15, p16) -- Line: 77
        -- upvalues: u3 (copy)
        local v17 = p16 or {};
        local v18 = typeof(v17) == "string" and {
            Name = v17
        } or v17;

        if v18.Name then
            return u3.GetCooldownFolder(p15):FindFirstChild(v18.Name);
        end;
    end;
end;

return v2;