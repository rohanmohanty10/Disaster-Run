 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local Lighting = game:GetService("Lighting");
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local Debris = workspace:FindFirstChild("Debris");

local function CloneCharacter(p1, p2, p3) -- Line: 13
    -- upvalues: Debris (copy)
    local Archivable = p1.Archivable;
    p1.Archivable = true;
    local v4 = p1:Clone();
    v4.Parent = p2 or Debris;
    v4.HumanoidRootPart.Anchored = true;
    v4.Humanoid.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
    v4.HumanoidRootPart.CFrame = p3 or p1.HumanoidRootPart.CFrame;

    for _, descendant in v4:GetDescendants() do
        if descendant:IsA("BasePart") then
            descendant.CanCollide = false;
        elseif descendant:IsA("Highlight") or (descendant:IsA("Weld") or descendant:IsA("WeldConstraint")) and not descendant:FindFirstAncestorWhichIsA("Accessory") then
            descendant:Destroy();
        end;
    end;

    p1.Archivable = Archivable;

    return v4;
end;

return function(p5, p6) -- Line: 37
    -- upvalues: Debris (copy), SfxManager (copy), CloneCharacter (copy), Lighting (copy), VfxManager (copy), RunService (copy), TweenService (copy)
    local Player = p6.Player;
    local Character = Player.Character;

    if not Character then
        return;
    end;

    local u7 = script.Stage:Clone();
    u7.Parent = Debris;
    u7:PivotTo(p6.CFrame);

    if p6.Preview then
        local Attachment = Instance.new("Attachment");
        Attachment.Parent = workspace.Terrain;
        Attachment.WorldPosition = p6.CFrame.Position;
        SfxManager:playSound({
            Sound = "ConcertSFX",
            Parent = Attachment
        }).Ended:Once(function() -- Line: 250
            -- upvalues: Attachment (copy)
            Attachment:Destroy();
        end);
        u7:PivotTo(u7.PrimaryPart.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
        u7:ScaleTo(0.3333333333333333);
        VfxManager.Emit(u7.Score);
        VfxManager.Emit(u7.MusicFestival);
        local Lights = u7.Lights;
        local u8 = {};

        for _, child in pairs(Lights:GetChildren()) do
            if child:IsA("BasePart") then
                u8[child] = {
                    Original = child.Orientation,
                    SeedX = math.random(1, 999999),
                    SeedY = math.random(1, 999999),
                    SeedZ = math.random(1, 999999),
                    TimeOffset = math.random() * 5,
                    SpeedOffset = 0.5 + math.random() * 0.75
                };
            end;
        end;

        local u9 = tick();
        local u10 = nil;
        u10 = RunService.Heartbeat:Connect(function() -- Line: 278
            -- upvalues: u9 (copy), u10 (ref), u8 (copy)
            local v11 = tick() - u9;

            if v11 < 3.5 then
                for i, v in pairs(u8) do
                    local Original = v.Original;
                    local v12 = (v11 + v.TimeOffset) * (0.5 * v.SpeedOffset);
                    local v13 = math.noise(v.SeedX, v12) * 35;
                    local v14 = math.noise(v.SeedY, v12) * 35;
                    local v15 = math.noise(v.SeedZ, v12) * 35;
                    i.Orientation = Original + Vector3.new(v13, v14, v15);
                end;

                return;
            end;

            u10:Disconnect();

            for i, v in pairs(u8) do
                i.Orientation = v.Original;
            end;
        end);
        task.delay(3.5, function() -- Line: 304
            -- upvalues: Lights (copy), TweenService (ref)
            local v16 = {};

            for _, child in pairs(Lights:GetChildren()) do
                if child:IsA("BasePart") then
                    local Start = child:FindFirstChild("Start");
                    local End = child:FindFirstChild("End");

                    if Start and (End and (Start:IsA("Attachment") and End:IsA("Attachment"))) then
                        v16[child] = {
                            StartPos = Start.Position,
                            EndPos = End.Position,
                            End = End
                        };
                    end;
                end;
            end;

            for _, v in pairs(v16) do
                TweenService:Create(v.End, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                    Position = v.StartPos
                }):Play();
            end;

            task.wait(1.5);

            for _, v in pairs(v16) do
                TweenService:Create(v.End, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                    Position = v.EndPos
                }):Play();
            end;
        end);
        task.delay(4, function() -- Line: 333
            -- upvalues: u7 (copy), Debris (ref), VfxManager (ref)
            local Ending = u7.Ending;
            Ending.Parent = Debris;
            VfxManager.Emit(Ending);
            VfxManager.DestroyEffect(Ending, 2);
            u7:Destroy();
        end);
        task.wait(4);

        return;
    end;

    SfxManager:playSound({
        Sound = "ConcertSFX",
        Parent = workspace
    });
    local v17 = CloneCharacter(Character, u7, u7.PlayerPos.CFrame);
    v17.Humanoid:LoadAnimation(script.Animations.Player0):Play();
    local v18 = {};

    for _, v in Player.Team:GetPlayers() do
        if v.Character and (v.Character:FindFirstChild("Humanoid") and (v.Character:FindFirstChild("HumanoidRootPart") and v ~= Player)) then
            local v19 = CloneCharacter(v.Character, u7, u7.PlayerPos.CFrame);
            table.insert(v18, v19);
            v19.Humanoid:LoadAnimation(script.Animations[`Player{tostring(#v18)}`]):Play();

            if #v18 >= 3 then
                break;
            end;
        end;
    end;

    if #v18 < 3 then
        for i = #v18 + 1, 3 do
            local v20 = script.Rigs[`Player{tostring(i)}`]:Clone();
            v20.Parent = u7;
            table.insert(v18, v20);
            v20.HumanoidRootPart.CFrame = u7.PlayerPos.CFrame;
            v20.Humanoid:LoadAnimation(script.Animations[`Player{tostring(i)}`]):Play();
            local _ = i;
        end;
    end;

    if not (v18[1] and (v18[2] and v18[3])) then
        u7:Destroy();

        return;
    end;

    local v21 = script.Mic:Clone();
    v21.Parent = v17;
    v21.Handle.Part0 = v17.HumanoidRootPart;
    local v22 = script.Piano:Clone();
    v22.Parent = v18[1];
    v22.Handle.Part0 = v18[1].Torso;
    local v23 = script.Guitar:Clone();
    v23.Parent = v18[2];
    v23.Handle.Part0 = v18[2].Torso;
    local v24 = script.Drums:Clone();
    v24.Parent = v18[3];
    v24.Handle.Part0 = v18[3].HumanoidRootPart;
    local ColorCorrection = Lighting:FindFirstChild("ColorCorrection");
    ColorCorrection.Enabled = false;
    local u25 = ColorCorrection:Clone();
    u25.Name = "CC";
    u25.Parent = Lighting;
    u25.Enabled = true;
    task.delay(4.8, function() -- Line: 112
        -- upvalues: u25 (copy), ColorCorrection (copy)
        u25:Destroy();
        ColorCorrection.Enabled = true;
    end);
    local Bloom = Lighting:FindFirstChild("Bloom");
    Bloom.Enabled = false;
    local u26 = Bloom:Clone();
    u26.Name = "B";
    u26.Parent = Lighting;
    u26.Enabled = true;
    u26.Intensity = 2;
    u26.Threshold = 0.5;
    task.delay(4.8, function() -- Line: 127
        -- upvalues: u26 (copy), Lighting (ref), Bloom (copy)
        u26:Destroy();

        if not Lighting:FindFirstChild("B") then
            Bloom.Enabled = true;
        end;
    end);
    VfxManager.Emit(u7.Score);
    VfxManager.Emit(u7.MusicFestival);
    local Lights = u7.Lights;
    local u27 = {};

    for _, child in pairs(Lights:GetChildren()) do
        if child:IsA("BasePart") then
            u27[child] = {
                Original = child.Orientation,
                SeedX = math.random(1, 999999),
                SeedY = math.random(1, 999999),
                SeedZ = math.random(1, 999999),
                TimeOffset = math.random() * 5,
                SpeedOffset = 0.5 + math.random() * 0.75
            };
        end;
    end;

    local u28 = tick();
    local u29 = nil;
    u29 = RunService.Heartbeat:Connect(function() -- Line: 155
        -- upvalues: u28 (copy), u29 (ref), u27 (copy)
        local v30 = tick() - u28;

        if v30 < 3.5 then
            for i, v in pairs(u27) do
                local Original = v.Original;
                local v31 = (v30 + v.TimeOffset) * (0.5 * v.SpeedOffset);
                local v32 = math.noise(v.SeedX, v31) * 35;
                local v33 = math.noise(v.SeedY, v31) * 35;
                local v34 = math.noise(v.SeedZ, v31) * 35;
                i.Orientation = Original + Vector3.new(v32, v33, v34);
            end;

            return;
        end;

        u29:Disconnect();

        for i, v in pairs(u27) do
            i.Orientation = v.Original;
        end;
    end);
    local BlurEffect = Instance.new("BlurEffect", Lighting);
    BlurEffect.Size = 20;
    TweenService:Create(BlurEffect, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
        Size = 0
    }):Play();
    VfxManager.DestroyEffect(BlurEffect, 0.8);
    u26.Intensity = 15;
    u26.Threshold = 0.5;
    TweenService:Create(u26, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
        Intensity = Bloom.Intensity,
        Threshold = Bloom.Threshold
    }):Play();
    u25.Brightness = 1;
    u25.TintColor = Color3.fromRGB(205, 84, 229);
    TweenService:Create(u25, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
        Brightness = ColorCorrection.Brightness,
        TintColor = ColorCorrection.TintColor
    }):Play();
    task.delay(3.5, function() -- Line: 194
        -- upvalues: Lights (copy), TweenService (ref)
        local v35 = {};

        for _, child in pairs(Lights:GetChildren()) do
            if child:IsA("BasePart") then
                local Start = child:FindFirstChild("Start");
                local End = child:FindFirstChild("End");

                if Start and (End and (Start:IsA("Attachment") and End:IsA("Attachment"))) then
                    v35[child] = {
                        StartPos = Start.Position,
                        EndPos = End.Position,
                        End = End
                    };
                end;
            end;
        end;

        for _, v in pairs(v35) do
            TweenService:Create(v.End, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.Out), {
                Position = v.StartPos
            }):Play();
        end;

        task.wait(1.5);

        for _, v in pairs(v35) do
            TweenService:Create(v.End, TweenInfo.new(0.25, Enum.EasingStyle.Sine, Enum.EasingDirection.In), {
                Position = v.EndPos
            }):Play();
        end;
    end);
    task.delay(4, function() -- Line: 223
        -- upvalues: u7 (copy), Debris (ref), VfxManager (ref), Lighting (ref), TweenService (ref), u26 (copy), Bloom (copy), u25 (copy), ColorCorrection (copy)
        local Ending = u7.Ending;
        Ending.Parent = Debris;
        VfxManager.Emit(Ending);
        VfxManager.DestroyEffect(Ending, 2);
        u7:Destroy();
        local BlurEffect2 = Instance.new("BlurEffect", Lighting);
        BlurEffect2.Size = 20;
        TweenService:Create(BlurEffect2, TweenInfo.new(0.8, Enum.EasingStyle.Linear), {
            Size = 0
        }):Play();
        VfxManager.DestroyEffect(BlurEffect2, 0.8);
        u26.Intensity = 15;
        u26.Threshold = 0.5;
        TweenService:Create(u26, TweenInfo.new(0.8, Enum.EasingStyle.Back), {
            Intensity = Bloom.Intensity,
            Threshold = Bloom.Threshold
        }):Play();
        u25.Brightness = 1;
        u25.TintColor = Color3.fromRGB(205, 84, 229);
        TweenService:Create(u25, TweenInfo.new(0.8, Enum.EasingStyle.Sine), {
            Brightness = ColorCorrection.Brightness,
            TintColor = ColorCorrection.TintColor
        }):Play();
    end);
end;