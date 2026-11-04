 
 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
require(ReplicatedStorage.Shared.Utility.Essentials);
require(ReplicatedStorage.Shared.Utility.VfxManager);
require(ReplicatedStorage.Shared.Utility.CameraShaker);
local _ = game.Players.LocalPlayer;

function EnableVFX(p1: userdata, p2: boolean?)
    for _, v in next, p1:GetDescendants() do
        if v.ClassName == "ParticleEmitter" then
            v.Enabled = p2 or false;
        end;
    end;
end;

function EmitAll(p3: table)
    for _, v in next, p3 do
        if v.ClassName == "ParticleEmitter" then
            if v:GetAttribute("EmitDelay") then
                task.delay(v:GetAttribute("EmitDelay"), function() -- Line: 22
                    -- upvalues: v (copy)
                    v:Emit(v:GetAttribute("EmitCount"));
                end);
            else
                v:Emit(v:GetAttribute("EmitCount"));
            end;
        end;
    end;
end;

local function Destroy_Effect(u4: userdata, p5: number) -- Line: 32
    task.delay(p5, function() -- Line: 33
        -- upvalues: u4 (copy)
        u4:Destroy();
    end);
end;

local function Random_Number(p6, p7) -- Line: 38
    return Random.new():NextNumber(p6, p7);
end;

return function(p8, p9) -- Line: 42
    -- upvalues: TweenService (copy)
    local u10 = script.Music_Effect:Clone();
    u10.Parent = workspace.Debris;
    u10:PivotTo(p9.CFrame);
    EmitAll(u10.Root:GetDescendants());

    for i = 1, 5 do
        local v11 = i;

        for _, child in u10.Speaker:GetChildren() do
            if child:IsA("MeshPart") then
                local Highlight = Instance.new("Highlight");
                Highlight.DepthMode = Enum.HighlightDepthMode.Occluded;
                Highlight.OutlineColor = Color3.new(1, 1, 1);
                Highlight.OutlineTransparency = 0;
                Highlight.FillColor = Color3.new(1, 0, 0);
                Highlight.FillTransparency = 1;
                Highlight.Parent = child;
                local Size = child.Size;
                EmitAll(child.Emit:GetDescendants());
                EnableVFX(child, true);
                local v12 = Random.new():NextNumber(1.01, 1.25);
                local v13 = Random.new():NextNumber(0.01, 0.15);
                local v14 = TweenService:Create(child, TweenInfo.new(v13, Enum.EasingStyle.Bounce), {
                    Size = Size * v12
                });
                v14:Play();
                v14.Completed:Connect(function() -- Line: 74
                    -- upvalues: TweenService (ref), child (copy), Size (copy)
                    TweenService:Create(child, TweenInfo.new(0.06, Enum.EasingStyle.Bounce), {
                        Size = Size
                    }):Play();
                end);
                task.wait(v13 + 0.05);

                if v11 == 5 then
                    EnableVFX(child, false);
                    task.delay(0.5, function() -- Line: 82
                        -- upvalues: TweenService (ref), child (copy)
                        TweenService:Create(child, TweenInfo.new(0.5, Enum.EasingStyle.Bounce), {
                            Size = Vector3.new(0, 0, 0)
                        }):Play();
                        task.wait(0.5);
                        child:Destroy();
                    end);
                end;
            end;
        end;
    end;

    task.delay(1, function() -- Line: 92
        -- upvalues: u10 (copy)
        u10:Destroy();
    end);
end;