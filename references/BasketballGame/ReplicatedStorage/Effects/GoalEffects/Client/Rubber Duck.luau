 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
require(ReplicatedStorage.Shared.Utility.Essentials);
local VfxManager = require(ReplicatedStorage.Shared.Utility.VfxManager);
local SfxManager = require(ReplicatedStorage.Shared.Utility.SfxManager);
local script_Scale = require(script.Scale);
local Debris = workspace:FindFirstChild("Debris");

return function(p1, p2) -- Line: 14
    -- upvalues: SfxManager (copy), Debris (copy), script_Scale (copy), TweenService (copy), VfxManager (copy)
    if not p2.Preview then
        SfxManager:playSound({
            Sound = "Rubber Duck",
            Parent = workspace
        });
        local u3 = script.Duck:Clone();
        u3.Parent = Debris;
        u3:PivotTo(p2.CFrame);
        local NumberValue = Instance.new("NumberValue", u3.Duck);
        NumberValue.Value = 1;
        NumberValue.Changed:Connect(function() -- Line: 24
            -- upvalues: u3 (copy), NumberValue (copy)
            u3.Duck.Model:ScaleTo(NumberValue.Value);
        end);

        for i, v in pairs(script_Scale) do
            local u4, u5 = next(script_Scale, i);

            if u4 and u5 then
                task.delay(i / 60, function() -- Line: 32
                    -- upvalues: NumberValue (copy), v (copy), TweenService (ref), u4 (copy), i (copy), u5 (copy)
                    NumberValue.Value = v;
                    TweenService:Create(NumberValue, TweenInfo.new(u4 / 60 - i / 60), {
                        Value = u5
                    }):Play();
                end);
            end;
        end;

        u3.Duck.AnimationController:LoadAnimation(script.Animation):Play();
        u3.Duck.Model.PrimaryPart.Transparency = 0;
        VfxManager.Emit(u3.Goal);
        task.wait(3.9833333333333334);
        u3.Duck.Model.PrimaryPart.Transparency = 1;
        VfxManager.Emit(u3.Confetti);
        VfxManager.DestroyEffect(u3, 2);

        return;
    end;

    local Attachment = Instance.new("Attachment");
    Attachment.Parent = workspace.Terrain;
    Attachment.WorldPosition = p2.CFrame.Position;
    SfxManager:playSound({
        Sound = "Rubber Duck",
        Parent = Attachment
    }).Ended:Once(function() -- Line: 56
        -- upvalues: Attachment (copy)
        Attachment:Destroy();
    end);
    local u6 = script.Duck:Clone();
    u6.Parent = Debris;
    u6:PivotTo(p2.CFrame * CFrame.Angles(0, -1.5707963267948966, 0));
    u6:ScaleTo(0.3333333333333333);
    local NumberValue = Instance.new("NumberValue", u6.Duck);
    NumberValue.Value = 1;
    NumberValue.Changed:Connect(function() -- Line: 67
        -- upvalues: u6 (copy), NumberValue (copy)
        u6.Duck.Model:ScaleTo(NumberValue.Value / 3);
    end);

    for i, v in pairs(script_Scale) do
        local u7, u8 = next(script_Scale, i);

        if u7 and u8 then
            task.delay(i / 60, function() -- Line: 75
                -- upvalues: NumberValue (copy), v (copy), TweenService (ref), u7 (copy), i (copy), u8 (copy)
                NumberValue.Value = v;
                TweenService:Create(NumberValue, TweenInfo.new(u7 / 60 - i / 60), {
                    Value = u8
                }):Play();
            end);
        end;
    end;

    u6.Duck.AnimationController:LoadAnimation(script.Animation):Play();
    u6.Duck.Model.PrimaryPart.Transparency = 0;
    VfxManager.Emit(u6.Goal);
    task.wait(3.9833333333333334);
    u6.Duck.Model.PrimaryPart.Transparency = 1;
    VfxManager.Emit(u6.Confetti);
    VfxManager.DestroyEffect(u6, 2);
end;