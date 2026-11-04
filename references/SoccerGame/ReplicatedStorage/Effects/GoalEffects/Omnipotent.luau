  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage2 = game:GetService("ReplicatedStorage");
local Essentials = require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
local SoundManager = require(ReplicatedStorage.Shared.SoundManager);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
require(ReplicatedStorage2.Shared.LightingStorage);
local CutsceneUtils = require(ReplicatedStorage2.Modules.CutsceneUtils);
Random.new(os.clock());

return function(p1) -- Line: 14
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), Essentials (copy), TweenService (copy), VfxManager (copy), SoundManager (copy), CutsceneUtils (copy), ReplicatedStorage2 (copy)
    local LocalPlayer = game.Players.LocalPlayer;

    if LocalPlayer.Team == game.Teams.Visitor and (LocalPlayer.PlayerGui.Misc.CloseLimited.Visible == false and (LocalPlayer.PlayerGui.Customization.Enabled == false and not SpectatorController.IsSpectating)) then
        return;
    end;

    local u2 = ReplicatedStorage.Assets.GoalEffects.Omnipotent.Main:Clone();
    u2.Parent = workspace.Debris;
    u2.Main.CFrame = ReplicatedStorage.Assets.GoalEffects.Omnipotent.Main.Main.CFrame * CFrame.new(0, -50, 0);
    local u3 = ReplicatedStorage.Assets.GoalEffects.Omnipotent.Floor:Clone();
    u3.Parent = workspace.Debris;
    u3.Transparency = 1;
    u3:PivotTo(game.Workspace.Field.Field:GetPivot());
    game:GetService("TweenService"):Create(u2.Main, TweenInfo.new(0.75), {
        CFrame = ReplicatedStorage.Assets.GoalEffects.Omnipotent.Main.Main.CFrame
    }):Play();
    local Children = u2:GetChildren();
    local u4 = {};

    for _, v in Children do
        if v.Name ~= "Main" then
            local math_random_ret = math.random(0, 360);
            u4[v] = math.rad(math_random_ret);
        end;
    end;

    local u7 = game:GetService("RunService").RenderStepped:Connect(function(p5) -- Line: 37
        -- upvalues: Children (copy), u4 (copy)
        for _, v in Children do
            if v.Name ~= "Main" then
                local v6 = u4[v] + tick() * 4;
                v.Head.CFrame = CFrame.new(math.sin(v6) * 4, 13.393, 0);
            end;
        end;
    end);
    local Color = Essentials:GetInitialData(workspace.Field.Field, { "Color" }).Color;
    TweenService:Create(workspace.Field.Field, TweenInfo.new(1), {
        Color = Color3.fromRGB(0, 57, 84)
    }):Play();
    local u8 = ReplicatedStorage.Assets.GoalEffects.Omnipotent.VFX:Clone();
    u8.Parent = workspace.Debris;
    u8:PivotTo(p1.Pos);
    VfxManager.Emit(u8);
    VfxManager.Enable(u8, true);
    task.delay(1.2, function() -- Line: 53
        -- upvalues: VfxManager (ref), u8 (copy)
        VfxManager.Enable(u8, false);
    end);
    local u9 = ReplicatedStorage.Assets.GoalEffects.Omnipotent.OmnipotenceHand:Clone();
    u9.Parent = workspace.Debris;
    local Part = Instance.new("Part", workspace.Debris);
    Part.Transparency = 1;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Anchored = true;
    Part:PivotTo(p1.Pos);
    u9.Main.RootPart.MainWeld.Part0 = Part;
    local v10 = u9.Main.AnimationController.Animator:LoadAnimation(game.ReplicatedStorage.Assets.Emotes["Puppeteer Hand"]);
    v10.Looped = true;
    v10:Play();
    local Lighting = ReplicatedStorage.Assets.GoalEffects.Omnipotent.Lighting;
    game.Lighting.Atmosphere.Density = Lighting.Omnipotent.Density;
    game.Lighting.Atmosphere.Offset = Lighting.Omnipotent.Offset;
    game.Lighting.Atmosphere.Color = Lighting.Omnipotent.Color;
    game.Lighting.Atmosphere.Decay = Lighting.Omnipotent.Decay;
    game.Lighting.Atmosphere.Glare = Lighting.Omnipotent.Glare;
    game.Lighting.Atmosphere.Haze = Lighting.Omnipotent.Haze;
    SoundManager.SpawnSound("Amalgamation", 8, game.Workspace.Field.Field, 700, false);
    SoundManager.SpawnSound("Puppeteer", 8, game.Workspace.Field.Field, 700, false);
    task.delay(8, function() -- Line: 83
        -- upvalues: TweenService (ref), Color (copy), CutsceneUtils (ref), ReplicatedStorage2 (ref), u7 (ref), u2 (copy), u3 (copy), u9 (copy), Part (copy)
        TweenService:Create(workspace.Field.Field, TweenInfo.new(1), {
            Color = Color
        }):Play();
        CutsceneUtils.ChangeLighting(ReplicatedStorage2.Assets.MainLighting);
        u7:Disconnect();
        u2:Destroy();
        u3:Destroy();
        u9:Destroy();
        Part:Destroy();
    end);
end;