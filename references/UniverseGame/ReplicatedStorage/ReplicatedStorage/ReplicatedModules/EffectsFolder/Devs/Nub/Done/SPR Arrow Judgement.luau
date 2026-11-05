  

 

local TweenService = game:GetService("TweenService");
local u1 = game:GetService("ReplicatedStorage")["Client Assets"];
local PathShortcuts = require(game.ReplicatedStorage.ReplicatedModules.PathShortcuts);
local ParticleHandler = require(PathShortcuts.ReplicatedModules.ReplicatedLibrary.ParticleHandler);
local Angles = CFrame.Angles;
local cos = math.cos;
local sin = math.sin;
local rad = math.rad;
local _ = math.random;

local function getang(p2, p3) -- Line: 12
    -- upvalues: cos (copy), sin (copy)
    return { cos(p2) * p3, sin(p2) * p3 };
end;

local function tweendeb(p4, p5) -- Line: 15
    p4:Play();
    p4.Completed:Wait();

    if p5 then
        p5:Destroy();
    end;

    return true;
end;

return function(p6, u7, u8) -- Line: 21
    -- upvalues: u1 (copy), rad (copy), cos (copy), sin (copy), ParticleHandler (copy), TweenService (copy), Angles (copy)
    local u9;

    if u1:FindFirstChild(p6.StandName) then
        u9 = u1[p6.StandName];
    else
        u9 = u1["Star Platinum Requiem"];
    end;

    local reqeffect = u9.reqeffect;
    local ArrowData = p6.ArrowData;
    local v10 = 15 * (reqeffect.Size * 1.5).Y / 2;
    local v11 = {};

    for i = 0, 3 do
        local v12 = 0.7853981633974483 + rad(i * 90);
        local v13 = { cos(v12) * v10, sin(v12) * v10 };
        local v14 = Vector3.new(v13[1], v13[2], 0);
        local v15 = reqeffect:Clone();
        v15.Color = ParticleHandler.TryHSVShift(ArrowData.StartColor, u8);
        ParticleHandler.Unusualify(v15, {
            IncludeParts = true,
            HSVData = u8
        });
        v15.Size = v15.Size * 3;
        v15.CFrame = CFrame.new(u7.Position + v14, u7.Position) * ArrowData.Angle;
        v15.Parent = workspace.Effects;
        table.insert(v11, v15);
    end;

    local u16 = #v11;

    for i, v in ipairs(v11) do
        task.spawn(function() -- Line: 47
            -- upvalues: TweenService (ref), v (copy), u7 (copy), i (copy), u16 (ref), u9 (ref), ArrowData (copy), ParticleHandler (ref), u8 (copy), Angles (ref), rad (ref)
            local v17 = TweenService:Create(v, TweenInfo.new(0.3), {
                Position = u7.CFrame.Position
            });
            v17:Play();
            v17.Completed:Wait();
            v:Destroy();

            if i == u16 then
                local u18 = u9.spr1:Clone();

                if ArrowData.itemcolor then
                    for i2, child in ipairs(u18:GetChildren()) do
                        child.Color = ParticleHandler.TryHSVShift(ArrowData.itemcolor[i2], u8);
                    end;
                end;

                ParticleHandler.Unusualify(u18, {
                    IncludeParts = true,
                    HSVData = u8
                });
                local Core = u18.Core;
                Core.CFrame = u7.CFrame;
                u18.Parent = workspace.Effects;
                u16 = #u18:GetChildren();
                local u19 = nil;
                task.spawn(function() -- Line: 65
                    -- upvalues: u19 (ref), Core (copy), Angles (ref), rad (ref)
                    while not u19 do
                        local v20 = Core;
                        v20.CFrame = v20.CFrame * Angles(0, rad(20 + wait()), 0);
                    end;
                end);

                for i2, child in ipairs(u18:GetChildren()) do
                    task.spawn(function() -- Line: 67
                        -- upvalues: TweenService (ref), child (copy), ArrowData (ref), i2 (copy), u16 (ref), u19 (ref), u18 (copy)
                        local v21 = TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Linear), {
                            Transparency = 1,
                            Size = child.Size * ArrowData.Size,
                            Color = ArrowData.EndColor
                        });
                        v21:Play();
                        v21.Completed:Wait();

                        if i2 == u16 then
                            u19 = true;
                            u18:Destroy();
                        end;
                    end);
                end;
            end;
        end);
    end;
end;