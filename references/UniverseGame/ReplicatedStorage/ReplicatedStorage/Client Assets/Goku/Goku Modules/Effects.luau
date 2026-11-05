  

 

local Funcs = require(game.ReplicatedStorage["Client Assets"].Goku["Goku Modules"].Funcs);
local Thread = Funcs.Thread;
local Wait = Funcs.Wait;
local Tween = Funcs.Tween;
local _ = Funcs.Raycast;
local _ = Funcs.GetFloor;

local function ForEach(p1, p2) -- Line: 8
    for i, v in pairs(p1) do
        p2(i, v);
    end;
end;

local u3 = {};
local v4 = script:GetChildren();

local function _(p5, p6) -- Line: 15
    -- upvalues: u3 (copy)
    u3[p6.Name] = p6:Clone();

    if p6:IsA("BasePart") then
        p6.CFrame = CFrame.new(0, 50, 0);
        p6.Massless = true;
        p6.Transparency = 1;
        p6.Anchored = true;
    end;
end;

local v7 = {};

for _, v in pairs(v4) do
    u3[v.Name] = v:Clone();

    if v:IsA("BasePart") then
        v.CFrame = CFrame.new(0, 50, 0);
        v.Massless = true;
        v.Transparency = 1;
        v.Anchored = true;
    end;
end;

function Glue(p8, p9)
    local Weld = Instance.new("Weld");
    Weld.Part0 = p8;
    Weld.Part1 = p9;
    Weld.C0 = CFrame.new();
    Weld.C1 = p9.CFrame:inverse() * p8.CFrame;
    Weld.Parent = p8;

    return Weld;
end;

function v7.GenerateCircle(p10, u11) -- Line: 35
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u12 = u3.Circle:Clone();
    u12.CFrame = u11.CFrame;
    u12.CanCollide = false;
    u12.Anchored = true;
    u12.Color = u11.Color;
    u12.Transparency = u11.Transparency;
    u12.Size = u12.Size;
    u12.Material = u11.Material or Enum.Material.SmoothPlastic;
    u12.Mesh.Scale = u12.Size;
    u12.CastShadow = false;
    u12.Parent = workspace.Effects;

    if u11.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u12, u11.Time * 1.35);
        Tween(u12, u11.Time, u11.Style, u11.Direction, u11.PartProperties);
        Tween(u12.Mesh, u11.Time, u11.Style, u11.Direction, u11.MeshProperties);

        return;
    end;

    game:GetService("Debris"):AddItem(u12, (u11.Time + u11.Time2 + u11.TimeBetween) * 1.25);
    Tween(u12, u11.Time, u11.Style, u11.Direction, u11.PartProperties);
    Tween(u12.Mesh, u11.Time, u11.Style, u11.Direction, u11.MeshProperties);
    Thread(function() -- Line: 51
        -- upvalues: Wait (ref), u11 (copy), Tween (ref), u12 (copy)
        Wait(u11.Time + 0.05 + u11.TimeBetween);
        Tween(u12, u11.Time, u11.Style, u11.Direction, u11.PartProperties2);
        Tween(u12.Mesh, u11.Time, u11.Style, u11.Direction, u11.MeshProperties2);
    end);
end;

function v7.UICylinder(p13, u14) -- Line: 63
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u15 = u3.Cylinder:Clone();
    u15.CFrame = u14.CFrame;
    u15.CanCollide = false;
    u15.Anchored = true;
    u15.CastShadow = false;
    u15.Color = u14.Color;
    u15.Material = u14.Material or Enum.Material.SmoothPlastic;
    u15.Transparency = u14.Transparency;
    u15.Size = u14.Size;
    u15.Parent = workspace.Effects;

    if u14.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u15, u14.Time * 1.35);
        Tween(u15, u14.Time, u14.Style, u14.Direction, u14.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u15, (u14.Time + u14.Time2 + u14.TimeBetween) * 1.25);
    Tween(u15, u14.Time, u14.Style, u14.Direction, u14.Properties);
    Thread(function() -- Line: 77
        -- upvalues: Wait (ref), u14 (copy), Tween (ref), u15 (copy)
        Wait(u14.Time + 0.05 + u14.TimeBetween);
        Tween(u15, u14.Time2, u14.Style, u14.Direction, u14.Properties2);
    end);
end;

function v7.GenerateCube(p16, u17) -- Line: 87
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u18 = u3.Cube:Clone();
    u18.CFrame = u17.CFrame;
    u18.CanCollide = false;
    u18.Anchored = true;
    u18.CastShadow = false;
    u18.Color = u17.Color;
    u18.Material = u17.Material or Enum.Material.SmoothPlastic;
    u18.Transparency = u17.Transparency;
    u18.Size = u17.Size;
    u18.Parent = workspace.Effects;

    if u17.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u18, u17.Time * 1.35);
        Tween(u18, u17.Time, u17.Style, u17.Direction, u17.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u18, (u17.Time + u17.Time2 + u17.TimeBetween) * 1.25);
    Tween(u18, u17.Time, u17.Style, u17.Direction, u17.Properties);
    Thread(function() -- Line: 101
        -- upvalues: Wait (ref), u17 (copy), Tween (ref), u18 (copy)
        Wait(u17.Time + 0.05 + u17.TimeBetween);
        Tween(u18, u17.Time2, u17.Style, u17.Direction, u17.Properties2);
    end);
end;

function v7.GenerateWave(p19, u20) -- Line: 111
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u21 = u3[u20.WaveType .. "Wave"]:Clone();
    u21.CFrame = u20.CFrame;
    u21.CanCollide = false;
    u21.Anchored = true;
    u21.CastShadow = false;
    u21.Color = u20.Color;
    u21.Material = u20.Material or Enum.Material.SmoothPlastic;
    u21.Transparency = u20.Transparency;
    u21.Size = u20.StartSize;
    u21.Parent = workspace.Effects;

    if u20.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u21, u20.Time * 1.35);
        Tween(u21, u20.Time, u20.Style, u20.Direction, u20.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u21, (u20.Time + u20.Time2 + u20.TimeBetween) * 1.25);
    Tween(u21, u20.Time, u20.Style, u20.Direction, u20.Properties);
    Thread(function() -- Line: 125
        -- upvalues: Wait (ref), u20 (copy), Tween (ref), u21 (copy)
        Wait(u20.Time + 0.05 + u20.TimeBetween);
        Tween(u21, u20.Time2, u20.Style, u20.Direction, u20.Properties2);
    end);
end;

function v7.GenerateSphere(p22, u23) -- Line: 135
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u24 = u3.Sphere:Clone();
    u24.CFrame = u23.CFrame;
    u24.CanCollide = false;
    u24.Anchored = true;
    u24.CastShadow = false;
    u24.Color = u23.Color;
    u24.Material = u23.Material or Enum.Material.SmoothPlastic;
    u24.Transparency = u23.Transparency;
    u24.Size = u23.Size;
    u24.Parent = workspace.Effects;

    if u23.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u24, u23.Time * 1.35);
        Tween(u24, u23.Time, u23.Style, u23.Direction, u23.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u24, (u23.Time + u23.Time2 + u23.TimeBetween) * 1.25);
    Tween(u24, u23.Time, u23.Style, u23.Direction, u23.Properties);
    Thread(function() -- Line: 149
        -- upvalues: Wait (ref), u23 (copy), Tween (ref), u24 (copy)
        Wait(u23.Time + 0.05 + u23.TimeBetween);
        Tween(u24, u23.Time2, u23.Style, u23.Direction, u23.Properties2);
    end);
end;

function v7.GenerateGlowAura(p25, u26) -- Line: 159
    -- upvalues: u3 (copy), Wait (copy), Tween (copy), Thread (copy)
    local u27 = {};
    local Part = Instance.new("Part");
    Part.Size = Vector3.new(5.5, 7.1, 4.2);
    Part.CFrame = u26.Character.HumanoidRootPart.CFrame;
    Part.CanCollide = false;
    Part.Anchored = false;
    Part.Material = Enum.Material.Glass;
    Part.Transparency = 0.999;
    Part.CastShadow = false;
    Part.Name = "GLASS";
    Part.Color = Color3.fromRGB(255, 255, 255);
    Part.Massless = true;
    Part.Parent = u26.Character;
    game:GetService("Debris"):AddItem(Part, u26.MoveTime + 0.1);
    Glue(Part, u26.Character.HumanoidRootPart);
    local v28 = u26.Character:GetChildren();

    local function v37(p29, p30) -- Line: 175
        -- upvalues: u3 (ref), u26 (copy), u27 (copy)
        if p30:IsA("BasePart") and (p30.Name ~= "SSJ4Hair" and (p30.Anchored == false and p30.Transparency < 0.9)) then
            local v31 = p30:Clone();

            if v31.Name == "Head" then
                local CFrame2 = v31.CFrame;
                v31 = u3.Head:Clone();
                v31.CFrame = CFrame2;
            end;

            local v32 = v31:GetChildren();

            local function _(p33, p34) -- Line: 183
                if not p34:IsA("SpecialMesh") then
                    p34:Destroy();
                end;
            end;

            for _, v in pairs(v32) do
                if not v:IsA("SpecialMesh") then
                    v:Destroy();
                end;
            end;

            v31.Name = "GlowEffect_" .. p30.Name;
            v31.Size = v31.Size * 1.05;
            v31.Material = Enum.Material.Neon;
            v31.Color = u26.Color;
            v31.CanCollide = false;
            v31.Anchored = false;
            v31.CastShadow = false;
            v31.Transparency = 0.01;

            if p30.Name == "UIHair" then
                local v35 = v31:Clone();
                v35.CFrame = v35.CFrame * CFrame.new(0.019999999999999997, 0.060000000000000005, 0.019999999999999997);
                v35.Parent = u26.Character;
                Glue(v35, p30);
                table.insert(u27, v35);
            else
                local v36 = v31:Clone();
                v36.CFrame = v36.CFrame * CFrame.new(0.019999999999999997, 0.04, 0.019999999999999997);
                v36.Parent = u26.Character;
                Glue(v36, p30);
                table.insert(u27, v36);
            end;

            v31.Parent = u26.Character;
            Glue(v31, p30);
            table.insert(u27, v31);
        end;
    end;

    for i, v in pairs(v28) do
        v37(i, v);
    end;

    Wait();
    local v38 = Part:FindFirstChildOfClass("Weld");
    Tween(v38, u26.MoveTime, u26.Style, u26.Direction, {
        C0 = v38.C0 * CFrame.new(0, -9, 0)
    });
    Thread(function() -- Line: 224
        -- upvalues: Wait (ref), u26 (copy), u27 (copy), Tween (ref)
        Wait(u26.MoveTime + 0.05);

        local function v41(p39, p40) -- Line: 226
            -- upvalues: u26 (ref), Tween (ref)
            if p40 and p40:IsA("BasePart") then
                if p40.Name == "GlowEffect_UIHair" then
                    game:GetService("Debris"):AddItem(p40, u26.PartTime * 2.5 + 0.15);
                    Tween(p40, u26.PartTime * 2.5, u26.Style, u26.Direction, u26.PartProperties);

                    return;
                end;

                game:GetService("Debris"):AddItem(p40, u26.PartTime + 0.15);
                Tween(p40, u26.PartTime, u26.Style, u26.Direction, u26.PartProperties);
            end;
        end;

        for i, v in pairs(u27) do
            v41(i, v);
        end;
    end);
end;

function v7.GenerateSwirl(p42, u43) -- Line: 240
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u44 = u3["Swirl" .. u43.Type]:Clone();
    u44.CFrame = u43.CFrame;
    u44.CanCollide = false;
    u44.Anchored = true;
    u44.CastShadow = false;
    u44.Color = u43.Color;
    u44.Material = u43.Material or Enum.Material.SmoothPlastic;
    u44.Transparency = u43.Transparency;
    u44.Size = u43.Size;
    u44.Parent = workspace.Effects;

    if u43.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u44, u43.Time * 1.35);
        Tween(u44, u43.Time, u43.Style, u43.Direction, u43.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u44, (u43.Time + u43.Time2 + u43.TimeBetween) * 1.25);
    Tween(u44, u43.Time, u43.Style, u43.Direction, u43.Properties);
    Thread(function() -- Line: 254
        -- upvalues: Wait (ref), u43 (copy), Tween (ref), u44 (copy)
        Wait(u43.Time + 0.05 + u43.TimeBetween);
        Tween(u44, u43.Time2, u43.Style, u43.Direction, u43.Properties2);
    end);
end;

function v7.GenerateDash(p45, u46) -- Line: 264
    -- upvalues: u3 (copy), Tween (copy), Thread (copy), Wait (copy)
    local u47 = u3.Dash:Clone();
    u47.CFrame = u46.CFrame;
    u47.CanCollide = false;
    u47.Anchored = true;
    u47.CastShadow = false;
    u47.Color = u46.Color;
    u47.Material = u46.Material or Enum.Material.SmoothPlastic;
    u47.Transparency = u46.Transparency;
    u47.Size = u46.Size;
    u47.Parent = workspace.Effects;

    if u46.TweenAgain ~= true then
        game:GetService("Debris"):AddItem(u47, u46.Time * 1.35);
        Tween(u47, u46.Time, u46.Style, u46.Direction, u46.Properties);

        return;
    end;

    game:GetService("Debris"):AddItem(u47, (u46.Time + u46.Time2 + u46.TimeBetween) * 1.25);
    Tween(u47, u46.Time, u46.Style, u46.Direction, u46.Properties);
    Thread(function() -- Line: 278
        -- upvalues: Wait (ref), u46 (copy), Tween (ref), u47 (copy)
        Wait(u46.Time + 0.05 + u46.TimeBetween);
        Tween(u47, u46.Time2, u46.Style, u46.Direction, u46.Properties2);
    end);
end;

function v7.GenerateShadow(p48, u49) -- Line: 288
    -- upvalues: Thread (copy), Wait (copy), Tween (copy)
    local Character = u49.Character;
    Character.Archivable = true;
    local u50 = Character:Clone();
    u50.Name = "CharacterShadow_" .. tostring(tick());
    Thread(function() -- Line: 293
        -- upvalues: Wait (ref), u50 (copy)
        Wait(0.01);
        u50.Parent = workspace.Effects;
    end);
    game:GetService("Debris"):AddItem(u50, u49.Time * 1.35);
    local v51 = u50:GetDescendants();

    local function v58(p52, u53) -- Line: 298
        -- upvalues: Character (copy), u49 (copy), Tween (ref)
        if not u53:IsA("BasePart") or u53.Name:find("Hair") ~= nil then
            if not u53:IsA("Humanoid") then
                if u53:IsA("Animator") or (u53:IsA("LocalScript") or (u53:IsA("Script") or (u53:IsA("Model") or (u53:IsA("Folder") or (u53:IsA("Sound") or (u53:IsA("ParticleEmitter") or u53:IsA("Decal"))))))) then
                    u53:Destroy();
                end;

                return;
            end;

            u53.MaxHealth = (0 / 0);
            u53.Health = (0 / 0);
            u53.DisplayDistanceType = Enum.HumanoidDisplayDistanceType.None;
            u53.BreakJointsOnDeath = false;
            u53.RequiresNeck = false;

            return;
        end;

        if u53.Transparency > 0.1 then
            u53:Destroy();

            return;
        end;

        local v54 = Character:GetDescendants();

        local function v57(p55, p56) -- Line: 303
            -- upvalues: u53 (copy)
            if p56:IsA("BasePart") then
                if p56:FindFirstChild("No Collision For " .. u53.Name) then
                    p56["No Collision For " .. u53.Name]:Destroy();
                end;

                local NoCollisionConstraint = Instance.new("NoCollisionConstraint");
                NoCollisionConstraint.Name = "No Collision For " .. u53.Name;
                NoCollisionConstraint.Part0 = p56;
                NoCollisionConstraint.Part1 = u53;
                NoCollisionConstraint.Parent = u53;
            end;
        end;

        for i, v in pairs(v54) do
            v57(i, v);
        end;

        u53.Anchored = true;
        u53.CanCollide = false;
        u53.CastShadow = false;
        u53.Color = u49.Color or u53.Color;
        u53.Material = u49.Material or u53.Material;
        u53.Transparency = u49.Transparency;
        Tween(u53, u49.Time, u49.Style, u49.Direction, u49.Properties);
    end;

    for i, v in pairs(v51) do
        v58(i, v);
    end;
end;

function v7.MakeGui(p59, p60) -- Line: 335
    -- upvalues: u3 (copy), Tween (copy), Wait (copy)
    if p60.Type ~= "Transform" then
        if p60.Type == "Text" then
            local v61 = u3.TEXT:Clone();
            v61.Enabled = true;
            v61.Parent = p60.PlayerGui;
            local TextLabel = v61.TextFrame.TextLabel;
            TextLabel.TextTransparency = 1;
            TextLabel.TextStrokeTransparency = 1;
            TextLabel.TextColor3 = p60.TextColor;
            TextLabel.TextStrokeColor3 = p60.StrokeColor;
            TextLabel.Text = p60.Text;
            Tween(TextLabel, p60.Time / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                TextTransparency = 0,
                TextStrokeTransparency = 0
            });
            Wait(p60.Time / 1.95);
            Tween(TextLabel, p60.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
                TextTransparency = 1,
                TextStrokeTransparency = 1
            });
            game:GetService("Debris"):AddItem(v61, p60.Time * 1.25);
        end;

        return;
    end;

    local v62 = u3.GUI:Clone();
    v62.Enabled = true;
    v62.Parent = p60.PlayerGui;
    local ColoredFrame = v62.ColoredFrame;
    ColoredFrame.BackgroundTransparency = 1;
    ColoredFrame.BackgroundColor3 = p60.Color;
    Tween(ColoredFrame, p60.Time / 2, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
        BackgroundTransparency = 0
    });
    Wait(p60.Time / 1.95);
    Tween(ColoredFrame, p60.Time, Enum.EasingStyle.Quad, Enum.EasingDirection.InOut, {
        BackgroundTransparency = 1
    });
    game:GetService("Debris"):AddItem(v62, p60.Time * 1.25);
end;

return v7;