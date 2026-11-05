  

 

local Players = game:GetService("Players");
local TweenService = game:GetService("TweenService");
game:GetService("Lighting");
local ReplicatedStorage = game:GetService("ReplicatedStorage");
game:GetService("RunService");
local _ = ReplicatedStorage["Client Assets"];
local _ = Players.LocalPlayer;

return function(p1) -- Line: 11
    -- upvalues: TweenService (copy)
    local v2 = p1 or {};
    local Whitelist = v2.Whitelist;
    local u3 = v2.Delay or 0;
    local u4 = v2.Lifetime or 0.5;
    local Offset = v2.Offset;
    local u5 = { "Model", "LocalScript", "Script", "Sound", "Folder" };

    if v2.Blacklist then
        for _, v in pairs(v2.Blacklist) do
            table.insert(u5, v);
        end;
    end;

    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    os.clock();

    local function ImportObject(p6) -- Line: 31
        -- upvalues: Model (copy), u5 (copy), TweenService (ref), u4 (copy), u3 (copy)
        if not p6.Archivable then
            return;
        end;

        local v7 = p6:Clone();
        v7.Parent = Model;

        for _, child in pairs(v7:GetChildren()) do
            if table.find(u5, child.ClassName) then
                child:Destroy();
            end;
        end;

        if v7:IsA("Humanoid") then
            v7.DisplayDistanceType = "None";
            v7.HealthDisplayType = "AlwaysOff";
        end;

        for _, descendant in pairs(v7:GetDescendants()) do
            if descendant:IsA("Motor6D") or descendant:IsA("Weld") then
                descendant:Destroy();
            end;
        end;

        if v7:IsA("Accessory") then
            v7 = v7:FindFirstChild("handle") or v7:FindFirstChild("Handle");
            p6 = p6:FindFirstChild("handle") or p6:FindFirstChild("Handle");
        end;

        if v7:IsA("BasePart") then
            if v7.Name == "HumanoidRootPart" then
                for _, _ in pairs(v7:GetChildren()) do
                    v7:Destroy();
                end;

                Model.PrimaryPart = v7;
            end;

            v7.CanCollide = false;
            v7.Anchored = true;
            v7.CFrame = p6.CFrame;
            v7.CollisionGroup = "FX";
            v7.CastShadow = false;
            TweenService:Create(v7, TweenInfo.new(u4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, 0, false, u3), {
                Transparency = 1
            }):Play();
        end;
    end;

    if Whitelist then
        for i = 1, #Whitelist do
            for _, child in pairs(Whitelist[i]:GetChildren()) do
                if not (table.find(u5, child.ClassName) or table.find(u5, child.Name)) then
                    ImportObject(child);
                end;
            end;
        end;
    end;

    if Offset then
        Model:PivotTo(Model.PrimaryPart.CFrame * Offset);
    end;

    task.wait(u3 + u4);
    Model:Destroy();
end;