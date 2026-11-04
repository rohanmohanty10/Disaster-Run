 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local TweenService = game:GetService("TweenService");
local Debris = game:GetService("Debris");
local SoundService = game:GetService("SoundService");
local LocalPlayer = Players.LocalPlayer;
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local TruckAbilityEvent = ChickenOrHero:WaitForChild("Weapons"):WaitForChild("TruckAbilityEvent");
local u1;

if require(game:GetService("ReplicatedFirst"):WaitForChild("FFlags")).ClientBots then
    u1 = require(ChickenOrHero:WaitForChild("Bots"):WaitForChild("BotDirectory")) or nil;
else
    u1 = nil;
end;

local Color3_fromRGB_ret = Color3.fromRGB(255, 178, 96);
local Color3_fromRGB_ret2 = Color3.fromRGB(196, 240, 200);
local KnifeAbilities = require(ChickenOrHero.Weapons:WaitForChild("KnifeAbilities"));
local u2 = SoundService:WaitForChild("GameAudio"):WaitForChild("10_Football", 10);
local u3 = {};

local function rootOf(p4) -- Line: 25
    -- upvalues: Players (copy), u1 (copy)
    local PlayerByUserId = Players:GetPlayerByUserId(p4);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if not (PlayerByUserId or (not u1 or p4 == 0)) then
        PlayerByUserId = u1.get(p4);

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId.Character;
        end;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    return PlayerByUserId;
end;

local function play(p5, p6) -- Line: 34
    -- upvalues: u2 (copy), Debris (copy)
    local v7 = u2 and u2:FindFirstChild(p5);

    if not (v7 and p6) then
        return;
    end;

    local v8 = v7:Clone();
    v8.RollOffMaxDistance = 120;
    v8.Parent = p6;
    v8:Play();
    Debris:AddItem(v8, 3);
end;

local function burst(p9, p10, p11, p12) -- Line: 45
    -- upvalues: Color3_fromRGB_ret (copy), TweenService (copy), Debris (copy)
    local Part = Instance.new("Part");
    Part.Name = "TruckBurst";
    Part.Shape = Enum.PartType.Ball;
    Part.Material = Enum.Material.Neon;
    Part.Color = p12 or Color3_fromRGB_ret;
    Part.Transparency = 0.35;
    Part.Size = Vector3.new(1.5, 1.5, 1.5);
    Part.CFrame = CFrame.new(p9);
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    Part.CastShadow = false;
    Part.Parent = workspace;
    TweenService:Create(Part, TweenInfo.new(p11, Enum.EasingStyle.Quad), {
        Transparency = 1,
        Size = Vector3.new(1, 1, 1) * p10
    }):Play();
    Debris:AddItem(Part, p11 + 0.05);
end;

local Color3_fromRGB_ret3 = Color3.fromRGB(255, 214, 64);

local function stars(u13, u14) -- Line: 68
    -- upvalues: Color3_fromRGB_ret3 (copy), RunService (copy)
    local u15 = u13.Parent and u13.Parent:FindFirstChild("Head");
    local u16 = {};

    for i = 1, 5 do
        local Part = Instance.new("Part");
        Part.Name = "TruckStar";
        Part.Shape = Enum.PartType.Ball;
        Part.Material = Enum.Material.Neon;
        Part.Color = Color3_fromRGB_ret3;
        Part.Size = Vector3.new(0.28, 0.28, 0.28);
        Part.Anchored = true;
        Part.CanCollide = false;
        Part.CanTouch = false;
        Part.CanQuery = false;
        Part.CastShadow = false;
        Part.Parent = workspace;
        u16[i] = Part;
        local _ = i;
    end;

    local os_clock_ret = os.clock();
    local u17 = nil;
    u17 = RunService.RenderStepped:Connect(function() -- Line: 88
        -- upvalues: os_clock_ret (copy), u14 (copy), u13 (copy), u17 (ref), u16 (copy), u15 (copy)
        local v18 = os.clock() - os_clock_ret;

        if u14 <= v18 or not u13.Parent then
            u17:Disconnect();

            for _, v in u16 do
                v:Destroy();
            end;

            return;
        end;

        local v19 = (u15 and (u15.Parent and u15.Position) or u13.Position + Vector3.new(0, 1.5, 0)) + Vector3.new(0, 0.95, 0);
        local math_clamp_ret = math.clamp((v18 - (u14 - 0.15)) / 0.15, 0, 1);

        for i, v in u16 do
            local v20 = v18 * 8 + i * 3.141592653589793 * 0.4;
            local CFrame_new = CFrame.new;
            local v21 = math.cos(v20) * 1.1;
            local v22 = math.sin(v18 * 12 + i) * 0.1;
            local v23 = math.sin(v20) * 1.1;
            v.CFrame = CFrame_new(v19 + Vector3.new(v21, v22, v23));
            v.Transparency = math_clamp_ret;
        end;
    end);
end;

local u24 = 0;
local u25 = 0;

local function shake(p26, p27) -- Line: 108
    -- upvalues: u25 (ref), u24 (ref)
    u25 = math.max(u25, p26);
    local v28 = os.clock() + p27;
    u24 = math.max(u24, v28);
end;

RunService:BindToRenderStep("CoHTruckShake", Enum.RenderPriority.Camera.Value + 5, function() -- Line: 112
    -- upvalues: u24 (ref), u25 (ref)
    local v29 = u24 - os.clock();

    if v29 <= 0 then
        u25 = 0;

        return;
    end;

    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera then
        local v30 = u25 * math.clamp(v29 / 0.3, 0, 1);
        local CFrame2 = workspace_CurrentCamera.CFrame;
        local CFrame_Angles = CFrame.Angles;
        local v31 = (math.random() - 0.5) * 2 * v30;
        local math_rad_ret = math.rad(v31);
        local v32 = (math.random() - 0.5) * 2 * v30;
        local math_rad_ret2 = math.rad(v32);
        local v33 = (math.random() - 0.5) * v30;
        workspace_CurrentCamera.CFrame = CFrame2 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(v33)));
    end;
end);
table.insert(u3, TruckAbilityEvent.OnClientEvent:Connect(function(p34, p35, p36, p37) -- Line: 131
    -- upvalues: Players (copy), u1 (copy), u2 (copy), Debris (copy), burst (copy), stars (copy), LocalPlayer (copy), u25 (ref), u24 (ref)
    if type(p35) ~= "number" then
        return;
    end;

    local PlayerByUserId = Players:GetPlayerByUserId(p35);

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId.Character;
    end;

    if not (PlayerByUserId or (not u1 or p35 == 0)) then
        PlayerByUserId = u1.get(p35);

        if PlayerByUserId then
            PlayerByUserId = PlayerByUserId.Character;
        end;
    end;

    if PlayerByUserId then
        PlayerByUserId = PlayerByUserId:FindFirstChild("HumanoidRootPart");
    end;

    if not PlayerByUserId then
        return;
    end;

    if p34 ~= "Activated" then
        if p34 == "Trucked" then
            local v38 = u2 and u2:FindFirstChild("TruckImpact");

            if v38 and PlayerByUserId then
                local v39 = v38:Clone();
                v39.RollOffMaxDistance = 120;
                v39.Parent = PlayerByUserId;
                v39:Play();
                Debris:AddItem(v39, 3);
            end;

            local v40;

            if type(p36) == "number" then
                local PlayerByUserId2 = Players:GetPlayerByUserId(p36);

                if PlayerByUserId2 then
                    PlayerByUserId2 = PlayerByUserId2.Character;
                end;

                if not (PlayerByUserId2 or (not u1 or p36 == 0)) then
                    PlayerByUserId2 = u1.get(p36);

                    if PlayerByUserId2 then
                        PlayerByUserId2 = PlayerByUserId2.Character;
                    end;
                end;

                if PlayerByUserId2 then
                    PlayerByUserId2 = PlayerByUserId2:FindFirstChild("HumanoidRootPart");
                end;

                v40 = PlayerByUserId2 or nil;
            else
                v40 = nil;
            end;

            burst(v40 and PlayerByUserId.Position:Lerp(v40.Position, 0.5) or PlayerByUserId.Position + PlayerByUserId.CFrame.LookVector * 1.5, 11, 0.4);

            if v40 and (type(p37) == "number" and p37 > 0) then
                stars(v40, p37);
            end;

            if p35 == LocalPlayer.UserId or p36 == LocalPlayer.UserId then
                u25 = math.max(u25, p35 == LocalPlayer.UserId and 1.2 or 2.2);
                local v41 = os.clock() + 0.3;
                u24 = math.max(u24, v41);
            end;
        end;

        return;
    end;

    local v42 = u2 and u2:FindFirstChild("TruckWhoosh");

    if v42 and PlayerByUserId then
        local v43 = v42:Clone();
        v43.RollOffMaxDistance = 120;
        v43.Parent = PlayerByUserId;
        v43:Play();
        Debris:AddItem(v43, 3);
    end;

    burst(PlayerByUserId.Position + PlayerByUserId.CFrame.LookVector * 1.6, 6, 0.25);
end));
local StepOver = KnifeAbilities.StepOver;

local function stepOver(p44, u45) -- Line: 159
    -- upvalues: Players (copy), u1 (copy), StepOver (copy), u2 (copy), Debris (copy), burst (copy), Color3_fromRGB_ret2 (copy)
    local u46;

    if type(p44) == "number" then
        u46 = Players:GetPlayerByUserId(p44);

        if u46 then
            u46 = u46.Character;
        end;

        if not (u46 or (not u1 or p44 == 0)) then
            u46 = u1.get(p44);

            if u46 then
                u46 = u46.Character;
            end;
        end;

        if u46 then
            u46 = u46:FindFirstChild("HumanoidRootPart");
        end;
    else
        u46 = false;
    end;

    if not (u46 and (u45 == 1 or u45 == -1)) then
        return;
    end;

    if not StepOver.FakeTowardInput then
        u45 = -u45;
    end;

    local v47 = u2 and u2:FindFirstChild("TruckWhoosh");

    if v47 and u46 then
        local v48 = v47:Clone();
        v48.RollOffMaxDistance = 120;
        v48.Parent = u46;
        v48:Play();
        Debris:AddItem(v48, 3);
    end;

    burst(u46.Position - Vector3.new(0, 2.6, 0) + u46.CFrame.RightVector * u45 * 0.8, 4, 0.22, Color3_fromRGB_ret2);
    task.delay(StepOver.FakeTime, function() -- Line: 168
        -- upvalues: u46 (copy), u2 (ref), Debris (ref), burst (ref), u45 (copy), Color3_fromRGB_ret2 (ref)
        if u46.Parent then
            local v49 = u46;
            local v50 = u2 and u2:FindFirstChild("TruckWhoosh");

            if v50 and v49 then
                local v51 = v50:Clone();
                v51.RollOffMaxDistance = 120;
                v51.Parent = v49;
                v51:Play();
                Debris:AddItem(v51, 3);
            end;

            burst(u46.Position - Vector3.new(0, 2.6, 0) - u46.CFrame.RightVector * u45 * 1.4, 7, 0.3, Color3_fromRGB_ret2);
        end;
    end);
end;

task.spawn(function() -- Line: 175
    -- upvalues: ChickenOrHero (copy), KnifeAbilities (copy), u3 (copy), stepOver (copy)
    local v52 = ChickenOrHero.Weapons:WaitForChild(KnifeAbilities.Skins.Futbol.Remote, 60);

    if v52 and script.Parent then
        table.insert(u3, v52.OnClientEvent:Connect(function(p53, p54, p55) -- Line: 180
            -- upvalues: stepOver (ref)
            if p53 == "Activated" then
                stepOver(p54, p55);
            end;
        end));
    end;
end);
local PirateShots = require(ChickenOrHero:WaitForChild("Presentation"):WaitForChild("PirateShots"));
local Cannon = KnifeAbilities.Cannon;
local RaycastParams_new_ret = RaycastParams.new();
RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Exclude;
RaycastParams_new_ret.RespectCanCollide = true;

local function cannonSound(p56, p57, p58, p59) -- Line: 197
    -- upvalues: Debris (copy)
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. p56;
    Sound.Volume = p58;
    Sound.PlaybackSpeed = p59 or 1;
    Sound.RollOffMaxDistance = 150;
    Sound.Parent = p57;
    Sound:Play();
    Debris:AddItem(Sound, 5);
end;

local function smokePuff(p60, p61, p62, p63) -- Line: 207
    -- upvalues: Debris (copy)
    local Part = Instance.new("Part");
    Part.Name = "CannonSmoke";
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanQuery = false;
    Part.CanTouch = false;
    Part.Transparency = 1;
    Part.Size = Vector3.new(1, 1, 1);
    Part.CFrame = CFrame.new(p60);
    Part.Parent = workspace;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(p63 or Color3.fromRGB(210, 205, 195));
    ParticleEmitter.Size = NumberSequence.new(p62 * 0.5, p62);
    ParticleEmitter.Transparency = NumberSequence.new(0.2, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.7, 1.2);
    ParticleEmitter.Speed = NumberRange.new(3, 9);
    ParticleEmitter.SpreadAngle = Vector2.new(180, 180);
    ParticleEmitter.Drag = 3;
    ParticleEmitter.Rate = 0;
    ParticleEmitter.Parent = Part;
    ParticleEmitter:Emit(p61);
    Debris:AddItem(Part, 1.5);
end;

local function cannonFX(p64, p65, p66) -- Line: 229
    -- upvalues: Players (copy), u1 (copy), PirateShots (copy), Debris (copy), ChickenOrHero (copy), Cannon (copy), RaycastParams_new_ret (copy), RunService (copy), burst (copy), smokePuff (copy), LocalPlayer (copy), u25 (ref), u24 (ref)
    local v67;

    if type(p64) == "number" then
        v67 = Players:GetPlayerByUserId(p64);

        if v67 then
            v67 = v67.Character;
        end;

        if not (v67 or (not u1 or p64 == 0)) then
            v67 = u1.get(p64);

            if v67 then
                v67 = v67.Character;
            end;
        end;

        if v67 then
            v67 = v67:FindFirstChild("HumanoidRootPart");
        end;
    else
        v67 = false;
    end;

    if not (v67 and (typeof(p65) == "Vector3" and typeof(p66) == "Vector3")) then
        return;
    end;

    local v68 = p66 * Vector3.new(1, 0, 1);

    if v68.Magnitude < 0.5 then
        return;
    end;

    local Unit = v68.Unit;
    local Parent = v67.Parent;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if workspace_CurrentCamera and (workspace_CurrentCamera.CFrame.Position - p65).Magnitude > 160 then
        return;
    end;

    local Blast = PirateShots.Sounds.Blast;
    local Sound = Instance.new("Sound");
    Sound.SoundId = "rbxassetid://" .. Blast;
    Sound.Volume = 0.9;
    Sound.PlaybackSpeed = 1;
    Sound.RollOffMaxDistance = 150;
    Sound.Parent = v67;
    Sound:Play();
    Debris:AddItem(Sound, 5);
    local PirateShow = ChickenOrHero.Presentation:FindFirstChild("PirateShow");

    if PirateShow then
        PirateShow = PirateShow:FindFirstChild("Cannon");
    end;

    if PirateShow then
        local u69 = PirateShow:Clone();
        u69:ScaleTo(u69:GetScale() * Cannon.PropScale);
        RaycastParams_new_ret.FilterDescendantsInstances = { Parent, u69 };
        local v70 = p65 - Unit * Cannon.Behind;
        local v71 = workspace:Raycast(v70 + Vector3.new(0, 3, 0), Vector3.new(-0, -12, -0), RaycastParams_new_ret);
        local u72;

        if v71 then
            u72 = v71.Position;
        else
            u72 = v70 - Vector3.new(0, 3, 0);
        end;

        local CFrame_lookAt_ret = CFrame.lookAt(u72, u72 + Unit);
        local _, u73 = u69:GetBoundingBox();
        u69:PivotTo(CFrame_lookAt_ret - Vector3.new(0, 1, 0) * u73.Y);
        u69.Parent = workspace;
        local Muzzle = u69.PrimaryPart:FindFirstChild("Muzzle");
        local os_clock_ret = os.clock();
        local u74 = false;
        local u75 = nil;
        u75 = RunService.RenderStepped:Connect(function() -- Line: 263
            -- upvalues: os_clock_ret (copy), u69 (copy), u75 (ref), u73 (copy), PirateShots (ref), CFrame_lookAt_ret (copy), u74 (ref), Muzzle (copy), u72 (copy), Unit (ref), burst (ref), smokePuff (ref)
            local v76 = os.clock() - os_clock_ret;

            if v76 >= 1.75 or not u69.Parent then
                u75:Disconnect();
                u69:Destroy();

                return;
            end;

            local v77 = -u73.Y * (1 - PirateShots.smooth(v76 / 0.12));
            local v78 = v76 < 0.12 and 0 or math.exp(-(v76 - 0.12) * 9) * 0.9 * math.min(1, (v76 - 0.12) / 0.04);

            if v76 > 1.3 then
                v77 = -u73.Y * PirateShots.smooth((v76 - 1.3) / 0.4);
            end;

            u69:PivotTo(CFrame_lookAt_ret * CFrame.new(0, v77, v78));

            if not u74 and v76 >= 0.1 then
                u74 = true;
                local v79 = Muzzle and Muzzle.WorldPosition or u72 + Unit * 3 + Vector3.new(0, 2, 0);
                burst(v79, 3.5, 0.18, Color3.fromRGB(255, 170, 70));
                smokePuff(v79, 18, 4);
                smokePuff(u72, 10, 3, Color3.fromRGB(150, 130, 105));
            end;
        end);
    end;

    local u80;

    if Parent then
        u80 = PirateShots.rig(Parent);
    else
        u80 = Parent;
    end;

    if u80 then
        local os_clock_ret = os.clock();
        local u81 = nil;
        u81 = RunService.RenderStepped:Connect(function() -- Line: 290
            -- upvalues: os_clock_ret (copy), Cannon (ref), Parent (copy), u81 (ref), PirateShots (ref), u80 (copy)
            local v82 = os.clock() - os_clock_ret;

            if Cannon.Flight <= v82 or not Parent.Parent then
                u81:Disconnect();
                PirateShots.release(u80);

                return;
            end;

            local v83 = v82 / Cannon.Flight;
            local v84 = math.min(1, v82 / 0.1) * (1 - PirateShots.smooth((v82 - (Cannon.Flight - 0.14)) / 0.14));
            local CFrame_Angles_ret = CFrame.Angles(-6.283185307179586 * Cannon.Spins * PirateShots.smooth(v83), 0, 0);
            PirateShots.pose(u80, PirateShots.blend(PirateShots.Poses.Neutral, PirateShots.Poses.Tuck, v84), CFrame_Angles_ret);
        end);
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Name = "CannonTrail";
    Attachment.Parent = v67;
    local ParticleEmitter = Instance.new("ParticleEmitter");
    ParticleEmitter.Texture = "rbxasset://textures/particles/smoke_main.dds";
    ParticleEmitter.Color = ColorSequence.new(Color3.fromRGB(220, 215, 205));
    ParticleEmitter.Size = NumberSequence.new(1.2, 2.6);
    ParticleEmitter.Transparency = NumberSequence.new(0.35, 1);
    ParticleEmitter.Lifetime = NumberRange.new(0.4, 0.7);
    ParticleEmitter.Speed = NumberRange.new(0.5, 1.5);
    ParticleEmitter.Rate = 40;
    ParticleEmitter.Parent = Attachment;
    task.delay(Cannon.Flight, function() -- Line: 315
        -- upvalues: ParticleEmitter (copy)
        ParticleEmitter.Enabled = false;
    end);
    Debris:AddItem(Attachment, Cannon.Flight + 1);

    if p64 == LocalPlayer.UserId then
        u25 = math.max(u25, 1.4);
        local v85 = os.clock() + 0.3;
        u24 = math.max(u24, v85);
    end;
end;

task.spawn(function() -- Line: 323
    -- upvalues: ChickenOrHero (copy), KnifeAbilities (copy), u3 (copy), cannonFX (copy)
    local v86 = ChickenOrHero.Weapons:WaitForChild(KnifeAbilities.Skins.AlbiesCutlass.Remote, 60);

    if v86 and script.Parent then
        table.insert(u3, v86.OnClientEvent:Connect(function(p87, p88, p89, p90) -- Line: 328
            -- upvalues: cannonFX (ref)
            if p87 == "Activated" then
                cannonFX(p88, p89, p90);
            end;
        end));
    end;
end);
script.Destroying:Connect(function() -- Line: 336
    -- upvalues: u3 (copy), RunService (copy)
    for _, v in u3 do
        v:Disconnect();
    end;

    RunService:UnbindFromRenderStep("CoHTruckShake");
end);