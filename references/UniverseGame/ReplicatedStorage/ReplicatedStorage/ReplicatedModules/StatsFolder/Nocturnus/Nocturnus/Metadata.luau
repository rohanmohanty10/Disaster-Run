  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local _ = ReplicatedStorage.Remotes.Output;
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local Knit = require(PathShortcuts.KnitPath.Knit);
require(Knit.Util.TableUtil);
require(PathShortcuts.EnumsModule);
require(PathShortcuts.BaseStatsModule);
local ItemData = require(PathShortcuts.ReplicatedModules.ItemData);
local AssetHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Skins = ItemData.Skins;

return {
    PostRig = function(p1) -- Line: 19, Name: PostRig
        -- upvalues: Skins (copy), AssetHandler (copy), ParticleHandler (copy)
        local Character = p1.Character;
        local Player = p1.Player;
        local v2 = Player:IsA("Player") and Player.Data.Skin.Value;
        local v3 = Skins["SKIN_2555_" .. v2] and Skins["SKIN_2555_" .. v2].Name;
        local v4 = AssetHandler.GetAsset("Models/Claws", {
            AbilityName = "Nocturnus",
            SkinName = v3
        });
        local v5 = {
            ["Right Claw"] = CFrame.new(0.078, -1.114, 0.003) * CFrame.Angles(0, 3.141592653589793, 0),
            ["Left Claw"] = CFrame.new(-0.122, -1.114, 0.003)
        };
        local v6 = next;
        local v7, v8 = v4:GetChildren();

        for _, v in v6, v7, v8 do
            if v:IsA("BasePart") then
                local v9 = v:Clone();
                v9.Parent = Character;
                ParticleHandler.AttachTo(v9, {
                    MakePartP0 = true,
                    UseMotor6D = true,
                    Part = v9.Name == "Right Claw" and Character:FindFirstChild("Right Arm") or Character:FindFirstChild("Left Arm"),
                    Offset = v5[v9.Name]
                });
                local v10 = 0;

                if Player and Player.Data.Skin:GetAttribute("UnusualHueId") then
                    v10 = v10 + Player.Data.Skin:GetAttribute("UnusualHueId") * 5;
                end;

                local v11 = v3 or ParticleHandler.GetSkinInfo(v3);

                if v11 then
                    v11 = v11.Metadata;
                end;

                if v11 then
                    v11 = v11.HueShift or v11.HSVShift;
                end;

                local v12 = {
                    HueShift = v10 > 0 and v10 and v10 or (v11 or 0)
                };

                if v10 > 0 or v11 then
                    v9.Color = ParticleHandler.HSVShift(v9.Color, v12);
                    ParticleHandler.HSVShiftParticles(v9, v12);
                end;
            end;
        end;

        local v13 = v3 == "Nocturnus: Chainsaw Devil" and (Player and (Player:FindFirstChild("Settings") and (Player.Settings.CosmeticalChanges.Value and AssetHandler.GetAsset("Models/HeadAccessory", {
            AbilityName = "Nocturnus",
            SkinName = v3
        }))));

        if v13 then
            local v14 = v13:Clone();
            ParticleHandler.Unusualify(v14, {
                IncludeParts = true,
                IncludeSurfaces = true,
                Player = Player,
                Character = Character
            });
            v14.Parent = Character;
            ParticleHandler.AttachTo(v14, {
                MakePartP0 = true,
                Part = Character.Head
            });
            local v15 = next;
            local v16, v17 = Character:GetChildren();

            for _, v in v15, v16, v17 do
                if v:IsA("Accessory") and v.Handle.AccessoryWeld.Part1.Name == "Head" then
                    v:Destroy();
                end;
            end;
        end;
    end
};