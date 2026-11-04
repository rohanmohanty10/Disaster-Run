  

local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("TweenService");
game:GetService("Debris");
local _ = game.Lighting;
require(ReplicatedStorage.Shared.Essentials);
require(ReplicatedStorage.Shared.VfxManager);
require(ReplicatedStorage.Shared.SoundManager);
require(ReplicatedStorage.Shared.Popup);
local SpectatorController = require(ReplicatedStorage.Controllers.SpectatorController);
local Animations = require(ReplicatedStorage.Assets.Animations);

local function Weld(p1, p2) -- Line: 15
    local WeldConstraint = Instance.new("WeldConstraint");
    WeldConstraint.Part0 = p1;
    WeldConstraint.Part1 = p2;
    WeldConstraint.Parent = p1;

    return WeldConstraint;
end;

function EmitAll(p3)
    local function emit(u4) -- Line: 24
        if u4:IsA("ParticleEmitter") or (u4:IsA("Beam") or u4:IsA("Trail")) then
            local Attribute = u4:GetAttribute("EmitDelay");
            local Attribute2 = u4:GetAttribute("EmitCount");

            if Attribute2 and Attribute2 ~= 0 then
                if Attribute and Attribute ~= 0 then
                    task.delay(Attribute, function() -- Line: 31
                        -- upvalues: u4 (copy), Attribute2 (copy)
                        u4:Emit(Attribute2);
                    end);

                    return;
                end;

                u4:Emit(Attribute2);
            end;
        end;
    end;

    if typeof(p3) == "table" then
        for _, v in p3 do
            if v:IsA("ParticleEmitter") or (v:IsA("Beam") or v:IsA("Trail")) then
                emit(v);
            else
                for _, descendant in v:GetDescendants() do
                    emit(descendant);
                end;
            end;
        end;

        return;
    end;

    if p3:IsA("ParticleEmitter") or (p3:IsA("Beam") or p3:IsA("Trail")) then
        emit(p3);

        return;
    end;

    for _, descendant in p3:GetDescendants() do
        emit(descendant);
    end;
end;

local function Destroy_Effect(u5: any, p6: number) -- Line: 62
    task.delay(p6, function() -- Line: 64
        -- upvalues: u5 (copy)
        if typeof(u5) == "table" then
            for _, v in u5 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u5 then
            u5:Destroy();
        end;
    end);
end;

return function(p7) -- Line: 80
    -- upvalues: SpectatorController (copy), Animations (copy)
    if game.Players.LocalPlayer.Team == game.Teams.Visitor and not SpectatorController.IsSpectating then
        return;
    end;

    local Character = p7.Character;
    local HumanoidRootPart = Character:FindFirstChild("HumanoidRootPart");
    local Folder = Instance.new("Folder");
    Folder.Parent = workspace.Debris;
    local u8 = tick();
    local FieldOfView = game.Workspace.CurrentCamera.FieldOfView;
    local u9 = 0;
    local u12 = game:GetService("RunService").RenderStepped:Connect(function(p10) -- Line: 93
        -- upvalues: u9 (ref)
        u9 = u9 + p10 * 60;
        local script_FOV = script.FOV;
        local math_ceil_ret = math.ceil(u9);
        local v11 = script_FOV:FindFirstChild((tonumber(math_ceil_ret)));

        if not v11 then
            return;
        end;

        game.Workspace.CurrentCamera.FieldOfView = v11.Value;
    end);
    local u13 = script.Gun1:Clone();
    u13:PivotTo(CFrame.new(0, 0, 0));
    u13.Parent = Folder;
    game.Lighting.Blur.Size = 17;
    game:GetService("TweenService"):Create(game.Lighting.Blur, TweenInfo.new(0.35, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    local u14 = script.FootParticles.FEET:Clone();
    u14.Parent = Character["Left Leg"];
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u14 (copy)
        if typeof(u14) == "table" then
            for _, v in u14 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u14 then
            u14:Destroy();
        end;
    end);
    local u15 = script.FootParticles.TRAILFOOT:Clone();
    u15.Parent = Character["Left Leg"];
    u15.Trail.Attachment0 = u15;
    u15.Trail.Attachment1 = u14;
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u15 (copy)
        if typeof(u15) == "table" then
            for _, v in u15 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u15 then
            u15:Destroy();
        end;
    end);
    local u16 = script.Root.RootSpin:Clone();
    u16.Parent = Character.HumanoidRootPart;
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u15 (copy)
        if typeof(u15) == "table" then
            for _, v in u15 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u15 then
            u15:Destroy();
        end;
    end);
    task.delay(2.1333333333333333, function() -- Line: 126
        -- upvalues: u16 (copy)
        EmitAll(u16);
    end);
    task.delay(1.6666666666666667, function() -- Line: 130
        -- upvalues: u15 (copy)
        u15.Trail.Enabled = true;
        task.delay(0.9666666666666667, function() -- Line: 132
            -- upvalues: u15 (ref)
            u15.Trail.Enabled = false;
        end);
    end);
    task.spawn(function() -- Line: 137
        -- upvalues: Animations (ref), u13 (copy), u8 (copy), HumanoidRootPart (copy)
        local Animation = Instance.new("Animation");
        Animation.AnimationId = Animations.Abilities.TwoGunVolley_Gun1;
        local v17 = u13.AnimationController.Animator:LoadAnimation(Animation);
        v17.TimePosition = tick() - u8;
        u13:PivotTo(HumanoidRootPart.CFrame + Vector3.new(0, -3, 0));
        v17:Play(0);
    end);
    local u18 = script.Root.Object33:Clone();
    local u19 = script.Root.Object34:Clone();
    local u20 = script.Root.Object36:Clone();
    u18.Parent = Character.HumanoidRootPart;
    u19.Parent = Character.HumanoidRootPart;
    u20.Parent = Character.HumanoidRootPart;
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u18 (copy)
        if typeof(u18) == "table" then
            for _, v in u18 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u18 then
            u18:Destroy();
        end;
    end);
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u19 (copy)
        if typeof(u19) == "table" then
            for _, v in u19 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u19 then
            u19:Destroy();
        end;
    end);
    task.delay(6.083333333333333, function() -- Line: 64
        -- upvalues: u20 (copy)
        if typeof(u20) == "table" then
            for _, v in u20 do
                if v then
                    v:Destroy();
                end;
            end;

            return;
        end;

        if u20 then
            u20:Destroy();
        end;
    end);
    task.delay(3.9, function() -- Line: 151
        -- upvalues: u18 (copy), u19 (copy), u20 (copy)
        EmitAll(u18);
        EmitAll(u19);
        EmitAll(u20);
    end);
    local u21 = script.Gun2:Clone();
    u21:PivotTo(CFrame.new(0, 0, 0));
    u21.Parent = Folder;
    task.spawn(function() -- Line: 159
        -- upvalues: Animations (ref), u21 (copy), u8 (copy), HumanoidRootPart (copy)
        local Animation = Instance.new("Animation");
        Animation.AnimationId = Animations.Abilities.TwoGunVolley_Gun2;
        local v22 = u21.AnimationController.Animator:LoadAnimation(Animation);
        v22.TimePosition = tick() - u8;
        u21:PivotTo(HumanoidRootPart.CFrame + Vector3.new(0, -3, 0));
        v22:Play(0);
    end);
    task.delay(3.966666666666667, function() -- Line: 169
        -- upvalues: u13 (copy), u21 (copy)
        EmitAll(u13.Gun1["GUN SPARK"]);
        EmitAll(u21.Gun2["GUN SPARKK"]);
        task.delay(0.9833333333333333, function() -- Line: 172
            -- upvalues: u13 (ref), u21 (ref)
            EmitAll(u13.Gun1["GUN SPARK"]);
            EmitAll(u21.Gun2["GUN SPARKK"]);
        end);
    end);
    task.delay(6.083333333333333, function() -- Line: 178
        -- upvalues: u12 (ref), FieldOfView (copy), Folder (copy)
        if u12 then
            u12:Disconnect();
        end;

        game.Workspace.CurrentCamera.FieldOfView = FieldOfView;

        if Folder then
            Folder:Destroy();
        end;
    end);
end;