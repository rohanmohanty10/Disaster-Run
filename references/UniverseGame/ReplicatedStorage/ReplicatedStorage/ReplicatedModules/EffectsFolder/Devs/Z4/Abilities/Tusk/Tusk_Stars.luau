  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local ParticleHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.ParticleHandler);

return function(p1, p2) -- Line: 6
    -- upvalues: ParticleHandler (copy), TweenService (copy)
    local v3 = p2 or {};
    local GoldenSpin = v3.GoldenSpin;
    local u4 = TweenInfo.new(v3.Time or 0.25, v3.EasingStyle or Enum.EasingStyle.Cubic, v3.EasingDirection or Enum.EasingDirection.Out, 0, true);

    local function CreateStars(p5) -- Line: 16
        -- upvalues: GoldenSpin (copy), ParticleHandler (ref), TweenService (ref), u4 (copy)
        local v6 = p5.Name == "Right Arm";
        local u7 = script.Arm:Clone();
        u7.Parent = workspace.Effects;

        if GoldenSpin then
            u7.Stars.Color = Color3.fromRGB(239, 184, 56);
        end;

        local AttachTo = ParticleHandler.AttachTo;
        local v8 = {
            Part = p5
        };

        if v6 then
            v6 = CFrame.Angles(0, 3.141592653589793, 0);
        end;

        v8.Offset = v6;
        AttachTo(u7, v8);
        local v9 = TweenService:Create(u7.Stars, u4, {
            Transparency = 0
        });
        v9:Play();
        v9.Completed:Connect(function() -- Line: 33
            -- upvalues: u7 (copy)
            u7:Destroy();
        end);
    end;

    if typeof(p1) == "table" then
        for _, v in p1 do
            CreateStars(v);
        end;

        return;
    end;

    CreateStars(p1);
end;