  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.Trove);
local u1 = nil;

return {
    Init = function(u2) -- Line: 21, Name: Init
        -- upvalues: u1 (ref)
        function u2.GetCooldownFolder(p3) -- Line: 22
            -- upvalues: u2 (copy)
            local v4 = u2.GetCharacter(p3);
            local Player = v4.Player;
            local Character = v4.Character;
            local v5 = Player and Player:FindFirstChild("Cooldowns");

            if v5 then
                Character = v5;
            elseif Character then
                Character = Character:FindFirstChild("Cooldowns");
            end;

            return Character;
        end;

        function u2.CreateCooldown(p6, p7) -- Line: 29
            -- upvalues: u2 (copy), u1 (ref)
            if p6:GetAttribute("URF") then
                return;
            end;

            local v8 = p7 or {};
            local v9 = u2.GetCharacter(p6);
            local _ = v9.Player;
            local Character = v9.Character;
            local v10 = u2.GetCooldownFolder(Character);

            if v10 then
                local _ = v8.Name or "[UNKNOWN]";
                local Time = v8.Time;
                local v11 = u1:GetContainer(Character);

                if v11 then
                    local v12 = u1:GetMax(v11, "CooldownMultiplier");
                    local v13 = u1:GetMin(v11, "CooldownReduction");

                    if type(v12) == "number" then
                        Time = Time * v12;
                    end;

                    if type(v13) == "number" then
                        Time = Time * v13;
                    end;
                end;

                local StringValue = Instance.new("StringValue");
                StringValue.Name = v8.Name;
                StringValue:SetAttribute("Start", os.clock());

                if Time then
                    StringValue:SetAttribute("Duration", Time);
                    task.delay(Time, function() -- Line: 58
                        -- upvalues: StringValue (copy)
                        if StringValue then
                            StringValue:Destroy();
                        end;
                    end);
                end;

                StringValue.Parent = v10;

                return StringValue;
            end;
        end;

        function u2.GetCooldown(p14, p15) -- Line: 70
            -- upvalues: u2 (copy)
            local v16 = p15 or {};
            local v17 = typeof(v16) == "string" and {
                Name = v16
            } or v16;

            if v17.Name then
                return u2.GetCooldownFolder(p14):FindFirstChild(v17.Name);
            end;
        end;
    end,

    Start = function(p18) -- Line: 86, Name: Start
        -- upvalues: u1 (ref), Knit (copy)
        u1 = require(Knit.ReplicatedModules:WaitForChild("Independent"):WaitForChild("TagService"));
    end
};