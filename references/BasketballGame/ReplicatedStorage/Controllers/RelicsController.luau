 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TextChatService");
local Players = game:GetService("Players");
local Knit = require(ReplicatedStorage.Packages.Knit);
local TopbarPlus = require(ReplicatedStorage.Shared.Utility.TopbarPlus);
local RelicsXYZ = ReplicatedStorage.Packages.RelicsXYZ;
local RelicsPlayer = require(RelicsXYZ.RelicsPlayer);
local Enums = require(RelicsXYZ.RelicsPlayer.Enums);
local v1 = Knit.CreateController({
    Name = "RelicsController"
});

function v1.KnitStart(p2) -- Line: 16
    -- upvalues: Knit (copy), Players (copy), RelicsPlayer (copy), TopbarPlus (copy), Enums (copy)
    local Controller = Knit.GetController("MusicController");
    local RelicsPlayer2 = Players.LocalPlayer.PlayerGui:WaitForChild("RelicsPlayer");
    local u3 = RelicsPlayer.new(RelicsPlayer2);
    u3:SetEnabled(true);
    local u4 = TopbarPlus.new():setName("Boombox"):setImage(136047345538409):autoDeselect(false):setEnabled(false):setImageScale(0.7):align("Right"):setOrder(999);
    u4.toggled:Connect(function(p5) -- Line: 33
        -- upvalues: u3 (copy)
        if p5 then
            u3:SetWindowState("Full");

            return;
        end;

        u3:SetWindowState("Hidden");
    end);
    u3.WindowStateChanged:Connect(function(p6) -- Line: 47
        -- upvalues: Enums (ref), u4 (copy)
        if p6 == Enums.WindowState.Hidden then
            u4:deselect();

            return;
        end;

        u4:select();
    end);
    local u7 = true;
    u3.PlayingChanged:Connect(function(p8) -- Line: 56
        -- upvalues: u7 (ref), Controller (copy)
        if u7 then
            u7 = false;

            return;
        end;

        Controller:SetMusicEnabled(not p8);
    end);
    u3.HasBoomboxChanged:Connect(function() -- Line: 41, Name: checkBoombox
        -- upvalues: u3 (copy), u4 (copy)
        if u3:UserHasBoombox() then
            u4:setEnabled(true);
        end;
    end);

    if u3:UserHasBoombox() then
        u4:setEnabled(true);
    end;
end;

return v1;