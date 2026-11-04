  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
local game_Lighting = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);

return function(u1) -- Line: 14
    -- upvalues: SpectatorController (copy), ReplicatedStorage (copy), TweenService (copy), game_Lighting (copy), VfxManager (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local GyroShotNew = ReplicatedStorage.Assets.Vfx.GyroShotNew;
    local Character = u1.Plr.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local PlrFootball = Character:FindFirstChild("PlrFootball");
    local v2;

    if PlrFootball then
        v2 = PlrFootball.BallAnims.BALL;
    else
        v2 = nil;
    end;

    local NagiCam = workspace:FindFirstChild("NagiCam");

    if NagiCam then
        task.spawn(function() -- Line: 29
            -- upvalues: NagiCam (copy), Character (copy)
            NagiCam.PrimaryPart.CFrame = Character.HumanoidRootPart.CFrame * CFrame.new(0, -3.2, 0) * CFrame.fromEulerAnglesXYZ(0, 3.141592653589793, 0);
        end);
    end;

    TweenService:Create(game_Lighting.Atmosphere, TweenInfo.new(1.8), {
        Density = 0.3,
        Haze = 1,
        Color = Color3.fromRGB(199, 199, 199),
        Decay = Color3.fromRGB(223, 223, 223)
    }):Play();
    task.delay(7, function() -- Line: 41
        game.Lighting.Atmosphere.Density = 0.3;
        game.Lighting.Atmosphere.Glare = 5;
        game.Lighting.Atmosphere.Haze = 2;
        game.Lighting.Atmosphere.Offset = 0.5;
        game.Lighting.Atmosphere.Color = Color3.new(0.34902, 0.368627, 0.780392);
        game.Lighting.Atmosphere.Decay = Color3.new(0.192157, 0.196078, 0.388235);
    end);
    local u3 = GyroShotNew.camvfx:Clone();
    u3.Parent = Character;
    u3.CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.9, -1.9, -17);
    TweenService:Create(u3, TweenInfo.new(0.9), {
        CFrame = HumanoidRootPart.CFrame * CFrame.new(-0.9, -1.9, -1)
    }):Play();
    local u4 = {};

    for _, child in GyroShotNew.BALL:GetChildren() do
        local v5 = child:Clone();
        v5.Parent = v2;
        table.insert(u4, v5);
    end;

    u3["faster.."].Enabled = true;
    u3["gotta go fast"].Enabled = true;
    task.delay(0.2, function() -- Line: 67
        -- upvalues: u3 (copy)
        u3.FASTER.Enabled = true;
        u3["Faster.."].Enabled = true;
    end);
    task.delay(1.1, function() -- Line: 72
        -- upvalues: u3 (copy)
        u3.FASTER.Enabled = false;
        u3["gotta go fast"].Enabled = false;
        u3["faster.."].Enabled = false;
        u3["Faster.."].Enabled = false;
        task.wait(0.2);
        u3:Destroy();
    end);
    task.delay(5, function() -- Line: 81
        -- upvalues: GyroShotNew (copy), Character (copy), u4 (ref), VfxManager (ref)
        local u6 = GyroShotNew.RootPartEffects.Kick:Clone();
        u6.Parent = Character.HumanoidRootPart;

        for _, v in u4 do
            if v then
                v:Destroy();
            end;
        end;

        table.clear(u4);
        u4 = nil;
        VfxManager.Emit(u6);
        task.delay(2.5, function() -- Line: 94
            -- upvalues: u6 (copy)
            u6:Destroy();
        end);
    end);
    local u7 = GyroShotNew.RootPartEffects.grass:Clone();
    u7.Parent = HumanoidRootPart;
    local u8 = GyroShotNew.RootPartEffects.grasss:Clone();
    u8.Parent = HumanoidRootPart;
    task.delay(0.5, function() -- Line: 102
        -- upvalues: VfxManager (ref), u7 (copy), TweenService (ref), u8 (copy)
        VfxManager.Emit(u7);

        for _, child in u7:GetChildren() do
            TweenService:Create(child, TweenInfo.new(0.5), {
                TimeScale = 0.365
            }):Play();
        end;

        VfxManager.Emit(u8);

        for _, child in u8:GetChildren() do
            TweenService:Create(child, TweenInfo.new(0.5), {
                TimeScale = 0.365
            }):Play();
        end;
    end);
    local u9 = nil;
    task.delay(3.6, function() -- Line: 115
        -- upvalues: u9 (ref), GyroShotNew (copy), HumanoidRootPart (copy)
        u9 = GyroShotNew.FG:Clone();
        u9.Parent = workspace.Debris;
        u9:PivotTo(HumanoidRootPart.CFrame * CFrame.new(15, -8.34, 1.78) * CFrame.Angles(0.17278759594743864, 1.5707963267948966, -1.5707963267948966));
        u9.b["Hi krie"].AW.Enabled = true;
        u9.b["Hi krie"].a3.Enabled = true;
    end);
    task.delay(5.1, function() -- Line: 123
        -- upvalues: u9 (ref)
        if u9 then
            u9:Destroy();
        end;
    end);
    task.spawn(function() -- Line: 129
        -- upvalues: GyroShotNew (copy), Character (copy)
        local Children = GyroShotNew.BodyParticles:GetChildren();

        for _, v in { "Head", "Left Arm", "Right Arm", "Torso", "Left Leg", "Right Leg" } do
            local v10 = v;

            for _, v3 in pairs(Children) do
                local v11 = v3:Clone();
                v11.Name = "FlowParticle";
                v11.Parent = Character[v10];
            end;
        end;

        table.clear(Children);
    end);
    task.delay(8.8, function() -- Line: 153
        -- upvalues: Character (copy), u1 (ref)
        task.spawn(function() -- Line: 154
            -- upvalues: Character (ref), u1 (ref)
            local Descendants = Character:GetDescendants();

            for _, v in Descendants do
                if v ~= nil and (v.Parent ~= nil and (v.Name == "FlowParticle" or v.Parent.Name == "FlowParticle")) then
                    if v.Parent:IsA("Attachment") then
                        v.Parent:Destroy();
                    else
                        v:Destroy();
                    end;
                end;
            end;

            table.clear(Descendants);
            table.clear(u1);
            u1 = nil;
        end);
    end);
end;