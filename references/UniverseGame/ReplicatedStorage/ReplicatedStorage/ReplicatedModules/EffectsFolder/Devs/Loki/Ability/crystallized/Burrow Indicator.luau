  

 

local TweenService = game:GetService("TweenService");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
local _ = ReplicatedStorage["Client Assets"];
local AssetHandler = require(ReplicatedStorage.ReplicatedModules.ReplicatedLibrary.AssetHandler);
local RunService = game:GetService("RunService");

local function Lerp(p1, p2, p3) -- Line: 8
    return p1 + (p2 - p1) * p3;
end;

return function(p4) -- Line: 13
    -- upvalues: AssetHandler (copy), TweenService (copy), RunService (copy)
    local v5 = p4.Part or error("No origin part");
    local v6 = p4.Duration or 1;
    local v7 = p4.Distance or 36;
    local v8 = p4.Color or Color3.new(1, 1, 1);
    local v9 = p4.Offset or CFrame.identity;
    local Attribute = p4.Attribute;
    local Character = p4.Character;
    local Attachment = Instance.new("Attachment");
    Attachment.CFrame = v9 * CFrame.Angles(0, 0, 1.5707963267948966);
    Attachment.Parent = v5;
    task.delay(v6, Attachment.Destroy, Attachment);
    local v10 = Attachment:Clone();
    v10.Parent = v5;
    task.delay(v6, v10.Destroy, v10);
    local v11 = AssetHandler.GetAsset("Particles/Mes/Indicator", {
        AbilityName = "Ope"
    }):Clone();
    v11.Color = ColorSequence.new(v8);
    v11.Attachment0 = Attachment;
    v11.Attachment1 = v10;
    v11.Parent = workspace.Effects;
    task.delay(v6, v11.Destroy, v11);
    local v12 = TweenService:Create(v11, TweenInfo.new(0.1, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
        Width0 = 0,
        Width1 = 0
    });
    task.delay(v6 * 0.85, v12.Play, v12);

    if Attribute then
        local v13 = os.clock();

        while Character:GetAttribute(Attribute) and os.clock() - v13 <= v6 do
            local v14 = RunService.RenderStepped:Wait();
            local v15 = os.clock() - v13;
            local v16 = math.clamp(v15, 0, 1);
            local v17 = v5.Position + (workspace.CurrentCamera.CFrame.LookVector * Vector3.new(1, 0, 1)).Unit * (0 + (v7 - 0) * v16) - Vector3.new(0, 2.5, 0);
            Attachment.WorldCFrame = CFrame.new(v5.Position, v17) * v9 * CFrame.Angles(0, 0, 1.5707963267948966);
            v10.WorldCFrame = v10.WorldCFrame:Lerp(CFrame.new(v17, Attachment.WorldPosition) * CFrame.Angles(0, 3.141592653589793, 1.5707963267948966), v14 * 25);
        end;
    end;
end;