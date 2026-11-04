 

 

local Players = game:GetService("Players");
local v1 = {};
local u2;

if game:GetService("RunService"):IsClient() and require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots == true then
    u2 = require(script.Parent.Parent:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u2 = nil;
end;

function v1.list() -- Line: 9
    -- upvalues: Players (copy), u2 (copy)
    local Players2 = Players:GetPlayers();

    if u2 then
        for _, v in u2.list() do
            if v.record:GetAttribute("IsBot") == true then
                table.insert(Players2, v);
            end;
        end;

        return Players2;
    end;

    local Bots = script.Parent.Parent:FindFirstChild("Bots");

    if Bots then
        Bots = Bots:FindFirstChild("Actors");
    end;

    if Bots then
        for _, child in Bots:GetChildren() do
            if child:GetAttribute("IsBot") == true then
                local Character = child:FindFirstChild("Character");
                local v3 = {
                    IsBot = true,
                    UserId = child:GetAttribute("UserId"),
                    DisplayName = child:GetAttribute("DisplayName"),
                    Name = child.Name
                };

                if Character then
                    Character = Character.Value;
                end;

                v3.Character = Character;

                function v3.GetAttribute(p4, p5) -- Line: 23
                    -- upvalues: child (copy)
                    return child:GetAttribute(p5);
                end;

                table.insert(Players2, v3);
            end;
        end;
    end;

    return Players2;
end;

return v1;