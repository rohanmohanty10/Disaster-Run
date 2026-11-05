  

 

local TweenService = game:GetService("TweenService");
local RunService = game:GetService("RunService");
local JCESDistortModel = game:GetService("ReplicatedStorage")["Client Assets"].Assets.Abilities.Vergil.JCE.JCESDistortModel;
local CurrentCamera = workspace.CurrentCamera;
local u1 = Random.new();

return function(p2) -- Line: 10
    -- upvalues: RunService (copy), CurrentCamera (copy), TweenService (copy), JCESDistortModel (copy), u1 (copy)
    local u3 = p2 or {};
    local u4 = {};
    local v5;

    if u3.locked == false then
        v5 = nil;
    else
        v5 = RunService.RenderStepped:Connect(function(p6) -- Line: 17
            -- upvalues: u4 (copy), CurrentCamera (ref)
            for _, v in u4 do
                v[1].CFrame = CurrentCamera.CFrame * v[2];
            end;
        end);
    end;

    local u7 = u3.out_time or 0.13333333333333333;

    local function ExpandThenShrink(u8) -- Line: 30
        -- upvalues: TweenService (ref), u7 (copy)
        local Y = u8.Size.Y;
        local Z = u8.Size.Z;
        u8.Size = u8.Size * Vector3.new(1, 0, 0);
        local v9 = TweenService:Create(u8, TweenInfo.new(0.13333333333333333, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
            Size = u8.Size + Vector3.new(0, Y, Z)
        });
        v9:Play();
        v9.Completed:Once(function() -- Line: 39
            -- upvalues: TweenService (ref), u8 (copy), u7 (ref)
            TweenService:Create(u8, TweenInfo.new(u7, Enum.EasingStyle.Cubic, Enum.EasingDirection.Out), {
                Size = u8.Size * Vector3.new(1, 0, 0)
            }):Play();
        end);
    end;

    for i = 1, u3.amount or 10 do
        if i > 0 and i % 10 == 0 then
            task.wait(0.08333333333333333);
        end;

        task.spawn(function() -- Line: 50
            -- upvalues: JCESDistortModel (ref), u1 (ref), CurrentCamera (ref), u4 (copy), ExpandThenShrink (copy), u3 (ref)
            local v10 = JCESDistortModel:Clone();
            local v11 = CFrame.new(u1:NextInteger(-30, 30), u1:NextInteger(-5, 10), u1:NextInteger(-30, -5));
            local Angles = CFrame.Angles;
            local v12 = u1:NextInteger(-360, 360);
            local v13 = math.rad(v12);
            local v14 = u1:NextInteger(-360, 360);
            local v15 = math.rad(v14);
            local v16 = u1:NextInteger(-360, 360);
            local v17 = v11 * Angles(v13, v15, (math.rad(v16)));
            v10.PrimaryPart.CFrame = CurrentCamera.CFrame * v17;
            table.insert(u4, { v10.PrimaryPart, v17 });
            ExpandThenShrink(v10.JCEGlassDistort);
            ExpandThenShrink(v10.JCESlashDistort);
            v10.Parent = workspace.Effects;

            if u3.cache then
                table.insert(u3.cache, v10);
            end;

            task.delay(1, v10.Destroy, v10);
        end);
    end;

    if v5 then
        task.delay(0.5, v5.Disconnect, v5);
    end;
end;