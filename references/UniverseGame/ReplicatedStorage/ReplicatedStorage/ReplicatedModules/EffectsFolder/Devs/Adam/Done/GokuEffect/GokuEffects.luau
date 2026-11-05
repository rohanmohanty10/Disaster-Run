  

 

function Thread(p1)
    coroutine.resume(coroutine.create(p1));
end;

local function ForEach(p2, p3) -- Line: 8
    for i, v in pairs(p2) do
        p3(i, v);
    end;
end;

local u4 = {};
local v5 = game.ReplicatedStorage["Client Assets"].Goku.Things:GetChildren();

local function _(p6, p7) -- Line: 15
    -- upvalues: u4 (copy)
    u4[p7.Name] = p7:Clone();

    if p7:IsA("BasePart") then
        p7.CFrame = CFrame.new(0, 50, 0);
        p7.Massless = true;
        p7.Transparency = 1;
        p7.Anchored = true;
    end;
end;

local v8 = {};

for _, v in pairs(v5) do
    u4[v.Name] = v:Clone();

    if v:IsA("BasePart") then
        v.CFrame = CFrame.new(0, 50, 0);
        v.Massless = true;
        v.Transparency = 1;
        v.Anchored = true;
    end;
end;

function ArtificialWait(p9)
    if p9 == 0 or p9 == nil then
        game:GetService("RunService").Heartbeat:Wait();

        return;
    end;

    local v10 = tick();

    repeat
        game:GetService("RunService").Heartbeat:Wait();
    until p9 <= tick() - v10;
end;

function Tween(p11, p12, p13, p14, p15)
    local v16 = TweenInfo.new(p12, p13, p14);

    return game:GetService("TweenService"):Create(p11, v16, p15):Play();
end;

function Glue(p17, p18)
    local Weld = Instance.new("Weld");
    Weld.Part0 = p17;
    Weld.Part1 = p18;
    Weld.C0 = CFrame.new();
    Weld.C1 = p18.CFrame:inverse() * p17.CFrame;
    Weld.Parent = p17;

    return Weld;
end;

function v8.GenerateCirlce(p19, u20) -- Line: 51
    -- upvalues: u4 (copy)
    local u21 = u4.Circle:Clone();
    u21.CFrame = u20.CFrame;
    u21.CanCollide = false;
    u21.Anchored = true;
    u21.Color = u20.Color;
    u21.Transparency = u20.Transparency;
    u21.Size = u21.Size;
    u21.Material = u20.Material or Enum.Material.SmoothPlastic;
    u21.Mesh.Scale = u21.Size;
    u21.CastShadow = false;
    u21.Parent = game:GetService("Players").LocalPlayer.Character;

    if u20.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u21, u20.Time * 1.35);
        Tween(u21, u20.Time, u20.Style, u20.Direction, u20.PartProperties);
        Tween(u21.Mesh, u20.Time, u20.Style, u20.Direction, u20.MeshProperties);

        return;
    end;

    game:GetService("Debris"):AddItem(u21, (u20.Time + u20.Time2 + u20.TimeBetween) * 1.25);
    Tween(u21, u20.Time, u20.Style, u20.Direction, u20.PartProperties);
    Tween(u21.Mesh, u20.Time, u20.Style, u20.Direction, u20.MeshProperties);
    Thread(function() -- Line: 67
        -- upvalues: u20 (copy), u21 (copy)
        ArtificialWait(u20.Time + 0.05 + u20.TimeBetween);
        Tween(u21, u20.Time, u20.Style, u20.Direction, u20.PartProperties2);
        Tween(u21.Mesh, u20.Time, u20.Style, u20.Direction, u20.MeshProperties2);
    end);
end;

function v8.UICylinder(p22, u23) -- Line: 79
    -- upvalues: u4 (copy)
    local u24 = u4.Cylinder:Clone();
    u24.CFrame = u23.CFrame;
    u24.CanCollide = false;
    u24.Anchored = true;
    u24.CastShadow = false;
    u24.Color = u23.Color;
    u24.Material = u23.Material or Enum.Material.SmoothPlastic;
    u24.Transparency = u23.Transparency;
    u24.Size = u23.Size;
    u24.Parent = game:GetService("Players").LocalPlayer.Character;

    if u23.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u24, u23.Time * 1.35);
        Tween(u24, u23.Time, u23.Style, u23.Direction, u23.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u24, (u23.Time + u23.Time2 + u23.TimeBetween) * 1.25);
    Tween(u24, u23.Time, u23.Style, u23.Direction, u23.Properties);
    Thread(function() -- Line: 93
        -- upvalues: u23 (copy), u24 (copy)
        ArtificialWait(u23.Time + 0.05 + u23.TimeBetween);
        Tween(u24, u23.Time2, u23.Style, u23.Direction, u23.Properties2);
    end);
end;

function v8.GenerateCube(p25, u26) -- Line: 103
    -- upvalues: u4 (copy)
    local u27 = u4.Cube:Clone();
    u27.CFrame = u26.CFrame;
    u27.CanCollide = false;
    u27.Anchored = true;
    u27.CastShadow = false;
    u27.Color = u26.Color;
    u27.Material = u26.Material or Enum.Material.SmoothPlastic;
    u27.Transparency = u26.Transparency;
    u27.Size = u26.Size;
    u27.Parent = game:GetService("Players").LocalPlayer.Character;

    if u26.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u27, u26.Time * 1.35);
        Tween(u27, u26.Time, u26.Style, u26.Direction, u26.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u27, (u26.Time + u26.Time2 + u26.TimeBetween) * 1.25);
    Tween(u27, u26.Time, u26.Style, u26.Direction, u26.Properties);
    Thread(function() -- Line: 117
        -- upvalues: u26 (copy), u27 (copy)
        ArtificialWait(u26.Time + 0.05 + u26.TimeBetween);
        Tween(u27, u26.Time2, u26.Style, u26.Direction, u26.Properties2);
    end);
end;

function v8.GenerateWave(p28, u29) -- Line: 127
    -- upvalues: u4 (copy)
    local u30 = u4[u29.WaveType .. "Wave"]:Clone();
    u30.CFrame = u29.CFrame;
    u30.CanCollide = false;
    u30.Anchored = true;
    u30.CastShadow = false;
    u30.Color = u29.Color;
    u30.Material = u29.Material or Enum.Material.SmoothPlastic;
    u30.Transparency = u29.Transparency;
    u30.Size = u29.StartSize;
    u30.Parent = game:GetService("Players").LocalPlayer.Character;

    if u29.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u30, u29.Time * 1.35);
        Tween(u30, u29.Time, u29.Style, u29.Direction, u29.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u30, (u29.Time + u29.Time2 + u29.TimeBetween) * 1.25);
    Tween(u30, u29.Time, u29.Style, u29.Direction, u29.Properties);
    Thread(function() -- Line: 141
        -- upvalues: u29 (copy), u30 (copy)
        ArtificialWait(u29.Time + 0.05 + u29.TimeBetween);
        Tween(u30, u29.Time2, u29.Style, u29.Direction, u29.Properties2);
    end);
end;

function v8.GenerateSphere(p31, u32) -- Line: 151
    -- upvalues: u4 (copy)
    local u33 = u4.Sphere:Clone();
    u33.CFrame = u32.CFrame;
    u33.CanCollide = false;
    u33.Anchored = true;
    u33.CastShadow = false;
    u33.Color = u32.Color;
    u33.Material = u32.Material or Enum.Material.SmoothPlastic;
    u33.Transparency = u32.Transparency;
    u33.Size = u32.Size;
    u33.Parent = game:GetService("Players").LocalPlayer.Character;

    if u32.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u33, u32.Time * 1.35);
        Tween(u33, u32.Time, u32.Style, u32.Direction, u32.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u33, (u32.Time + u32.Time2 + u32.TimeBetween) * 1.25);
    Tween(u33, u32.Time, u32.Style, u32.Direction, u32.Properties);
    Thread(function() -- Line: 165
        -- upvalues: u32 (copy), u33 (copy)
        ArtificialWait(u32.Time + 0.05 + u32.TimeBetween);
        Tween(u33, u32.Time2, u32.Style, u32.Direction, u32.Properties2);
    end);
end;

function v8.GenerateGlowAura(p34, u35) -- Line: 175
    -- upvalues: u4 (copy)
    local u36 = {};
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(5.5, 7.1, 4.2);
    Part.CFrame = u35.Character.HumanoidRootPart.CFrame;
    Part.CanCollide = false;
    Part.Anchored = false;
    Part.Material = Enum.Material.Glass;
    Part.Transparency = 0.999;
    Part.CastShadow = false;
    Part.Name = "GLASS";
    Part.Color = Color3.fromRGB(255, 255, 255);
    Part.Massless = true;
    Part.Parent = u35.Character;
    game:GetService("Debris"):AddItem(Part, u35.MoveTime + 0.1);
    Glue(Part, u35.Character.HumanoidRootPart);
    local v37 = u35.Character:GetChildren();

    local function v46(p38, p39) -- Line: 191
        -- upvalues: u4 (ref), u35 (copy), u36 (copy)
        if p39:IsA("BasePart") and (p39.Name ~= "SSJ4Hair" and (p39.Anchored == false and p39.Transparency < 0.9)) then
            local v40 = p39:Clone();

            if v40.Name == "Head" then
                local CFrame2 = v40.CFrame;
                v40 = u4.Head:Clone();
                v40.CFrame = CFrame2;
            end;

            local v41 = v40:GetChildren();

            local function _(p42, p43) -- Line: 199
                if not p43:IsA("SpecialMesh") then
                    p43:Destroy();
                end;
            end;

            for _, v in pairs(v41) do
                if not v:IsA("SpecialMesh") then
                    v:Destroy();
                end;
            end;

            v40.Name = "GlowEffect_" .. p39.Name;
            v40.Size = v40.Size * 1.05;
            v40.Material = Enum.Material.Neon;
            v40.Color = u35.Color;
            v40.CanCollide = false;
            v40.Anchored = false;
            v40.CastShadow = false;
            v40.Transparency = 0.01;

            if p39.Name == "UIHair" then
                local v44 = v40:Clone();
                v44.CFrame = v44.CFrame * CFrame.new(0.019999999999999997, 0.060000000000000005, 0.019999999999999997);
                v44.Parent = u35.Character;
                Glue(v44, p39);
                table.insert(u36, v44);
            else
                local v45 = v40:Clone();
                v45.CFrame = v45.CFrame * CFrame.new(0.019999999999999997, 0.04, 0.019999999999999997);
                v45.Parent = u35.Character;
                Glue(v45, p39);
                table.insert(u36, v45);
            end;

            v40.Parent = u35.Character;
            Glue(v40, p39);
            table.insert(u36, v40);
        end;
    end;

    for i, v in pairs(v37) do
        v46(i, v);
    end;

    ArtificialWait();
    local v47 = Part:FindFirstChildOfClass("Weld");
    Tween(v47, u35.MoveTime, u35.Style, u35.Direction, {
        C0 = v47.C0 * CFrame.new(0, -9, 0)
    });
    Thread(function() -- Line: 240
        -- upvalues: u35 (copy), u36 (copy)
        ArtificialWait(u35.MoveTime + 0.05);

        local function v50(p48, p49) -- Line: 242
            -- upvalues: u35 (ref)
            if p49 and p49:IsA("BasePart") then
                if p49.Name == "GlowEffect_UIHair" then
                    game:GetService("Debris"):AddItem(p49, u35.PartTime * 2.5 + 0.15);
                    Tween(p49, u35.PartTime * 2.5, u35.Style, u35.Direction, u35.PartProperties);

                    return;
                end;

                game:GetService("Debris"):AddItem(p49, u35.PartTime + 0.15);
                Tween(p49, u35.PartTime, u35.Style, u35.Direction, u35.PartProperties);
            end;
        end;

        for i, v in pairs(u36) do
            v50(i, v);
        end;
    end);
end;

function v8.GenerateSwirl(p51, u52) -- Line: 256
    -- upvalues: u4 (copy)
    local u53 = u4["Swirl" .. u52.Type]:Clone();
    u53.CFrame = u52.CFrame;
    u53.CanCollide = false;
    u53.Anchored = true;
    u53.CastShadow = false;
    u53.Color = u52.Color;
    u53.Material = u52.Material or Enum.Material.SmoothPlastic;
    u53.Transparency = u52.Transparency;
    u53.Size = u52.Size;
    u53.Parent = game:GetService("Players").LocalPlayer.Character;

    if u52.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u53, u52.Time * 1.35);
        Tween(u53, u52.Time, u52.Style, u52.Direction, u52.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u53, (u52.Time + u52.Time2 + u52.TimeBetween) * 1.25);
    Tween(u53, u52.Time, u52.Style, u52.Direction, u52.Properties);
    Thread(function() -- Line: 270
        -- upvalues: u52 (copy), u53 (copy)
        ArtificialWait(u52.Time + 0.05 + u52.TimeBetween);
        Tween(u53, u52.Time2, u52.Style, u52.Direction, u52.Properties2);
    end);
end;

function v8.GenerateDash(p54, u55) -- Line: 280
    -- upvalues: u4 (copy)
    local u56 = u4.Dash:Clone();
    u56.CFrame = u55.CFrame;
    u56.CanCollide = false;
    u56.Anchored = true;
    u56.CastShadow = false;
    u56.Color = u55.Color;
    u56.Material = u55.Material or Enum.Material.SmoothPlastic;
    u56.Transparency = u55.Transparency;
    u56.Size = u55.Size;
    u56.Parent = game:GetService("Players").LocalPlayer.Character;

    if u55.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u56, u55.Time * 1.35);
        Tween(u56, u55.Time, u55.Style, u55.Direction, u55.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u56, (u55.Time + u55.Time2 + u55.TimeBetween) * 1.25);
    Tween(u56, u55.Time, u55.Style, u55.Direction, u55.Properties);
    Thread(function() -- Line: 294
        -- upvalues: u55 (copy), u56 (copy)
        ArtificialWait(u55.Time + 0.05 + u55.TimeBetween);
        Tween(u56, u55.Time2, u55.Style, u55.Direction, u55.Properties2);
    end);
end;

function v8.GenerateShadow(p57, u58) -- Line: 304
    local Character = u58.Character;
    Character.Archivable = true;
    local u59 = Character:Clone();
    u59.Name = "CharacterShadow_" .. tostring(tick());
    Thread(function() -- Line: 309
        -- upvalues: u59 (copy)
        ArtificialWait(0.01);
        u59.Parent = game:GetService("Players").LocalPlayer.Character;
    end);
    game:GetService("Debris"):AddItem(u59, u58.Time * 1.35);
    local v60 = u59:GetDescendants();

    local function v67(p61, u62) -- Line: 314
        -- upvalues: Character (copy), u58 (copy)
        if not u62:IsA("BasePart") or u62.Name:find("Hair") ~= nil then
            if not u62:IsA("Humanoid") then
                if u62:IsA("Animator") or (u62:IsA("LocalScript") or (u62:IsA("Script") or (u62:IsA("Model") or (u62:IsA("Folder") or (u62:IsA("Sound") or (u62:IsA("ParticleEmitter") or u62:IsA("Decal"))))))) then
                    u62:Destroy();
                end;

                return;
            end;

            u62.MaxHealth = (0 / 0);
            u62.Health = (0 / 0);
            u62.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            u62.BreakJointsOnDeath = false;
            u62.RequiresNeck = false;

            return;
        end;

        if u62.Transparency > 0.1 then
            u62:Destroy();

            return;
        end;

        local v63 = Character:GetDescendants();

        local function v66(p64, p65) -- Line: 319
            -- upvalues: u62 (copy)
            if p65:IsA("BasePart") then
                if p65:FindFirstChild("No Collision For " .. u62.Name) then
                    p65["No Collision For " .. u62.Name]:Destroy();
                end;

                local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                NoCollisionConstraint.Name = "No Collision For " .. u62.Name;
                NoCollisionConstraint.Part0 = p65;
                NoCollisionConstraint.Part1 = u62;
                NoCollisionConstraint.Parent = u62;
            end;
        end;

        for i, v in pairs(v63) do
            v66(i, v);
        end;

        u62.Anchored = true;
        u62.CanCollide = false;
        u62.CastShadow = false;
        u62.Color = u58.Color or u62.Color;
        u62.Material = u58.Material or u62.Material;
        u62.Transparency = u58.Transparency;
        Tween(u62, u58.Time, u58.Style, u58.Direction, u58.Properties);
    end;

    for i, v in pairs(v60) do
        v67(i, v);
    end;
end;

function v8.MakeGui(p68, p69) -- Line: 351
    -- upvalues: u4 (copy)
    if p69.Type ~= "Transform" then
        if p69.Type == "Text" then
            local v70 = u4.TEXT:Clone();
            v70.Enabled = true;
            v70.IgnoreGuiInset = true;
            v70.Parent = p69.PlayerGui;
            local TextLabel = v70.TextFrame.TextLabel;
            TextLabel.TextTransparency = 1;
            TextLabel.TextStrokeTransparency = 1;
            TextLabel.TextColor3 = p69.TextColor;
            TextLabel.TextStrokeColor3 = p69.StrokeColor;
            TextLabel.Text = p69.Text;
            Tween(TextLabel, p69.Time / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                TextTransparency = 0,
                TextStrokeTransparency = 0
            });
            ArtificialWait(p69.Time / 1.95);
            Tween(TextLabel, p69.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            });
            game:GetService("Debris"):AddItem(v70, p69.Time * 1.25);
        end;

        return;
    end;

    local v71 = u4.GUI:Clone();
    v71.Enabled = true;
    v71.IgnoreGuiInset = true;
    v71.Parent = p69.PlayerGui;
    local ColoredFrame = v71.ColoredFrame;
    ColoredFrame.BackgroundTransparency = 1;
    ColoredFrame.BackgroundColor3 = p69.Color;
    Tween(ColoredFrame, p69.Time / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
        BackgroundTransparency = 0
    });
    ArtificialWait(p69.Time / 1.95);
    Tween(ColoredFrame, p69.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
        BackgroundTransparency = 1
    });
    game:GetService("Debris"):AddItem(v71, p69.Time * 1.25);
end;

return v8;