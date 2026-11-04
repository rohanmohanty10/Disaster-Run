  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Debris");
game:GetService("RunService");
require(ReplicatedStorage.Shared.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);

local function EmitAll(p1) -- Line: 11
    for _, descendant in pairs(p1:GetDescendants()) do
        if descendant:IsA("ParticleEmitter") then
            task.spawn(function() -- Line: 14
                -- upvalues: descendant (copy)
                if descendant:GetAttribute("EmitCount") then
                    descendant:Emit(descendant:GetAttribute("EmitCount"));
                end;

                if descendant:GetAttribute("EmitDuration") then
                    descendant.Enabled = true;
                    task.wait(descendant:GetAttribute("EmitDuration"));
                    descendant.Enabled = false;
                end;
            end);
        end;
    end;
end;

local function EmitBeam(p2, u3) -- Line: 29
    -- upvalues: TweenService (copy)
    for _, descendant in pairs(p2:GetDescendants()) do
        if descendant:IsA("Beam") then
            print(descendant);
            local Width0 = descendant.Width0;
            local Width1 = descendant.Width1;
            descendant.Width0 = 0;
            descendant.Width1 = 0;
            descendant.Enabled = true;
            TweenService:Create(descendant, TweenInfo.new(0.25), {
                Width0 = Width0,
                Width1 = Width1
            }):Play();
            task.delay(u3, function() -- Line: 43
                -- upvalues: TweenService (ref), descendant (copy), u3 (copy)
                TweenService:Create(descendant, TweenInfo.new(u3 / 2), {
                    Width0 = 0,
                    Width1 = 0
                }):Play();
            end);
        end;
    end;
end;

local u4 = { "Right Leg", "Right Arm", "Left Leg", "Left Arm" };

return function(p5) -- Line: 54
    -- upvalues: u4 (copy), VfxManager (copy), ReplicatedStorage (copy), TweenService (copy)
    local Char = p5.Char;
    local HumanoidRootPart = Char.HumanoidRootPart;
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u6 = {};
    local ClockTime = game.Lighting.ClockTime;
    local u7 = {};
    tick();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local u8 = 0;
    local Players = game:GetService("Players");
    local Values = Players.LocalPlayer.Character.Values;

    if not (Values.Goalie.Value or (Values.IsInPenalty.Value or Players.LocalPlayer.Team == game.Teams.Visitor)) then
        local u9 = nil;
        u9 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 75
            -- upvalues: u8 (ref), u9 (ref)
            u8 = u8 + p10 * 60;
            local script_FOV = script.FOV;
            local math_ceil_ret = math.ceil(u8);
            local v11 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

            if v11 then
                game.Workspace.CurrentCamera.FieldOfView = v11.Value;

                return;
            end;

            u9:Disconnect();
        end);

        for _, child in pairs(game:GetService("Lighting"):GetChildren()) do
            local v12 = child:Clone();
            table.insert(u6, v12);
            child:Destroy();
        end;

        for _, child in pairs(script.Lighting:GetChildren()) do
            local v13 = child:Clone();
            table.insert(u7, v13);
            v13.Parent = game:GetService("Lighting");
        end;

        game.Lighting.ClockTime = 0.341;
    end;

    workspace:FindFirstChild("NagiCam");

    for _, v in pairs(u4) do
        local v14 = v;

        for _, child in pairs(script.Aura:GetChildren()) do
            local v15 = child:Clone();
            v15.Parent = Char[v14];
            table.insert(u7, v15);
        end;
    end;

    for _, child in pairs(script.Environment:GetChildren()) do
        coroutine.wrap(function() -- Line: 118
            -- upvalues: child (copy), u7 (copy), HumanoidRootPart (copy), Folder (copy), VfxManager (ref), ReplicatedStorage (ref), TweenService (ref)
            local v16 = child:Clone();
            local v17 = script.HumanoidRootPart.CFrame:Inverse() * child:GetPivot();
            u7[v16.Name] = v16;
            v16:PivotTo(HumanoidRootPart.CFrame * v17);
            v16.Parent = Folder;

            if v16.Name == "amalgamation" then
                VfxManager.Enable(v16, false);
                v16.amalgamation.AnimationController.Animator:LoadAnimation(ReplicatedStorage.Assets.ReplicatedAnims.Abilities.ANewToyMonster):Play();

                return;
            end;

            if v16.Name == "BallFX" then
                VfxManager.Emit(v16);

                return;
            end;

            if v16.Name == "HoldBall" then
                task.wait(1.7);
                VfxManager.Enable(v16, true);

                return;
            end;

            if v16.Name == "RinFX" then
                task.wait(2.9);
                VfxManager.Emit(v16);

                return;
            end;

            if v16.Name == "FloorGround" then
                task.wait(3.4);
                VfxManager.Enable(v16, true);
                task.wait(2);
                VfxManager.Enable(v16, false);

                return;
            end;

            if v16.Name == "BubblePop" then
                task.wait(5.85);
                VfxManager.Emit(v16);

                return;
            end;

            if v16.Name == "DomainBall" then
                print("DomainBall");
                v16.Transparency = 1;
                task.wait(5.85);
                TweenService:Create(v16, TweenInfo.new(1), {
                    Transparency = 0
                }):Play();

                return;
            end;

            if v16.Name == "DomainFloor" then
                v16.Transparency = 1;
                task.wait(5.85);
                TweenService:Create(v16, TweenInfo.new(1), {
                    Transparency = 0
                }):Play();

                return;
            end;

            if v16.Name ~= "LastGround" then
                if v16.Name == "Mist" then
                    VfxManager.Enable(v16, true);
                end;

                return;
            end;

            task.wait(5.8);
            VfxManager.Enable(v16, true);
            task.wait(2);
            VfxManager.Enable(v16, false);
        end)();
    end;

    task.delay(6.3, function() -- Line: 170
        -- upvalues: VfxManager (ref), u7 (copy)
        VfxManager.Enable(u7.amalgamation, true);
    end);
    task.delay(8.5, function() -- Line: 175
        -- upvalues: FieldOfView (copy), Folder (copy), ClockTime (copy), u7 (copy), u6 (copy)
        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;
        Folder:Destroy();
        game.Lighting.ClockTime = ClockTime;

        for _, v in pairs(u7) do
            v:Destroy();
        end;

        for _, v in pairs(u6) do
            v.Parent = game:GetService("Lighting");
        end;
    end);
end;