  

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local u1 = ReplicatedStorage["Client Assets"];
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local EffectsHandler = require(ReplicatedStorage.ReplicatedModules.EffectsHandler);
local LocalPlayer = Players.LocalPlayer;
local Parent = script.Parent.Parent;
local DriverSeat = Parent:WaitForChild("DriverSeat");
local Replicate = script.Parent.Server.Replicate;
local Controller = require(script.Controller);
local u2 = false;

local function StartControlling() -- Line: 20
    -- upvalues: u2 (ref), Controller (copy), Parent (copy), Replicate (copy)
    if u2 then
        return;
    end;

    u2 = true;
    Controller:Start();
    local Connections = Controller.Connections;
    local v3 = Parent:GetAttributeChangedSignal("Nitro");
    table.insert(Connections, v3:Connect(function() -- Line: 30
        -- upvalues: Parent (ref), Replicate (ref)
        Replicate:FireServer("Nitro", {
            State = Parent:GetAttribute("Nitro")
        });
    end));
end;

local function StopControlling() -- Line: 37
    -- upvalues: u2 (ref), Controller (copy)
    if not u2 then
        return;
    end;

    u2 = false;
    Controller:Stop();
end;

local function OccupiedByLocalPlayer() -- Line: 46
    -- upvalues: DriverSeat (copy), Players (copy), LocalPlayer (copy)
    local Occupant = DriverSeat.Occupant;

    return Occupant and Players:GetPlayerFromCharacter(Occupant.Parent) == LocalPlayer and true or false;
end;

local function OccupantChanged() -- Line: 61
    -- upvalues: DriverSeat (copy), Players (copy), LocalPlayer (copy), StartControlling (copy), u2 (ref), Controller (copy)
    local Occupant = DriverSeat.Occupant;

    if Occupant and Players:GetPlayerFromCharacter(Occupant.Parent) == LocalPlayer and true or false then
        StartControlling();

        return;
    end;

    if not u2 then
        return;
    end;

    u2 = false;
    Controller:Stop();
end;

local function SetupDestructionHandler() -- Line: 69
    -- upvalues: LocalPlayer (copy), Parent (copy), StopControlling (copy)
    local u4 = script.DestructionHandler:Clone();
    u4.Parent = LocalPlayer.PlayerScripts;
    u4.Enabled = true;
    task.defer(function() -- Line: 74
        -- upvalues: u4 (copy), Parent (ref), StopControlling (ref)
        u4.Bindable:Fire(Parent, StopControlling);
    end);
end;

local u5 = script.DestructionHandler:Clone();
u5.Parent = LocalPlayer.PlayerScripts;
u5.Enabled = true;
task.defer(function() -- Line: 74
    -- upvalues: u5 (copy), Parent (copy), StopControlling (copy)
    u5.Bindable:Fire(Parent, StopControlling);
end);
DriverSeat:GetPropertyChangedSignal("Occupant"):Connect(OccupantChanged);
local u6 = nil;
Parent:GetAttributeChangedSignal("Nitro"):Connect(function() -- Line: 84
    -- upvalues: Parent (copy), DriverSeat (copy), Players (copy), LocalPlayer (copy), u6 (ref), TweenService (copy)
    local v7 = Parent:GetAttribute("Nitro");

    for _, descendant in Parent.Nitro:GetDescendants() do
        if descendant:IsA("ParticleEmitter") or descendant:IsA("PointLight") then
            descendant.Enabled = v7;
        end;
    end;

    local Occupant = DriverSeat.Occupant;

    if Occupant and Players:GetPlayerFromCharacter(Occupant.Parent) == LocalPlayer and true or false then
        if u6 then
            u6:Pause();
            u6 = nil;
        end;

        local Value = LocalPlayer.Settings.FieldOfView.Value;
        local v8 = math.min(Value + 35, 120);
        local CurrentCamera = workspace.CurrentCamera;
        local v9 = TweenInfo.new(0.2);
        local v10 = {};

        if v7 then
            Value = v8 or Value;
        end;

        v10.FieldOfView = Value;
        u6 = TweenService:Create(CurrentCamera, v9, v10);
        u6:Play();
    end;
end);

local function FPSWait(p11) -- Line: 109
    if not p11 then
        return task.wait();
    end;

    local v12 = 0;

    repeat
        v12 = v12 + task.wait();
    until p11 <= v12;

    return v12;
end;

local u13 = RaycastParams.new();
u13.FilterType = Enum.RaycastFilterType.Include;
u13.FilterDescendantsInstances = { workspace.Map };
local u14 = LocalPlayer:GetMouse();
Parent:GetAttributeChangedSignal("GunFire"):Connect(function() -- Line: 129
    -- upvalues: Parent (copy), DriverSeat (copy), Players (copy), LocalPlayer (copy), u14 (copy), u13 (copy), Replicate (copy)
    if Parent:GetAttribute("GunFire") then
        local Occupant = DriverSeat.Occupant;
        local v15 = Occupant and Players:GetPlayerFromCharacter(Occupant.Parent) == LocalPlayer and true or false;

        repeat
            for _, descendant in Parent.ShootFX:GetDescendants() do
                if descendant:IsA("ParticleEmitter") then
                    descendant:Emit(descendant:GetAttribute("EmitCount") or 5);
                end;
            end;

            if v15 then
                local Unit = (u14.Hit.Position - DriverSeat.Position).Unit;
                local v16 = Vector3.new(1, 0, 1) * DriverSeat.CFrame.LookVector;
                local v17 = Vector3.new(1, 0, 1) * Unit;
                local v18 = v16:Dot(v17);
                local v19 = math.clamp(v18, -1, 1);

                if math.acos(v19) > 2.356194490192345 then
                    local v20 = v16:Cross(v17).Y > 0 and 1 or -1;
                    local v21 = CFrame.fromAxisAngle(Vector3.new(0, 1, 0), 2.356194490192345 * v20) * v16;
                    Unit = Vector3.new(v21.X, Unit.Y, v21.Z).Unit;
                end;

                local Unit2 = Unit:Cross(Vector3.new(0, 1, 0)).Unit;
                local Unit3 = Unit2:Cross(Unit).Unit;
                local v22 = (math.random() - 0.5) * 2 * 0.05235987755982989;
                local v23 = (math.random() - 0.5) * 2 * 0.05235987755982989;
                local Unit4 = (CFrame.fromAxisAngle(Unit3, v22) * CFrame.fromAxisAngle(Unit2, v23) * Unit).Unit;
                local v24 = {};

                for _, v in { "Right", "Left" } do
                    local v25 = workspace:Raycast(Parent.ShootFX[v].WorldPosition, Unit4 * 1000000, u13);

                    if v25 then
                        v24[v] = v25.Position;
                    end;
                end;

                Replicate:FireServer("GunFire", {
                    Goals = v24
                });
            end;

            local v26 = 0;

            repeat
                v26 = v26 + task.wait();
            until v26 >= 0.13333333333333333;
        until not Parent:IsDescendantOf(game) or (not Parent:GetAttribute("GunFire") or DriverSeat.Occupant == nil);
    end;
end);
Replicate.OnClientEvent:Connect(function(p27, p28) -- Line: 188
    -- upvalues: Parent (copy), u1 (copy), TweenService (copy), AssetHandler (copy), DriverSeat (copy), EffectsHandler (copy), LocalPlayer (copy)
    if p27 == "GunFire" then
        for i, v in p28.Goals do
            local WorldPosition = Parent.ShootFX[i].WorldPosition;
            local v29 = math.clamp((WorldPosition - v).Magnitude, 0, 1000) / (p28.Speed or 200);
            local u30 = u1.Projectiles.TommyBullet:Clone();
            u30.Anchored = true;
            u30.Position = WorldPosition;
            u30.Parent = workspace.Effects;
            local v31 = TweenService:Create(u30, TweenInfo.new(v29, Enum.EasingStyle.Linear), {
                Position = v
            });
            v31:Play();
            v31.Completed:Connect(function() -- Line: 206
                -- upvalues: u30 (copy)
                task.delay(3, u30.Destroy, u30);

                for _, descendant in u30:GetDescendants() do
                    if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                        descendant.Enabled = false;
                    end;
                end;
            end);
        end;

        return;
    end;

    if p27 == "Missiles" then
        local Goal = p28.Goal;
        local v32 = p28.Time or 1;
        local u33 = AssetHandler.CloneAsset("Models/Missile", {
            AbilityName = "The Dark Knight"
        });
        u33.CFrame = DriverSeat.CFrame * CFrame.new(0, -5, 0) * CFrame.Angles(0, 3.141592653589793, 0);
        u33.Anchored = true;
        u33.Parent = workspace.Effects;
        local v34 = TweenService:Create(u33, TweenInfo.new(v32, Enum.EasingStyle.Linear), {
            CFrame = CFrame.new(Goal, Goal + (Goal - u33.Position).Unit) * CFrame.Angles(0, 3.141592653589793, 0)
        });
        v34:Play();
        v34.Completed:Connect(function() -- Line: 229
            -- upvalues: u33 (copy), TweenService (ref), EffectsHandler (ref), Goal (copy), LocalPlayer (ref)
            task.delay(3, u33.Destroy, u33);

            for _, descendant in u33:GetDescendants() do
                if descendant:IsA("ParticleEmitter") or descendant:IsA("Trail") then
                    descendant.Enabled = false;
                end;
            end;

            TweenService:Create(u33, TweenInfo.new(0.5), {
                Transparency = 1
            }):Play();
            EffectsHandler.CallEffect("Emit Particle V3", {
                MaxRenderDistance = 1000,
                Path = "Particles/Explosion",
                AutoSerialize = true,
                Origin = Goal,
                Player = LocalPlayer
            });
        end);
    end;
end);