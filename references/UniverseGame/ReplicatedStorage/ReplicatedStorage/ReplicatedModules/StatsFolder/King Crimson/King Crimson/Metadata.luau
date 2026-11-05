  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
local Trove = require(Knit.Util.Trove);

return {
    PostRig = function(p1) -- Line: 6, Name: PostRig
        -- upvalues: Knit (copy), Trove (copy)
        local Player = p1.Player;
        local Character = p1.Character;

        if not (game:GetService("RunService"):IsServer() and Player) then
            return;
        end;

        local u2 = Knit.GetService("MoveIndicatorService");
        local v3 = Trove.new();
        v3:AttachToInstance(Character);

        local function MoveVisiblity(p4) -- Line: 16
            -- upvalues: u2 (copy), Player (copy)
            u2:SetStateVisible(Player, "Unlock", p4);
            u2:SetGroupVisible(Player, "Unlock", p4);
        end;

        if Player:FindFirstChild("PersonalUnlocker") then
            u2:SetStateVisible(Player, "Unlock", false);
            u2:SetGroupVisible(Player, "Unlock", false);
            task.delay(0.3, function() -- Line: 23
                -- upvalues: Character (copy), u2 (copy), Player (copy)
                if not (Character and Character.Parent) then
                    return;
                end;

                u2:SetStateVisible(Player, "Unlock", true);
                u2:SetGroupVisible(Player, "Unlock", true);
            end);
        end;

        v3:Connect(Player.ChildAdded, function(p5) -- Line: 28
            -- upvalues: u2 (copy), Player (copy)
            if p5:IsA("ValueBase") and p5.Name == "PersonalUnlocker" then
                u2:SetStateVisible(Player, "Unlock", true);
                u2:SetGroupVisible(Player, "Unlock", true);
            end;
        end);
        v3:Connect(Player.ChildRemoved, function(p6) -- Line: 33
            -- upvalues: u2 (copy), Player (copy)
            if p6:IsA("ValueBase") and p6.Name == "PersonalUnlocker" then
                u2:SetStateVisible(Player, "Unlock", false);
                u2:SetGroupVisible(Player, "Unlock", false);
            end;
        end);
    end
};