 

 

local Players = game:GetService("Players");
local RunService = game:GetService("RunService");
local ChickenOrHero = game.ReplicatedStorage:WaitForChild("ChickenOrHero");
local ParticipantDirectory = require(ChickenOrHero.Presentation:WaitForChild("ParticipantDirectory"));
local BoostVFXConfig = require(ChickenOrHero.Presentation:WaitForChild("BoostVFXConfig"));
local MovementConfig = require(ChickenOrHero.Movement.MovementConfig);
local WindTrail = ChickenOrHero.Presentation:WaitForChild("WindTrail");
local LocalPlayer = Players.LocalPlayer;
local u1 = {};
local u2 = 0;

local function remove(p3) -- Line: 11
    -- upvalues: u1 (copy)
    local v4 = u1[p3];

    if not v4 then
        return;
    end;

    for _, v in v4.objects do
        v:Destroy();
    end;

    u1[p3] = nil;
end;

local function add(p5, p6) -- Line: 15
    -- upvalues: WindTrail (copy), BoostVFXConfig (copy), u1 (copy)
    local v7 = {
        untilTime = 0,
        localBoost = false,
        root = p6,
        objects = {},
        lines = {},
        lastStamp = p5:GetAttribute("BoostEffectAt")
    };

    for i, v in { -1.15, 0, 1.15 } do
        local Attachment = Instance.new("Attachment");
        Attachment.Name = "BoostWindTop";
        Attachment.Parent = p6;
        local Attachment2 = Instance.new("Attachment");
        Attachment2.Name = "BoostWindBottom";
        Attachment2.Parent = p6;
        local v8 = WindTrail:Clone();
        v8.Attachment0 = Attachment;
        v8.Attachment1 = Attachment2;
        v8.Enabled = false;
        v8.Lifetime = BoostVFXConfig.TrailLifetime;
        v8.Parent = p6;
        table.insert(v7.objects, Attachment);
        table.insert(v7.objects, Attachment2);
        table.insert(v7.objects, v8);
        table.insert(v7.lines, {
            a = Attachment,
            b = Attachment2,
            trail = v8,
            x = v,
            y = i == 2 and 0.9 or -0.15
        });
    end;

    u1[p5] = v7;

    return v7;
end;

local u28 = RunService.Heartbeat:Connect(function(p9) -- Line: 26
    -- upvalues: u2 (ref), BoostVFXConfig (copy), ParticipantDirectory (copy), u1 (copy), add (copy), LocalPlayer (copy), MovementConfig (copy)
    u2 = u2 + p9;
    local workspace_CurrentCamera = workspace.CurrentCamera;

    if not workspace_CurrentCamera then
        return;
    end;

    if u2 >= 0.25 then
        u2 = 0;
        local v10 = {};
        local v11 = {};

        if BoostVFXConfig.Enabled then
            for _, v in ParticipantDirectory.list() do
                local Character = v.Character;
                local v12;

                if Character then
                    v12 = Character:FindFirstChild("HumanoidRootPart");
                else
                    v12 = Character;
                end;

                if v12 then
                    local Magnitude = (v12.Position - workspace_CurrentCamera.CFrame.Position).Magnitude;

                    if Magnitude < BoostVFXConfig.MaxDistance then
                        table.insert(v11, {
                            c = Character,
                            root = v12,
                            distance = Magnitude
                        });
                    end;
                end;
            end;
        end;

        table.sort(v11, function(p13, p14) -- Line: 37
            return p13.distance < p14.distance;
        end);

        for i, v in v11 do
            if BoostVFXConfig.MaxCharacters < i then
                break;
            end;

            v10[v.c] = true;

            if not u1[v.c] then
                add(v.c, v.root);
            end;
        end;

        for i in u1 do
            if not v10[i] then
                local v15 = u1[i];

                if v15 then
                    for _, v in v15.objects do
                        v:Destroy();
                    end;

                    u1[i] = nil;
                end;
            end;
        end;
    end;

    local ServerTimeNow = workspace:GetServerTimeNow();

    for i, v in u1 do
        if i.Parent and v.root.Parent then
            local v16 = i == LocalPlayer.Character;
            local v17;

            if v16 then
                v17 = i:GetAttribute("MovementState") == "Boosting" and true or i:GetAttribute("MovementState") == "Dashing";
            else
                v17 = v16;
            end;

            local Attribute = i:GetAttribute("BoostEffectAt");

            if v16 then
                if v17 and not v.localBoost then
                    v.untilTime = ServerTimeNow + MovementConfig.Dash.Duration;
                end;
            elseif type(Attribute) == "number" and Attribute ~= v.lastStamp then
                v.untilTime = Attribute + MovementConfig.Dash.Duration + BoostVFXConfig.FadeTail;
            end;

            v.lastStamp = Attribute;
            v.localBoost = v17;
            local Attribute2 = i:GetAttribute("TackleStartedAt");
            local v18 = i:GetAttribute("TackleDuration") or 0;
            local v19;

            if i:GetAttribute("TackleActive") == true and (type(Attribute2) == "number" and Attribute2 <= ServerTimeNow) then
                v19 = ServerTimeNow < Attribute2 + math.clamp(v18, 0, 0.6);
            else
                v19 = false;
            end;

            local v20 = BoostVFXConfig.Enabled and not i:GetAttribute("MovementLocked");

            if v20 then
                if v19 then
                    v20 = v19;
                elseif ServerTimeNow < v.untilTime then
                    v20 = not i:GetAttribute("TackleActive");
                else
                    v20 = false;
                end;
            end;

            local v21 = v.root.AssemblyLinearVelocity * Vector3.new(1, 0, 1);
            local v22 = v21.Magnitude > 0.5 and v21.Unit or v.root.CFrame.LookVector;
            local v23 = v22:Cross(Vector3.new(0, 1, 0));
            local v24 = v;

            for _, v2 in v.lines do
                local v25 = v24.root.Position + v23 * v2.x + Vector3.new(0, 1, 0) * v2.y - v22 * 0.6;
                local v26 = v19 and 0.065 or 0.045;
                v2.a.WorldPosition = v25 + Vector3.new(0, 1, 0) * v26;
                v2.b.WorldPosition = v25 - Vector3.new(0, 1, 0) * v26;
                v2.trail.Lifetime = v19 and 0.24 or BoostVFXConfig.TrailLifetime;
                v2.trail.Enabled = v20;
            end;
        else
            local v27 = u1[i];

            if v27 then
                for _, v2 in v27.objects do
                    v2:Destroy();
                end;

                u1[i] = nil;
            end;
        end;
    end;
end);
script.Destroying:Connect(function() -- Line: 74
    -- upvalues: u28 (copy), u1 (copy)
    u28:Disconnect();

    for i in u1 do
        local v29 = u1[i];

        if v29 then
            for _, v in v29.objects do
                v:Destroy();
            end;

            u1[i] = nil;
        end;
    end;
end);