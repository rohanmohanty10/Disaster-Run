 
 

local Players = game:GetService("Players");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local Knit = require(ReplicatedStorage.Packages.Knit);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local LocalPlayer = Players.LocalPlayer;
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: Knit (copy), ReplicatedStorage (copy), Debris (copy), VfxManager (copy), SfxManager (copy), LocalPlayer (copy), Lighting (copy), TweenService (copy)
    local Controller = Knit.GetController("MovementController");

    if not p2.Preview then
        local MapFolder = workspace:FindFirstChild("MapFolder");

        if MapFolder then
            MapFolder.Parent = ReplicatedStorage;
            task.delay(3, function() -- Line: 21
                -- upvalues: MapFolder (copy)
                if not workspace:FindFirstChild("MapFolder") then
                    MapFolder.Parent = workspace;
                end;
            end);
        end;

        local Courts2 = workspace:FindFirstChild("Courts2");

        if Courts2 then
            for _, descendant in Courts2:GetDescendants() do
                if descendant:IsA("BasePart") or descendant:IsA("Texture") then
                    local Transparency = descendant.Transparency;

                    if Transparency ~= 1 then
                        descendant.Transparency = 1;
                        task.delay(3, function() -- Line: 35
                            -- upvalues: descendant (copy), Transparency (copy)
                            descendant.Transparency = Transparency;
                        end);
                    end;
                end;
            end;
        end;

        local _, _, _ = p2.CFrame:ToOrientation();
        local v3 = script.Map:Clone();
        v3.Parent = Debris;
        v3:PivotTo(CFrame.new(0, 4, -297.5));
        VfxManager.DestroyEffect(v3, 3);
        SfxManager:playSound({
            Sound = "BBZ Tatlis Too Easy Cutscene",
            Parent = workspace
        }).TimePosition = 11.5;

        if LocalPlayer.Team ~= game.Teams.Visitor and LocalPlayer.Character ~= p2.Plr.Character then
            local YoureMineStun = ReplicatedStorage.Assets.StyleAnimations.Tatlis.YoureMineStun;
            local Character = LocalPlayer.Character;

            if Character then
                local u4 = Character:FindFirstChild("Humanoid"):LoadAnimation(YoureMineStun);
                u4:Play();
                Controller.States.Kneeling = true;
                task.delay(3, function() -- Line: 65
                    -- upvalues: Controller (copy), u4 (copy)
                    Controller.States.Kneeling = false;
                    u4:Stop();
                end);
            end;
        end;

        local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
        ColorCorrection.Enabled = false;
        local u5 = ColorCorrection:Clone();
        u5.Name = "CC";
        u5.Parent = Lighting;
        u5.Enabled = true;
        task.delay(4.85, function() -- Line: 81
            -- upvalues: u5 (copy), Lighting (ref), ColorCorrection (copy)
            u5:Destroy();

            if not Lighting:FindFirstChild("CC") then
                ColorCorrection.Enabled = true;
            end;
        end);
        local Bloom = Lighting:FindFirstChild("Bloom");
        Bloom.Enabled = false;
        local u6 = Bloom:Clone();
        u6.Name = "B";
        u6.Parent = Lighting;
        u6.Enabled = true;
        task.delay(0.7, function() -- Line: 96
            -- upvalues: u6 (copy), Lighting (ref), Bloom (copy)
            u6:Destroy();

            if not Lighting:FindFirstChild("B") then
                Bloom.Enabled = true;
            end;
        end);
        local u7 = script.FakeAtmo:Clone();
        u7.Parent = Lighting;
        task.delay(3, function() -- Line: 106
            -- upvalues: Lighting (ref), TweenService (ref), VfxManager (ref), u5 (copy), ColorCorrection (copy), u7 (copy)
            local BlurEffect = Instance.new("BlurEffect", Lighting);
            BlurEffect.Size = 35;
            TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
                Size = 0
            }):Play();
            VfxManager.DestroyEffect(BlurEffect, 0.7);
            u5.Brightness = 1;
            u5.Saturation = -1;
            u5.TintColor = Color3.fromRGB(55, 0, 7);
            TweenService:Create(u5, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
                TintColor = ColorCorrection.TintColor
            }):Play();
            TweenService:Create(u5, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
                Brightness = ColorCorrection.Brightness,
                Contrast = ColorCorrection.Contrast,
                Saturation = ColorCorrection.Saturation
            }):Play();
            u7:Destroy();
        end);
        local BlurEffect = Instance.new("BlurEffect", Lighting);
        BlurEffect.Size = 35;
        TweenService:Create(BlurEffect, TweenInfo.new(0.7, Enum.EasingStyle.Sine), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect, 0.7);
        u5.Brightness = 1;
        u5.Saturation = -1;
        u5.TintColor = Color3.fromRGB(55, 0, 7);
        TweenService:Create(u5, TweenInfo.new(0.85, Enum.EasingStyle.Sine), {
            TintColor = ColorCorrection.TintColor
        }):Play();
        TweenService:Create(u5, TweenInfo.new(0.35, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            Contrast = ColorCorrection.Contrast,
            Saturation = ColorCorrection.Saturation
        }):Play();
    end;
end;