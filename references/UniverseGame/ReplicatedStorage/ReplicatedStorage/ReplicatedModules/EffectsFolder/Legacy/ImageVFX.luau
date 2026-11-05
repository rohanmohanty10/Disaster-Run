  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local u1 = ReplicatedStorage["Client Assets"];

return function(p2, p3, p4) -- Line: 6
    -- upvalues: u1 (copy), TweenService (copy)
    local v5 = p4.Offset or CFrame.new(0, 0, 0);
    local v6 = p4.Goal or CFrame.new(0, 0, 0);
    local Speed = p4.Speed;
    local Size = p4.Size;
    local v7 = u1.Universal.ImageVFX:Clone();
    v7.Size = Size or v7.Size;

    if typeof(p2) == "CFrame" then
        return;
    end;

    local Motor6D = Instance.new("Motor6D");
    Motor6D.Parent = v7;
    Motor6D.Part0 = p2;
    Motor6D.Part1 = v7;
    Motor6D.C0 = v5;

    for _, child in pairs(v7:GetChildren()) do
        if child:IsA("Decal") then
            child.Texture = "rbxassetid://" .. p3;
            coroutine.wrap(function() -- Line: 28
                -- upvalues: TweenService (ref), child (copy), Speed (copy)
                wait(0.05);
                TweenService:Create(child, TweenInfo.new(Speed), {
                    Transparency = 1,
                    Color3 = Color3.fromRGB(600, 600, 600)
                }):Play();
            end)();
        end;
    end;

    v7.Parent = workspace.Effects;
    TweenService:Create(Motor6D, TweenInfo.new(Speed), {
        C0 = v6
    }):Play();
    wait(Speed);
    v7:Destroy();
end;