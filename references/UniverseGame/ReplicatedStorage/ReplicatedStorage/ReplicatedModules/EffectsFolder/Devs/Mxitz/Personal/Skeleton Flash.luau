  

 

local ReplicatedStorage = game:GetService("ReplicatedStorage");
local TweenService = game:GetService("TweenService");
local Trove = require(ReplicatedStorage.ReplicatedRoot.Libraries.Classes.Trove);
require(ReplicatedStorage.ReplicatedModules.Signal);
local Skeleton = script.Skeleton;

local function GetParts(p1) -- Line: 9
    if typeof(p1) == "table" then
        return p1;
    end;

    if p1 == "All" then
        return { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };
    end;

    if p1 == "Legs" then
        return { "Left Leg", "Right Leg" };
    end;

    if p1 == "Arms" then
        return { "Left Arm", "Right Arm" };
    end;

    if p1 == nil then
        return { "Head", "Torso", "Left Arm", "Right Arm", "Left Leg", "Right Leg" };
    end;

    error((`i got a headache idk what to call this : {p1}`));
end;

return function(u2, p3) -- Line: 25
    -- upvalues: GetParts (copy), Trove (copy), TweenService (copy), Skeleton (copy)
    if not u2:IsDescendantOf(workspace) then
        return;
    end;

    local v4 = p3 or {};
    local v5 = GetParts(v4.Parts);
    local v6 = v4.BindToRagdoll or false;
    local v7 = v4.Timeout or 0.4;
    local u8 = v4.FlashTime or 0.3;
    local u9 = Trove.new();
    local Model = Instance.new("Model");
    Model.Parent = workspace.Effects;
    local Highlight = Instance.new("Highlight");
    Highlight.FillColor = Color3.fromRGB(255, 0, 0);
    Highlight.OutlineTransparency = 1;
    Highlight.Parent = Model;
    local u10 = TweenService:Create(Highlight, TweenInfo.new(0.3, Enum.EasingStyle.Sine, Enum.EasingDirection.Out, -1, true), {
        FillTransparency = 0
    });
    u10:Play();
    local u11 = {};

    for _, v in v5 do
        task.spawn(function() -- Line: 55
            -- upvalues: u2 (copy), v (copy), Skeleton (ref), Model (copy), u11 (copy)
            local v12 = u2:FindFirstChild(v);

            if not v12 then
                return;
            end;

            v12.Transparency = 0.5;
            local v13 = Skeleton:FindFirstChild(v12.Name):Clone();
            local Weld = Instance.new("Weld");
            Weld.Part0 = v12;
            Weld.Part1 = v13;
            Weld.Parent = v13;
            v13.Parent = Model;
            table.insert(u11, {
                Original = v12,
                Skeleton = v13
            });
        end);
    end;

    if v6 then
        u9:Connect(u2:GetAttributeChangedSignal("Ragdolled"), function() -- Line: 81
            -- upvalues: u2 (copy), u9 (copy)
            if u2:GetAttribute("Ragdolled") ~= nil then
                return;
            end;

            u9:Destroy();
        end);
    end;

    u9:Add(task.delay(v7, u9.Destroy, u9));
    u9:Add(function() -- Line: 92
        -- upvalues: u2 (copy), u10 (copy), TweenService (ref), Highlight (copy), u8 (copy), u11 (copy), Model (copy)
        if u2 == nil or not u2:IsDescendantOf(workspace) then
            return;
        end;

        u10:Cancel();
        local v14 = TweenService:Create(Highlight, TweenInfo.new(u8, Enum.EasingStyle.Sine, Enum.EasingDirection.InOut), {
            FillTransparency = 1
        });
        v14:Play();
        v14.Completed:Wait();

        for _, v in u11 do
            v.Original.Transparency = 0;
            v.Skeleton:Destroy();
        end;

        task.wait(u8);
        Model:Destroy();
    end);
end;