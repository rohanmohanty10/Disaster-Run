 

 

local v1 = {};
game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local script_Bezier = require(script.Bezier);
local script_PartCache = require(script.PartCache);
local script_BoatTween = require(script.BoatTween);

if not workspace:FindFirstChild("Effects") then
    folder = Instance.new("Folder", workspace);
    folder.Name = "Effects";
end;

local function QuadraticBezier(p2, p3, p4, p5) -- Line: 17
    return (1 - p2) ^ 2 * p3 + 2 * (1 - p2) * p2 * p4 + p2 ^ 2 * p5;
end;

function v1.Emit(p6: userdata) -- Line: 21
    for _, descendant in p6:GetDescendants() do
        if descendant:IsA("ParticleEmitter") then
            local u7 = descendant:GetAttribute("EmitCount") or 5;
            local v8 = descendant:GetAttribute("EmitDelay") or 0;
            local Attribute = descendant:GetAttribute("EmitDuration");

            if Attribute and Attribute ~= 0 then
                task.delay(v8, function() -- Line: 36
                    -- upvalues: descendant (copy), Attribute (copy)
                    descendant.Enabled = true;
                    task.delay(Attribute, function() -- Line: 39
                        -- upvalues: descendant (ref)
                        descendant.Enabled = false;
                    end);
                end);
            else
                task.delay(v8, function() -- Line: 30
                    -- upvalues: descendant (copy), u7 (copy)
                    descendant:Emit(u7);
                end);
            end;
        end;
    end;
end;

function v1.BeamEmit(u9, p10, u11, u12, u13, p14) -- Line: 47
    -- upvalues: TweenService (copy), script_BoatTween (copy)
    if not u9:IsA("Beam") then
        return;
    end;

    if p10 == "Width" then
        TweenService:Create(u9, TweenInfo.new(u11), {
            Width0 = u12,
            Width1 = u13
        }):Play();
    elseif p10 == "Transparency" then
        task.spawn(function() -- Line: 52
            -- upvalues: script_BoatTween (ref), u9 (copy), u11 (copy), u12 (copy), u13 (copy)
            local v15 = script_BoatTween:Create(u9, {
                EasingStyle = "Linear",
                EasingDirection = "InOut",
                Reverses = false,
                DelayTime = 0,
                StepType = "Heartbeat",
                Time = u11,
                Goal = {
                    Transparency = NumberSequence.new({ NumberSequenceKeypoint.new(0, u12), NumberSequenceKeypoint.new(1, u13) })
                }
            });
            v15:Play();
            v15.Completed:Wait();

            if u12 == 1 and u13 == 1 then
                u9.Enabled = false;
            end;
        end);
    elseif p10 == "TextureSpeed" then
        TweenService:Create(u9, TweenInfo.new(u11), {
            TextureSpeed = u12
        }):Play();
    end;

    u9.Enabled = true;
end;

function v1.ToggleEnable(u16: userdata, u17: number, u18: table, u19: boolean) -- Line: 83
    task.spawn(function() -- Line: 84
        -- upvalues: u16 (copy), u19 (copy), u18 (copy), u17 (copy)
        local function enable(p20) -- Line: 85
            -- upvalues: u16 (ref), u19 (ref), u18 (ref)
            for _, descendant in u16:GetDescendants() do
                if descendant:IsA("ParticleEmitter") and (not descendant:IsA("Beam") or u19 and descendant:IsA("Beam")) and not (u18 and (table.find(u18, descendant.Name) ~= nil or table.find(u18, descendant.Parent.Name) ~= nil)) then
                    descendant.Enabled = p20;
                end;
            end;
        end;

        enable(true);

        if u17 ~= nil then
            task.delay(u17, function() -- Line: 98
                -- upvalues: enable (copy)
                enable(false);
            end);
        end;
    end);
end;

function v1.ImpactFrame(u21) -- Line: 105
    coroutine.wrap(function() -- Line: 106
        -- upvalues: u21 (copy)
        local function showFrame(p22, p23) -- Line: 107
            game.Lighting[p23 .. "Impact"].Enabled = true;
            task.wait(p22);
            game.Lighting[p23 .. "Impact"].Enabled = false;
        end;

        if u21 == "BlackWhite" then
            game.Lighting.BlackImpact.Enabled = true;
            task.wait(0.05);
            game.Lighting.BlackImpact.Enabled = false;
            game.Lighting.WhiteImpact.Enabled = true;
            task.wait(0.05);
            game.Lighting.WhiteImpact.Enabled = false;

            return;
        end;

        if u21 ~= "QuickRed" then
            local v24 = u21;
            game.Lighting[v24 .. "Impact"].Enabled = true;
            task.wait(0.05);
            game.Lighting[v24 .. "Impact"].Enabled = false;

            return;
        end;

        game.Lighting.BlackImpact.Enabled = true;
        task.wait(0.02);
        game.Lighting.BlackImpact.Enabled = false;
        game.Lighting.WhiteImpact.Enabled = true;
        task.wait(0.02);
        game.Lighting.WhiteImpact.Enabled = false;
        game.Lighting.RedImpact.Enabled = true;
        task.wait(0.02);
        game.Lighting.RedImpact.Enabled = false;
        game.Lighting.WhiteImpact.Enabled = true;
        task.wait(0.02);
        game.Lighting.WhiteImpact.Enabled = false;
        game.Lighting.BlackImpact.Enabled = true;
        task.wait(0.02);
        game.Lighting.BlackImpact.Enabled = false;
    end)();
end;

function cubicBezier(p25, p26, p27, p28, p29)
    return (1 - p25) ^ 3 * p26 + 3 * (1 - p25) ^ 2 * p25 * p27 + 3 * (1 - p25) * p25 ^ 2 * p28 + p25 ^ 3 * p29;
end;

local function showTrail(p30, p31) -- Line: 132
    for _, descendant in pairs(p30:GetDescendants()) do
        if descendant:IsA("Trail") or descendant:IsA("ParticleEmitter") then
            descendant.Enabled = p31;
        end;
    end;
end;

function v1.CreateBezierTrails(u32: userdata, u33: number?, u34, u35: number, u36: number, u37: number, u38: boolean) -- Line: 140
    -- upvalues: showTrail (copy), script_PartCache (copy), script_Bezier (copy)
    task.spawn(function() -- Line: 141
        -- upvalues: showTrail (ref), u32 (copy), script_PartCache (ref), u36 (copy), u34 (copy), u33 (copy), u38 (copy), script_Bezier (ref), u37 (copy), u35 (copy)
        showTrail(u32, false);
        local u39 = script_PartCache.new(u32, u36, workspace.Effects);

        for i = 1, u36 do
            task.spawn(function() -- Line: 147
                -- upvalues: u39 (copy), u34 (ref), u33 (ref), showTrail (ref), u38 (ref), script_Bezier (ref), u37 (ref)
                local Part = u39:GetPart();
                local CFrame_Angles = CFrame.Angles;
                local math_random_ret = math.random(-180, 180);
                local math_rad_ret = math.rad(math_random_ret);
                local math_random_ret2 = math.random(-180, 180);
                local math_rad_ret2 = math.rad(math_random_ret2);
                local math_random_ret3 = math.random(-180, 180);
                Part.CFrame = u34 * CFrame_Angles(math_rad_ret, math_rad_ret2, (math.rad(math_random_ret3))) * CFrame.new(0, 0, -u33);
                Part.CFrame = CFrame.new(Part.Position, u34.Position);
                showTrail(Part, true);
                local Position = Part.Position;
                local v40 = Part.CFrame.upVector * (math.random(-u33 * 100, u33 * 100) / 100) + Part.CFrame.rightVector * (math.random(-u33 * 100, u33 * 100) / 100) + Position;
                local v41 = Part.CFrame.lookVector * (u33 / 2) + Part.CFrame.upVector * (math.random(-u33 * 100, u33 * 100) / 100) + Part.CFrame.rightVector * (math.random(-u33 * 100, u33 * 100) / 100) + Part.Position;
                local Position2 = u34.Position;
                local v42;

                if u38 == nil or u38 ~= true then
                    v42 = script_Bezier.new(Position, v40, v41, Position2);
                else
                    v42 = script_Bezier.new(Position2, v41, v40, Position);
                end;

                local v43 = v42:CreateCFrameTween(Part, { "CFrame" }, (TweenInfo.new(u37, Enum.EasingStyle.Sine, Enum.EasingDirection.Out)));
                v43:Play();
                v43.Completed:Wait();
                showTrail(Part, false);
            end);
            task.wait(u35 / u36);
            local _ = i;
        end;

        task.wait(u37 + 2);
        u39:Dispose();
    end);
end;

function v1.OrbitingTrails(p44, p45, p46, p47, p48) -- Line: 185
    -- upvalues: script_PartCache (copy)
    local v49 = {};

    for i = 1, #p45 do
        v49[i] = script_PartCache.new(p45[i], p46, folder);
        local _ = i;
    end;

    if p48.MinLifetime then
        p48.MinLifetime = p48.MinLifetime * 100;
    end;

    if p48.MaxLifetime then
        p48.MaxLifetime = p48.MaxLifetime * 100;
    end;

    for i = 1, p46 do
        local _ = i;

        for i2 = 1, #p45 do
            local CFrame2 = p44.CFrame;
            local Part = v49[i2]:GetPart();
            Part.Trail.Enabled = false;
            Part.Parent = folder;
            local v50 = p48 and (p48.MinRadius or 10) or 10;
            local v51 = p48 and (p48.MaxRadius or 15) or 15;
            local v52 = p48 and (p48.MinLifetime or 25) or 25;
            local v53 = p48 and (p48.MaxLifetime or 125) or 125;
            local v54 = p48 and (p48.MinYSpeed or 0) or 0;
            local v55 = p48 and (p48.MaxYSpeed or 0) or 0;
            local math_random_ret = math.random(p48 and (p48.MinOffset or -2) or -2, p48 and (p48.MaxOffset or 8) or 8);
            local v56 = CFrame2 * CFrame.new(0, math_random_ret, 0);
            local CFrame_Angles = CFrame.Angles;
            local math_random_ret2 = math.random(-180, 180);
            local u57 = v56 * CFrame_Angles(0, math.rad(math_random_ret2), 0);
            local math_random_ret3 = math.random(v50, v51);
            local u58 = math.random(v52, v53) / 100;
            local u59 = 6.283185307179586 / u58;
            local math_random_ret4 = math.random(v54, v55);
            local u60 = 0;
            local u62 = game:GetService("RunService").Heartbeat:Connect(function(p61) -- Line: 226
                -- upvalues: Part (copy), u57 (copy), math_random_ret3 (copy), u60 (ref), u59 (copy), math_random_ret4 (copy)
                Part.CFrame = CFrame.new((u57 * CFrame.new(math_random_ret3 * math.cos(u60 * u59), math_random_ret4 * -u60, math_random_ret3 * math.sin(u60 * u59))).Position, u57.Position);
                u60 = u60 - p61;
            end);
            task.delay(0.05, function() -- Line: 232
                -- upvalues: Part (copy), u58 (copy), u62 (copy)
                Part.Trail.Enabled = true;
                task.wait(u58);
                u62:Disconnect();
                Part.Trail.Enabled = false;
            end);
            local _ = i2;
        end;

        task.wait(p47 / #p45);
    end;

    task.wait(3);

    for _, v in v49 do
        v:Dispose();
    end;
end;

function v1.FloatingRocks(u63: vector, p64: number, p65: vector, p66: number, p67: number, p68: number, p69: number, p70: number) -- Line: 252
    -- upvalues: script_PartCache (copy), TweenService (copy)
    local RaycastParams_new_ret = RaycastParams.new();
    RaycastParams_new_ret.FilterType = Enum.RaycastFilterType.Include;
    RaycastParams_new_ret.FilterDescendantsInstances = { workspace.Map };
    local u71 = p64 or 5;
    local u72 = p65 or Vector3.new(1, 1, 1);
    local u73 = p66 or 1;
    local u74 = p67 or 5;
    local u75 = p68 or 8;
    local u76 = p69 or 0.5;
    local u77 = p70 or 1;
    local Part = Instance.new("Part");
    Part.Anchored = true;
    Part.CanCollide = false;
    Part.CanTouch = false;
    Part.CanQuery = false;
    local u78 = script_PartCache.new(Part, u75, folder);
    task.spawn(function() -- Line: 273
        -- upvalues: u75 (ref), u71 (ref), u77 (ref), u63 (copy), RaycastParams_new_ret (copy), u78 (copy), u72 (ref), TweenService (ref), u73 (ref), u74 (ref), u76 (ref)
        for i = 1, u75 do
            local v79 = math.random((u71 - u77 * u71) * 100, u71 * 100) / 100;
            local v80 = math.random((u71 - u77 * u71) * 100, u71 * 100) / 100;

            if math.random(1, 2) == 1 then
                v79 = -v79;
            end;

            if math.random(1, 2) == 1 then
                v80 = -v80;
            end;

            local v81 = u63 + Vector3.new(v79, 0, v80);
            local v82 = workspace:Raycast(v81, Vector3.new(0, -15, 0), RaycastParams_new_ret);

            if v82 then
                local Part2 = u78:GetPart();
                Part2.Material = v82.Material;
                Part2.Color = v82.Instance.Color;
                Part2.Position = v81;
                local math_random_ret = math.random(-180, 180);
                local math_random_ret2 = math.random(-180, 180);
                Part2.Orientation = Vector3.new(math_random_ret, math_random_ret2, math.random(-180, 180));
                Part2.Size = u72 * (math.random(80, 120) / 100);
                local TweenInfo_new_ret = TweenInfo.new(u73 * (math.random(80, 120) / 100));
                local v83 = {
                    Transparency = 1
                };
                local Position = Part2.Position;
                local v84 = u74 * (math.random(80, 120) / 100);
                v83.Position = Position + Vector3.new(0, v84, 0);
                TweenService:Create(Part2, TweenInfo_new_ret, v83):Play();
            end;

            task.wait(u76);
            local _ = i;
        end;
    end);
    task.delay(u73 + 2, function() -- Line: 306
        -- upvalues: u78 (copy)
        u78:Dispose();
    end);
end;

return v1;