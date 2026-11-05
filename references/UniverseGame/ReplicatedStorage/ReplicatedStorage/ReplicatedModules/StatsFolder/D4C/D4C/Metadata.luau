  

 

local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
require(PathShortcuts.KnitPath.Knit);
local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Skins = ItemData.Skins;

return {
    PostRig = function(p1) -- Line: 11, Name: PostRig
        -- upvalues: Skins (copy), AssetHandler (copy), ParticleHandler (copy)
        local Character = p1.Character;
        local Player = p1.Player;
        local v2 = Player:IsA("Player") and Player.Data.Skin.Value;
        print(v2);
        local v3 = Skins["SKIN_70_" .. v2] and Skins["SKIN_70_" .. v2].Name;
        print(v3);
        local v4 = AssetHandler.CloneAsset("Models/Knife", {
            AbilityName = "D4C",
            SkinName = v3
        });
        v4.Parent = Character;
        ParticleHandler.AttachTo(v4, {
            MakePartP0 = true,
            UseMotor6D = true,
            Part = Character:FindFirstChild("Right Arm"),
            Offset = CFrame.new(0, -1.1, 0)
        });
    end
};